<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="DulceCafeParcial.Index" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Dulce &amp; Café — Iniciar sesión</title>
    <style>
        :root{--cream:#FFF9F0;--brown:#5A3A2F;--accent:#D98B6A;--muted:#7b6e6a}
        html,body{height:100%;margin:0;font-family:Segoe UI, Tahoma, Geneva, Verdana, sans-serif;background:linear-gradient(180deg,#fff 0%,#fff6f0 60%)}
        .page{min-height:100%;display:flex;align-items:center;justify-content:center;padding:40px}
        .card{max-width:420px;width:100%;background:var(--cream);border-radius:16px;box-shadow:0 10px 30px rgba(90,58,47,.12);padding:28px}
        .brand{display:flex;align-items:center;gap:12px;margin-bottom:18px}
        .logo{width:56px;height:56px;background:linear-gradient(135deg,var(--accent),var(--brown));border-radius:12px;display:flex;align-items:center;justify-content:center;color:white;font-weight:700;font-size:20px}
        h1{margin:0;font-size:20px;color:var(--brown)}
        p.lead{margin:4px 0 18px;color:var(--muted);font-size:13px}
        .form-row{display:flex;flex-direction:column;gap:8px;margin-bottom:12px}
        label{font-size:13px;color:var(--brown)}
        input[type="text"],input[type="password"]{padding:10px 12px;border-radius:8px;border:1px solid #e6d8d1;background:white;font-size:14px}
        .actions{display:flex;gap:8px;margin-top:12px;flex-wrap:wrap}
        .btn{padding:10px 14px;border-radius:8px;border:0;cursor:pointer;font-weight:600}
        .btn-primary{background:var(--brown);color:#fff}
        .btn-link{background:transparent;color:var(--accent);border:1px solid transparent}
        .aux{display:flex;justify-content:space-between;align-items:center;margin-top:6px}
        .message{min-height:22px;margin-top:8px;font-size:13px}
        .error{color:#9b2d30}
        .success{color:#2f6f48}
        .small-link{font-size:13px;color:var(--muted);text-decoration:none}
        @media (max-width:480px){.card{padding:20px;border-radius:12px;margin:0 10px}}
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="page">
            <div class="card">
                <div class="brand">
                    <div class="logo">D&amp;C</div>
                    <div>
                        <h1>Dulce &amp; Café</h1>
                        <p class="lead">Bienvenido — inicia sesión para continuar</p>
                    </div>
                </div>

                <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="error" DisplayMode="BulletList" ShowMessageBox="false" HeaderText="Por favor corrija:" />

                <div class="form-row">
                    <label for="txtEmail">Correo electrónico</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="" Width="100%" MaxLength="256"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Email requerido." Display="Dynamic" ForeColor="#9b2d30"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Formato de email inválido." Display="Dynamic" ForeColor="#9b2d30"
                        ValidationExpression="^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,})+$"></asp:RegularExpressionValidator>
                </div>

                <div class="form-row">
                    <label for="txtPassword">Contraseña</label>
                    <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" MaxLength="100"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="reqPassword" runat="server" ControlToValidate="txtPassword" ErrorMessage="Contraseña requerida." Display="Dynamic" ForeColor="#9b2d30"></asp:RequiredFieldValidator>
                </div>

                <div class="aux">
                    <asp:Label ID="lblMessage" runat="server" CssClass="message" />
                    <asp:HyperLink ID="hlRegister" runat="server" NavigateUrl="Registro.aspx" CssClass="small-link">¿No tienes cuenta?</asp:HyperLink>
                </div>

                <div class="actions">
                    <asp:Button ID="btnLogin" runat="server" Text="Iniciar sesión" CssClass="btn btn-primary" OnClick="btnLogin_Click" />
                    <asp:Button ID="btnForgot" runat="server" Text="Olvidé mi contraseña" CssClass="btn btn-link" OnClick="btnForgot_Click" />
                </div>
            </div>
        </div>
    </form>
</body>
</html>
