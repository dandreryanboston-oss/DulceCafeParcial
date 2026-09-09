using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DulceCafeParcial
{
    public partial class Index : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            string email = (txtEmail.Text ?? string.Empty).Trim();
            string password = (txtPassword.Text ?? string.Empty);
            const string demoEmail = "cliente@dulcecafe.com";
            const string demoPassword = "Dulce123";

            var users = LoadUsersFromFile();

            bool matched = false;
            if (users != null && users.TryGetValue(email, out string storedPwd))
            {
                if (storedPwd == password)
                {
                    matched = true;
                }
            }

            if (!matched && string.Equals(email, demoEmail, StringComparison.OrdinalIgnoreCase) && password == demoPassword)
            {
                matched = true;
            }

            if (matched)
            {
                Response.Redirect("Factura.aspx", false);
            }
            else
            {
                lblMessage.CssClass = "message error";
                lblMessage.Text = "Credenciales incorrectas. Verifique su correo y contraseña.";
            }
        }

        private Dictionary<string, string> LoadUsersFromFile()
        {
            var result = new Dictionary<string, string>(StringComparer.OrdinalIgnoreCase);
            try
            {
                string dir = Server.MapPath("~/App_Data");
                string path = Path.Combine(dir, "users.txt");
                if (File.Exists(path))
                {
                    foreach (var line in File.ReadAllLines(path))
                    {
                        if (string.IsNullOrWhiteSpace(line)) continue;
                        var parts = line.Split('|');
                        if (parts.Length >= 2)
                        {
                            result[parts[0]] = parts[1];
                        }
                    }
                }
            }
            catch
            {
                // ignore read errors for demo
            }
            return result;
        }

        protected void btnForgot_Click(object sender, EventArgs e)
        {
            lblMessage.CssClass = "message";
            lblMessage.Text = "Si olvidó su contraseña, contacte al administrador del sitio o use Registro para crear una cuenta.";
        }
    }
}