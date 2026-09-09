using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DulceCafeParcial
{
    public partial class Factura : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnCalculate_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }
            string custName = (txtCustomerName.Text ?? string.Empty).Trim();
            string custEmail = (txtCustomerEmail.Text ?? string.Empty).Trim();
            string custPhone = (txtCustomerPhone.Text ?? string.Empty).Trim();
            string invoiceNumber = (txtInvoiceNumber.Text ?? string.Empty).Trim();
            string invoiceDate = (txtInvoiceDate.Text ?? string.Empty).Trim();
            string description = (txtDescription.Text ?? string.Empty).Trim();
            var culture = System.Globalization.CultureInfo.InvariantCulture;

            var cart = Session["Cart"] as System.Data.DataTable;
            if (cart == null || cart.Rows.Count == 0)
            {
                lblCalcMessage.CssClass = "error";
                lblCalcMessage.Text = "El carrito está vacío. Agregue al menos un producto.";
                return;
            }

            decimal subtotalUSD = 0m;
            foreach (System.Data.DataRow row in cart.Rows)
            {
                if (decimal.TryParse(row["SubtotalUSD"].ToString(), System.Globalization.NumberStyles.Number, culture, out decimal lineSub))
                {
                    subtotalUSD += lineSub;
                }
            }

            bool okDisc = decimal.TryParse(txtDiscount.Text, System.Globalization.NumberStyles.Number, culture, out decimal discountPct);
            if (!okDisc || discountPct < 0 || discountPct > 100)
            {
                lblCalcMessage.CssClass = "error";
                lblCalcMessage.Text = "El descuento debe estar entre 0 y 100.";
                return;
            }
            decimal discountValueUSD = subtotalUSD * discountPct / 100m;
            decimal afterDiscountUSD = subtotalUSD - discountValueUSD;
            decimal ivaUSD = afterDiscountUSD * 19m / 100m;
            decimal totalUSD = afterDiscountUSD + ivaUSD;

            string displayCurrency = ddlCurrency.SelectedValue ?? "USD";
            decimal rateToUSD = GetRateToUSD(displayCurrency);
            decimal rateFromUSD = rateToUSD > 0 ? 1m / rateToUSD : 1m;
            var displayCulture = GetCultureForCurrency(displayCurrency);

            lblProduct.Text = "Varios artículos";
            lblSubtotal.Text = (subtotalUSD * rateFromUSD).ToString("C2", displayCulture);
            lblDiscountValue.Text = (discountValueUSD * rateFromUSD).ToString("C2", displayCulture);
            lblAfterDiscount.Text = (afterDiscountUSD * rateFromUSD).ToString("C2", displayCulture);
            lblIVA.Text = (ivaUSD * rateFromUSD).ToString("C2", displayCulture);
            lblTotal.Text = (totalUSD * rateFromUSD).ToString("C2", displayCulture);

            lblCalcMessage.CssClass = "note";
            lblCalcMessage.Text = "Cálculo realizado correctamente.";
        }

        protected void btnAddToCart_Click(object sender, EventArgs e)
        {
            var culture = System.Globalization.CultureInfo.InvariantCulture;

            if (!int.TryParse(txtQuantity.Text, out int qty) || qty <= 0)
            {
                lblCalcMessage.CssClass = "error";
                lblCalcMessage.Text = "Ingrese una cantidad válida (mayor que cero).";
                return;
            }

            if (!decimal.TryParse(txtUnitPrice.Text, System.Globalization.NumberStyles.Number, culture, out decimal unitPrice) || unitPrice < 0)
            {
                lblCalcMessage.CssClass = "error";
                lblCalcMessage.Text = "Ingrese un precio unitario válido.";
                return;
            }

            string product = ddlProduct.SelectedValue;
            string presentation = ddlPresentation.SelectedValue;
            string presentationDesc = GetPresentationDescription(presentation);

            string currency = ddlCurrency.SelectedValue ?? "USD";
            decimal rateToUSD = GetRateToUSD(currency);
            decimal unitPriceUSD = unitPrice * rateToUSD;
            decimal lineSubtotalUSD = unitPriceUSD * qty;

            var cart = Session["Cart"] as System.Data.DataTable;
            if (cart == null)
            {
                cart = new System.Data.DataTable();
                cart.Columns.Add("Product", typeof(string));
                cart.Columns.Add("Presentation", typeof(string));
                cart.Columns.Add("PresentationFull", typeof(string));
                cart.Columns.Add("Quantity", typeof(int));
                // store canonical values in USD for consistent calculations
                cart.Columns.Add("UnitPriceUSD", typeof(decimal));
                cart.Columns.Add("SubtotalUSD", typeof(decimal));
                cart.Columns.Add("Currency", typeof(string));
                // display columns (formatted strings) will be prepared before binding
                cart.Columns.Add("UnitPriceDisplay", typeof(string));
                cart.Columns.Add("SubtotalDisplay", typeof(string));
            }

            var row = cart.NewRow();
            row["Product"] = product;
            row["Presentation"] = presentation;
            row["PresentationFull"] = presentation + " (" + presentationDesc + ")";
            row["Quantity"] = qty;
            row["UnitPriceUSD"] = unitPriceUSD;
            row["SubtotalUSD"] = lineSubtotalUSD;
            row["Currency"] = currency;
            cart.Rows.Add(row);

            Session["Cart"] = cart;
            PrepareCartDisplay(cart, ddlCurrency.SelectedValue);
            gvCart.DataSource = cart;
            gvCart.DataBind();

            lblCalcMessage.CssClass = "note";
            lblCalcMessage.Text = "Producto agregado al carrito.";
        }

        protected void gvCart_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Remove")
            {
                int index = Convert.ToInt32(e.CommandArgument);
                var cart = Session["Cart"] as System.Data.DataTable;
                if (cart != null && index >= 0 && index < cart.Rows.Count)
                {
                    cart.Rows.RemoveAt(index);
                    Session["Cart"] = cart;
                    gvCart.DataSource = cart;
                    gvCart.DataBind();
                }
            }
        }

        private string GetPresentationDescription(string presentation)
        {
            if (string.IsNullOrEmpty(presentation)) return string.Empty;
            switch (presentation.ToLowerInvariant())
            {
                case "unidad": return "unidad";
                case "caja": return "caja (box)";
                case "porción":
                case "porcion": return "porción (slice)";
                case "vaso": return "vaso (cup)";
                default: return presentation;
            }
        }

        private decimal GetRateToUSD(string currency)
        {
            // rate = how many USD equals 1 unit of currency
            switch ((currency ?? "USD").ToUpperInvariant())
            {
                case "COP": return 0.00025m; // approx 1 COP = 0.00025 USD (1 USD ~= 4000 COP)
                case "GBP": return 1.25m;    // 1 GBP = 1.25 USD
                case "USD":
                default: return 1.0m;
            }
        }

        private void PrepareCartDisplay(System.Data.DataTable cart, string displayCurrency)
        {
            var culture = GetCultureForCurrency(displayCurrency ?? "USD");
            decimal rateToUSD = GetRateToUSD(displayCurrency ?? "USD");
            decimal rateFromUSD = rateToUSD > 0 ? 1m / rateToUSD : 1m;

            if (!cart.Columns.Contains("UnitPriceDisplay")) cart.Columns.Add("UnitPriceDisplay", typeof(string));
            if (!cart.Columns.Contains("SubtotalDisplay")) cart.Columns.Add("SubtotalDisplay", typeof(string));

            foreach (System.Data.DataRow row in cart.Rows)
            {
                if (decimal.TryParse(row["UnitPriceUSD"].ToString(), System.Globalization.NumberStyles.Number, System.Globalization.CultureInfo.InvariantCulture, out decimal upu))
                {
                    decimal displayUnit = upu * rateFromUSD;
                    row["UnitPriceDisplay"] = displayUnit.ToString("C2", culture);
                }
                if (decimal.TryParse(row["SubtotalUSD"].ToString(), System.Globalization.NumberStyles.Number, System.Globalization.CultureInfo.InvariantCulture, out decimal sdu))
                {
                    decimal displaySub = sdu * rateFromUSD;
                    row["SubtotalDisplay"] = displaySub.ToString("C2", culture);
                }
            }
        }

        private System.Globalization.CultureInfo GetCultureForCurrency(string currency)
        {
            switch ((currency ?? "USD").ToUpperInvariant())
            {
                case "COP": return System.Globalization.CultureInfo.GetCultureInfo("es-CO");
                case "GBP": return System.Globalization.CultureInfo.GetCultureInfo("en-GB");
                case "USD":
                default: return System.Globalization.CultureInfo.GetCultureInfo("en-US");
            }
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtCustomerName.Text = string.Empty;
            txtCustomerEmail.Text = string.Empty;
            txtCustomerPhone.Text = string.Empty;
            txtInvoiceNumber.Text = string.Empty;
            txtInvoiceDate.Text = string.Empty;
            ddlProduct.SelectedIndex = 0;
            ddlPresentation.SelectedIndex = 0;
            txtDescription.Text = string.Empty;
            txtQuantity.Text = string.Empty;
            txtUnitPrice.Text = string.Empty;
            txtDiscount.Text = string.Empty;

            lblProduct.Text = string.Empty;
            lblSubtotal.Text = string.Empty;
            lblDiscountValue.Text = string.Empty;
            lblAfterDiscount.Text = string.Empty;
            lblIVA.Text = string.Empty;
            lblTotal.Text = string.Empty;
            lblCalcMessage.Text = string.Empty;
        }

        protected void btnContinue_Click(object sender, EventArgs e)
        {
            Response.Redirect("Encuesta.aspx", false);
        }
    }
}