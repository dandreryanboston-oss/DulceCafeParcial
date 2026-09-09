using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace DulceCafeParcial
{
    public partial class Encuesta : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            bool q1Answered = rbQ1Muy.Checked || rbQ1Satis.Checked || rbQ1Neutral.Checked || rbQ1Insatis.Checked || rbQ1MuyInsatis.Checked;
            if (!q1Answered)
            {
                lblReq1.Text = " (Respuesta requerida)";
                lblMessage.CssClass = "error";
                lblMessage.Text = "Por favor responda la pregunta 1.";
                return;
            }
            else
            {
                lblReq1.Text = string.Empty;
            }

            bool q2Answered = rbQ2Excel.Checked || rbQ2Bueno.Checked || rbQ2Regular.Checked || rbQ2Mala.Checked;
            bool q3Answered = rbQ3Si.Checked || rbQ3No.Checked;

            if (!q2Answered || !q3Answered)
            {
                lblMessage.CssClass = "error";
                lblMessage.Text = "Por favor responda todas las preguntas.";
                return;
            }

            string answer1 = rbQ1Muy.Checked ? rbQ1Muy.Text : rbQ1Satis.Checked ? rbQ1Satis.Text : rbQ1Neutral.Checked ? rbQ1Neutral.Text : rbQ1Insatis.Checked ? rbQ1Insatis.Text : rbQ1MuyInsatis.Text;
            string answer2 = rbQ2Excel.Checked ? rbQ2Excel.Text : rbQ2Bueno.Checked ? rbQ2Bueno.Text : rbQ2Regular.Checked ? rbQ2Regular.Text : rbQ2Mala.Text;
            string answer3 = rbQ3Si.Checked ? rbQ3Si.Text : rbQ3No.Text;

            Session["SurveyAnswer1"] = answer1;
            Session["SurveyAnswer2"] = answer2;
            Session["SurveyAnswer3"] = answer3;

            lblMessage.CssClass = "success";
            lblMessage.Text = "Gracias por completar nuestra encuesta.";

            btnSubmit.Enabled = false;
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Response.Redirect("Factura.aspx", false);
        }
    }
}
