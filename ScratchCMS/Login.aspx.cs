using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class Login : System.Web.UI.Page
{
    Admin admin = new Admin();
    protected void Page_Load(object sender, EventArgs e)
    {
        lblMsg.Text = "";
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        DataTable dtuser = admin.CheckUserCredential(txtUserName.Text, txtPassword.Text);
        if (dtuser.Rows.Count>0 && dtuser.Rows[0]["Password"].ToString() + "" == txtPassword.Text && dtuser.Rows[0]["RoleId"].ToString() + "" == "1")
        {
            Session["username"] = dtuser.Rows[0]["LoginName"].ToString() + "";
            Response.Redirect("~/Default.aspx");
            ClearAllControl();
        }
        else
        {
            lblMsg.Text = "The username or password you entered is incorrect.";
        }

    }
    public void ClearAllControl()
    {
        txtUserName.Text = "";
        txtPassword.Text = "";
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        txtUserName.Text = "";
        txtPassword.Text = "";
    }
}