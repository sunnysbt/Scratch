using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SiteMaster : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["username"] != null)
        {
            lblWelcome.Visible = true;
            lblLogIn.Visible = false;
            HeadLoginOut.Visible = true;
            NavigationMenu.Visible = true;
            HeadLoginName.Text = Session["username"].ToString();
        }
       
    }
    protected void HeadLoginOut_Click(object sender, EventArgs e)
    {
        Session.Abandon();
        Response.Redirect("~/Login.aspx");
    }
}
