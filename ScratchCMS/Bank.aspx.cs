using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Bank : System.Web.UI.Page
{
    Admin admin = new Admin();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["username"]!= null)
        {
            if (!IsPostBack)
            {
                BindBank();
                if (!string.IsNullOrEmpty(Request.QueryString["BID"]))
                {
                    DataTable dtBankId = admin.getBankbyId(Request.QueryString["BID"]);
                    txtPrice.Text = dtBankId.Rows[0]["Price"].ToString();
                    txtHorseShoes.Text = dtBankId.Rows[0]["Points"].ToString();
                    btnSubmit.Text = "Update";
                    txtPrice.ReadOnly = true;
                }
                else
                {

                }
            }
        }
        else
        {
            Response.Redirect("Login.aspx");
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(Request.QueryString["BID"]))
        {
            if (admin.UpdateBankData(Request.QueryString["BID"], txtHorseShoes.Text) > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "update", "alert('Successfully Updated.');window.location='Bank.aspx';", true);
                ClearAllControl();
               
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "update", "alert('Problem to Update the data.');window.location='Bank.aspx';", true);
            }
        }
        else
        {
            if (admin.InsertBankData(txtHorseShoes.Text, txtPrice.Text) > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "insert", "alert('Successfully Saved.');", true);
                ClearAllControl();
                BindBank();
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "insert", "alert('Problem to save the data.');", true);
            }
        }
        
    }
    public void ClearAllControl()
    {
        txtHorseShoes.Text = "";
        txtPrice.Text = "";
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        txtHorseShoes.Text = "";
        txtPrice.Text = "";
    }
    private void BindBank()
    {
        DataTable dtBank = admin.FillBankGrid();
        if (dtBank.Rows.Count > 0)
        {
            grdBank.DataSource = dtBank;
            grdBank.DataBind();
        }
        else
        {
            grdBank.DataSource = null;
            grdBank.DataBind();
        }
    }
    protected void grdBank_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "btnEdit")
        {
            Response.Redirect("Bank.aspx?BID=" + Convert.ToInt32(e.CommandArgument) + "");
        }
        else if (e.CommandName == "btnActive")
        {
            admin.ActivateBankStatus(Convert.ToString(e.CommandArgument));
        }
        else if (e.CommandName == "btnDelete")
        {
            admin.DeleteBankStatus(Convert.ToString(e.CommandArgument));
        }
        BindBank();
    }
    protected void pageindexchange(object sender, GridViewPageEventArgs e)
    {
        grdBank.PageIndex = e.NewPageIndex;
        BindBank();
    }
}