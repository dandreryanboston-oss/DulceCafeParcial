<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Factura.aspx.cs" Inherits="DulceCafeParcial.Factura" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Factura — Dulce &amp; Café</title>
    <style>
        :root{--paper:#fff;--accent:#D98B6A;--brown:#5A3A2F;--muted:#7b6e6a}
        body{margin:0;font-family:Segoe UI, Tahoma, Geneva, Verdana, sans-serif;background:linear-gradient(180deg,#fffdfb 0%,#fff 70%);color:var(--brown)}
        .container{max-width:1100px;margin:28px auto;padding:18px}
        .header{display:flex;align-items:center;justify-content:space-between;margin-bottom:18px}
        .brand{display:flex;align-items:center;gap:14px}
        .logo{width:64px;height:64px;border-radius:10px;background:linear-gradient(135deg,var(--accent),var(--brown));display:flex;align-items:center;justify-content:center;color:#fff;font-weight:700}
        h1{margin:0;font-size:20px}
        .grid{display:grid;grid-template-columns:1fr 380px;gap:18px}
        .card{background:var(--paper);border-radius:12px;padding:16px;box-shadow:0 8px 20px rgba(90,58,47,.06)}
        .section{margin-bottom:12px}
        label{display:block;font-size:13px;color:var(--brown);margin-bottom:6px}
        input[type=text],select{width:100%;padding:10px;border-radius:8px;border:1px solid #efe0d9;font-size:14px}
        textarea{width:100%;min-height:60px;padding:10px;border-radius:8px;border:1px solid #efe0d9}
        .row{display:flex;gap:10px}
        .row .col{flex:1}
        .actions{display:flex;gap:8px;margin-top:10px}
        .btn{padding:10px 12px;border-radius:8px;border:0;cursor:pointer;font-weight:600}
        .btn-primary{background:var(--brown);color:#fff}
        .btn-ghost{background:transparent;border:1px solid #e8d8d2;color:var(--brown)}
        .summary{font-size:15px}
        .summary .line{display:flex;justify-content:space-between;padding:6px 0;border-bottom:1px dashed #f0e6e3}
        .total{font-weight:800;font-size:18px;padding-top:8px}
        .note{font-size:13px;color:var(--muted);margin-top:8px}
        .error{color:#9b2d30}
        @media (max-width:900px){.grid{grid-template-columns:1fr}.header{flex-direction:column;align-items:flex-start}.logo{width:52px;height:52px}}
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container">
            <div class="header">
                <div class="brand">
                    <div class="logo">D&amp;C</div>
                    <div>
                        <h1>Factura - Dulce &amp; Café</h1>
                        <div class="note">Complete los datos del cliente y del producto para generar la factura.</div>
                    </div>
                </div>
                <asp:Label ID="lblCalcMessage" runat="server" CssClass="note" />
            </div>

            <div class="grid">
                <div class="card">
                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="error" DisplayMode="BulletList" ShowMessageBox="false" HeaderText="Por favor corrija:" />

                    <div class="section">
                        <h3>Información del cliente</h3>
                        <div class="row">
                            <div class="col">
                                <label for="txtCustomerName">Nombre</label>
                                <asp:TextBox ID="txtCustomerName" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="reqCustName" runat="server" ControlToValidate="txtCustomerName" ErrorMessage="Nombre requerido." Display="Dynamic" ForeColor="#9b2d30"></asp:RequiredFieldValidator>
                            </div>
                            <div class="col">
                                <label for="txtCustomerPhone">Teléfono</label>
                                <asp:TextBox ID="txtCustomerPhone" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="reqCustPhone" runat="server" ControlToValidate="txtCustomerPhone" ErrorMessage="Teléfono requerido." Display="Dynamic" ForeColor="#9b2d30"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revCustPhone" runat="server" ControlToValidate="txtCustomerPhone" ErrorMessage="Formato de teléfono inválido." Display="Dynamic" ForeColor="#9b2d30" ValidationExpression="^\+?[0-9\-\s\(\)]{7,20}$"></asp:RegularExpressionValidator>
                            </div>
                        </div>
                        <div style="margin-top:10px">
                            <label for="txtCustomerEmail">Correo electrónico</label>
                            <asp:TextBox ID="txtCustomerEmail" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqCustEmail" runat="server" ControlToValidate="txtCustomerEmail" ErrorMessage="Email requerido." Display="Dynamic" ForeColor="#9b2d30"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revCustEmail" runat="server" ControlToValidate="txtCustomerEmail" ErrorMessage="Formato de email inválido." Display="Dynamic" ForeColor="#9b2d30" ValidationExpression="^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,})+$"></asp:RegularExpressionValidator>
                        </div>
                    </div>

                    <div class="section">
                        <h3>Información de la factura</h3>
                        <div class="row">
                            <div class="col">
                                <label for="txtInvoiceNumber">Número de factura</label>
                                <asp:TextBox ID="txtInvoiceNumber" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="reqInvoiceNumber" runat="server" ControlToValidate="txtInvoiceNumber" ErrorMessage="Número requerido." Display="Dynamic" ForeColor="#9b2d30"></asp:RequiredFieldValidator>
                            </div>
                            <div class="col">
                                <label for="txtInvoiceDate">Fecha</label>
                                <asp:TextBox ID="txtInvoiceDate" runat="server" TextMode="Date" Text=""></asp:TextBox>
                                <asp:RequiredFieldValidator ID="reqInvoiceDate" runat="server" ControlToValidate="txtInvoiceDate" ErrorMessage="Fecha requerida." Display="Dynamic" ForeColor="#9b2d30"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </div>

                    <div class="section">
                        <h3>Producto</h3>
                        <div style="margin-bottom:10px">
                            <label for="ddlCurrency">Moneda</label>
                            <asp:DropDownList ID="ddlCurrency" runat="server">
                                <asp:ListItem Value="USD">USD</asp:ListItem>
                                <asp:ListItem Value="COP">COP</asp:ListItem>
                                <asp:ListItem Value="GBP">GBP</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="row">
                            <div class="col">
                                <label for="ddlProduct">Producto</label>
                                <asp:DropDownList ID="ddlProduct" runat="server">
                                    <asp:ListItem>Brownie</asp:ListItem>
                                    <asp:ListItem>Croissant</asp:ListItem>
                                    <asp:ListItem>Cheesecake</asp:ListItem>
                                    <asp:ListItem>Galletas</asp:ListItem>
                                    <asp:ListItem>Café americano</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col">
                                <label for="ddlPresentation">Presentación</label>
                                <asp:DropDownList ID="ddlPresentation" runat="server">
                                    <asp:ListItem>Unidad</asp:ListItem>
                                    <asp:ListItem>Caja</asp:ListItem>
                                    <asp:ListItem>Porción</asp:ListItem>
                                    <asp:ListItem>Vaso</asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>

                        <div style="margin-top:10px" class="row">
                            <div class="col">
                                <label for="txtQuantity">Cantidad</label>
                                <asp:TextBox ID="txtQuantity" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="reqQuantity" runat="server" ControlToValidate="txtQuantity" ErrorMessage="Cantidad requerida." Display="Dynamic" ForeColor="#9b2d30"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revQuantity" runat="server" ControlToValidate="txtQuantity" ErrorMessage="Ingrese una cantidad válida (entero)." Display="Dynamic" ForeColor="#9b2d30" ValidationExpression="^\d+$"></asp:RegularExpressionValidator>
                            </div>
                            <div class="col">
                                <label for="txtUnitPrice">Precio unitario</label>
                                <asp:TextBox ID="txtUnitPrice" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="reqUnitPrice" runat="server" ControlToValidate="txtUnitPrice" ErrorMessage="Precio requerido." Display="Dynamic" ForeColor="#9b2d30"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revUnitPrice" runat="server" ControlToValidate="txtUnitPrice" ErrorMessage="Ingrese un precio válido." Display="Dynamic" ForeColor="#9b2d30" ValidationExpression="^[0-9]+(\.[0-9]{1,2})?$"></asp:RegularExpressionValidator>
                            </div>
                        </div>
                        <div style="margin-top:10px">
                            <label for="txtDiscount">Descuento (%)</label>
                            <asp:TextBox ID="txtDiscount" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqDiscount" runat="server" ControlToValidate="txtDiscount" ErrorMessage="Descuento requerido (0-100)." Display="Dynamic" ForeColor="#9b2d30"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revDiscount" runat="server" ControlToValidate="txtDiscount" ErrorMessage="Ingrese un porcentaje válido (0-100)." Display="Dynamic" ForeColor="#9b2d30" ValidationExpression="^[0-9]+(\.[0-9]{1,2})?$"></asp:RegularExpressionValidator>
                        </div>

                        <div style="margin-top:12px">
                            <asp:Button ID="btnAddToCart" runat="server" Text="Agregar al carrito" CssClass="btn btn-ghost" OnClick="btnAddToCart_Click" />
                        </div>

                        <div style="margin-top:16px">
                            <h4>Carrito</h4>
                            <asp:GridView ID="gvCart" runat="server" AutoGenerateColumns="false" GridLines="None" OnRowCommand="gvCart_RowCommand">
                                <Columns>
                                    <asp:BoundField DataField="Product" HeaderText="Producto" />
                                    <asp:BoundField DataField="PresentationFull" HeaderText="Presentación" />
                                    <asp:BoundField DataField="Quantity" HeaderText="Cantidad" />
                                    <asp:BoundField DataField="UnitPriceDisplay" HeaderText="Precio unitario" />
                                    <asp:BoundField DataField="SubtotalDisplay" HeaderText="Subtotal" />
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lnkRemove" runat="server" Text="Quitar" CommandName="Remove" CommandArgument='<%# Container.DataItemIndex %>' CssClass="btn btn-ghost" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>

                    <div class="actions">
                        <asp:Button ID="btnCalculate" runat="server" Text="Calcular factura" CssClass="btn btn-primary" OnClick="btnCalculate_Click" />
                        <asp:Button ID="btnClear" runat="server" Text="Limpiar" CssClass="btn btn-ghost" OnClick="btnClear_Click" />
                        <asp:Button ID="btnContinue" runat="server" Text="Continuar a encuesta" CssClass="btn btn-ghost" OnClick="btnContinue_Click" />
                    </div>
                </div>

                <div class="card">
                    <h3>Resumen de la factura</h3>
                    <div class="section">
                        <label>Producto</label>
                        <asp:Label ID="lblProduct" runat="server" />
                        <label>Descripción</label>
                        <asp:TextBox ID="txtDescription" runat="server" TextMode="MultiLine"></asp:TextBox>
                    </div>

                    <div class="section summary">
                        <div class="line"><span>Subtotal</span><span><asp:Label ID="lblSubtotal" runat="server" /></span></div>
                        <div class="line"><span>Descuento</span><span><asp:Label ID="lblDiscountValue" runat="server" /></span></div>
                        <div class="line"><span>Importe después de descuento</span><span><asp:Label ID="lblAfterDiscount" runat="server" /></span></div>
                        <div class="line"><span>IVA (19%)</span><span><asp:Label ID="lblIVA" runat="server" /></span></div>
                        <div class="line total"><span>Total a pagar</span><span><asp:Label ID="lblTotal" runat="server" /></span></div>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
