<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Encuesta.aspx.cs" Inherits="DulceCafeParcial.Encuesta" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Encuesta — Dulce &amp; Café</title>
    <style>
        :root{--bg:#fffaf6;--card:#ffffff;--accent:#D98B6A;--brown:#5A3A2F;--muted:#7b6e6a}
        body{margin:0;font-family:Segoe UI, Tahoma, Geneva, Verdana, sans-serif;background:linear-gradient(180deg,#fffdfb 0%,#fff 70%);color:var(--brown)}
        .wrap{max-width:900px;margin:30px auto;padding:16px}
        .card{background:var(--card);border-radius:12px;padding:22px;box-shadow:0 8px 24px rgba(90,58,47,.06)}
        .header{display:flex;align-items:center;gap:12px;margin-bottom:12px}
        .logo{width:56px;height:56px;border-radius:10px;background:linear-gradient(135deg,var(--accent),var(--brown));display:flex;align-items:center;justify-content:center;color:#fff;font-weight:700}
        h2{margin:0;font-size:20px}
        p.lead{margin:6px 0 14px;color:var(--muted)}
        .question{padding:12px;border-radius:8px;border:1px solid #f0e6e3;margin-bottom:10px}
        .q-title{font-weight:600;margin-bottom:6px}
        .options{display:flex;flex-direction:column;gap:6px}
        .actions{display:flex;gap:8px;align-items:center;margin-top:12px}
        .btn{padding:10px 14px;border-radius:8px;border:0;cursor:pointer;font-weight:600}
        .btn-primary{background:var(--brown);color:#fff}
        .btn-ghost{background:transparent;border:1px solid #e8d8d2;color:var(--brown)}
        .msg{min-height:22px;margin-top:10px;font-size:14px}
        .success{color:#2f6f48}
        .error{color:#9b2d30}
        @media (max-width:520px){.wrap{padding:10px}.header{flex-direction:row}}
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="wrap">
            <div class="card">
                <div class="header">
                    <div class="logo">D&amp;C</div>
                    <div>
                        <h2>Encuesta de satisfacción</h2>
                        <p class="lead">Agradecemos su tiempo. Sus respuestas nos ayudan a mejorar.</p>
                    </div>
                    <div style="margin-left:auto">
                        <asp:LinkButton ID="lnkLogout" runat="server" OnClick="lnkLogout_Click" CssClass="btn btn-ghost">Cerrar sesión</asp:LinkButton>
                    </div>
                </div>

                <div class="question">
                    <div class="q-title">1. ¿Qué tan satisfecho está con nuestro servicio? <asp:Label ID="lblReq1" runat="server" CssClass="error" /></div>
                    <div class="options">
                        <asp:RadioButton ID="rbQ1Muy" runat="server" GroupName="q1" Text="Muy satisfecho" />
                        <asp:RadioButton ID="rbQ1Satis" runat="server" GroupName="q1" Text="Satisfecho" />
                        <asp:RadioButton ID="rbQ1Neutral" runat="server" GroupName="q1" Text="Neutral" />
                        <asp:RadioButton ID="rbQ1Insatis" runat="server" GroupName="q1" Text="Insatisfecho" />
                        <asp:RadioButton ID="rbQ1MuyInsatis" runat="server" GroupName="q1" Text="Muy insatisfecho" />
                    </div>
                </div>

                <div class="question">
                    <div class="q-title">2. ¿Cómo califica la calidad de nuestros productos?</div>
                    <div class="options">
                        <asp:RadioButton ID="rbQ2Excel" runat="server" GroupName="q2" Text="Excelente" />
                        <asp:RadioButton ID="rbQ2Bueno" runat="server" GroupName="q2" Text="Buena" />
                        <asp:RadioButton ID="rbQ2Regular" runat="server" GroupName="q2" Text="Regular" />
                        <asp:RadioButton ID="rbQ2Mala" runat="server" GroupName="q2" Text="Mala" />
                    </div>
                </div>

                <div class="question">
                    <div class="q-title">3. ¿Recomendaría Dulce &amp; Café?</div>
                    <div class="options">
                        <asp:RadioButton ID="rbQ3Si" runat="server" GroupName="q3" Text="Sí" />
                        <asp:RadioButton ID="rbQ3No" runat="server" GroupName="q3" Text="No" />
                    </div>
                </div>

                <div class="actions">
                    <asp:Button ID="btnSubmit" runat="server" Text="Enviar encuesta" CssClass="btn btn-primary" OnClick="btnSubmit_Click" />
                    <asp:Button ID="btnBack" runat="server" Text="Volver a factura" CssClass="btn btn-ghost" OnClick="btnBack_Click" />
                </div>

                <asp:Label ID="lblMessage" runat="server" CssClass="msg" />
            </div>
        </div>
    </form>
</body>
</html>
