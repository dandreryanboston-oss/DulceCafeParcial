using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DulceCafeParcial
{
    public partial class Registro : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

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
                // ignore file read errors for this demo
            }
            return result;
        }

        private void SaveUsersToFile(Dictionary<string, string> users)
        {
            try
            {
                string dir = Server.MapPath("~/App_Data");
                Directory.CreateDirectory(dir);
                string path = Path.Combine(dir, "users.txt");
                var lines = users.Select(kv => kv.Key + "|" + kv.Value).ToArray();
                // protect write with Application lock
                Application.Lock();
                try
                {
                    File.WriteAllLines(path, lines);
                }
                finally
                {
                    Application.UnLock();
                }
            }
            catch
            {
                // ignore write errors for demo
            }
        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            if (!Page.IsValid)
            {
                return;
            }

            string name = (txtFullName.Text ?? string.Empty).Trim();
            string email = (txtEmail.Text ?? string.Empty).Trim();
            string phone = (txtPhone.Text ?? string.Empty).Trim();
            string password = txtPassword.Text ?? string.Empty;

            string summary = $"Nombre: {name}; Email: {email}; Teléfono: {phone}";
            Session["RegisteredUser"] = summary;

            var users = LoadUsersFromFile();
            users[email] = password;
            SaveUsersToFile(users);
            Session["RegisteredUserEmail"] = email;

            lblMessage.CssClass = "msg success";
            lblMessage.Text = "Registro exitoso. Ya puede iniciar sesión en la página principal.";

            txtPassword.Text = string.Empty;
            txtConfirm.Text = string.Empty;
        }
    }
}