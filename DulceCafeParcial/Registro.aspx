<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Registro.aspx.cs" Inherits="DulceCafeParcial.Registro" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Registro — Dulce &amp; Café</title>
    <style>
        :root{--bg:#fffaf7;--card:#ffffff;--accent:#D98B6A;--brown:#5A3A2F;--muted:#7b6e6a}
        body{margin:0;font-family:Segoe UI, Tahoma, Geneva, Verdana, sans-serif;background:linear-gradient(180deg,#fffaf5 0%,#fff 60%);color:var(--brown)}
        .wrap{min-height:100vh;display:flex;align-items:center;justify-content:center;padding:30px}
        .layout{display:flex;gap:28px;max-width:980px;width:100%;align-items:stretch}
        .visual{flex:1;background:linear-gradient(135deg,var(--accent),#f5d6c6);border-radius:16px;padding:28px;color:#fff;display:flex;flex-direction:column;justify-content:center}
        .visual h2{margin:0 0 10px;font-size:22px}
        .visual p{margin:0;font-size:14px;opacity:0.95}
        .form-card{flex:1;background:var(--card);border-radius:16px;padding:26px;box-shadow:0 8px 24px rgba(90,58,47,.08)}
        .form-card h3{margin:0 0 8px}
        .grid{display:grid;grid-template-columns:1fr 1fr;gap:12px}
        .full{grid-column:1/-1}
        label{font-size:13px;display:block;color:var(--brown);margin-bottom:6px}
        input[type="text"],input[type="password"]{width:100%;padding:10px;border-radius:8px;border:1px solid #ead6ce;font-size:14px}
        .actions{display:flex;gap:10px;align-items:center;margin-top:12px}
        .btn{padding:10px 14px;border-radius:8px;border:0;cursor:pointer;font-weight:600}
        .btn-primary{background:var(--brown);color:#fff}
        .btn-ghost{background:transparent;border:1px solid #e9d8d4;color:var(--brown)}
        .msg{min-height:22px;margin-top:8px;font-size:14px}
        .success{color:#2f6f48}
        .error{color:#9b2d30}
        @media (max-width:760px){.layout{flex-direction:column}.grid{grid-template-columns:1fr}}
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="wrap">
            <div class="layout">
                <div class="visual">
                    <h2>Únete a Dulce &amp; Café</h2>
                    <p>Regístrate para recibir ofertas, realizar pedidos y disfrutar de lo mejor en repostería y café artesanal.</p>
                </div>

                <div class="form-card">
                    <h3>Crear cuenta</h3>
                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" CssClass="error" DisplayMode="BulletList" ShowMessageBox="false" HeaderText="Por favor corrija:" />

                    <div class="grid">
                        <div class="full">
                            <label for="txtFullName">Nombre completo</label>
                            <asp:TextBox ID="txtFullName" runat="server" MaxLength="150"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqFullName" runat="server" ControlToValidate="txtFullName" ErrorMessage="Nombre requerido." Display="Dynamic" ForeColor="#9b2d30"></asp:RequiredFieldValidator>
                        </div>

                        <div>
                            <label for="txtEmail">Correo electrónico</label>
                            <asp:TextBox ID="txtEmail" runat="server" MaxLength="256"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Email requerido." Display="Dynamic" ForeColor="#9b2d30"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revEmail" runat="server" ControlToValidate="txtEmail" ErrorMessage="Formato de email inválido." Display="Dynamic" ForeColor="#9b2d30"
                                ValidationExpression="^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,})+$"></asp:RegularExpressionValidator>
                        </div>

                        <div>
                            <label for="txtPhone">Teléfono</label>
                            <asp:TextBox ID="txtPhone" runat="server" MaxLength="30"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqPhone" runat="server" ControlToValidate="txtPhone" ErrorMessage="Teléfono requerido." Display="Dynamic" ForeColor="#9b2d30"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revPhone" runat="server" ControlToValidate="txtPhone" ErrorMessage="Formato de teléfono inválido." Display="Dynamic" ForeColor="#9b2d30"
                                ValidationExpression="^\+?[0-9\-\s\(\)]{7,20}$"></asp:RegularExpressionValidator>
                        </div>

                        <div>
                            <label for="txtPassword">Contraseña</label>
                            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" MaxLength="100"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqPassword" runat="server" ControlToValidate="txtPassword" ErrorMessage="Contraseña requerida." Display="Dynamic" ForeColor="#9b2d30"></asp:RequiredFieldValidator>
                        </div>

                        <div>
                            <label for="txtConfirm">Confirmar contraseña</label>
                            <asp:TextBox ID="txtConfirm" runat="server" TextMode="Password" MaxLength="100"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="reqConfirm" runat="server" ControlToValidate="txtConfirm" ErrorMessage="Confirme la contraseña." Display="Dynamic" ForeColor="#9b2d30"></asp:RequiredFieldValidator>
                            <asp:CompareValidator ID="cmpPassword" runat="server" ControlToValidate="txtConfirm" ControlToCompare="txtPassword" ErrorMessage="Las contraseñas no coinciden." Display="Dynamic" ForeColor="#9b2d30"></asp:CompareValidator>
                        </div>
                    </div>

                    <div class="actions">
                        <asp:Button ID="btnRegister" runat="server" Text="Registrarse" CssClass="btn btn-primary" OnClick="btnRegister_Click" />
                        <asp:HyperLink ID="hlBack" runat="server" NavigateUrl="Index.aspx" CssClass="btn btn-ghost">Volver al inicio</asp:HyperLink>
                    </div>

                    <asp:Label ID="lblMessage" runat="server" CssClass="msg" />
                </div>
            </div>
        </div>
    </form>
</body>
</html>
