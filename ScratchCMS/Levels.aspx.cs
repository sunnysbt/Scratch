using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class Levels : System.Web.UI.Page
{
    Admin admin = new Admin();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["username"] != null)
        {
            if (!IsPostBack)
            {
                BindLevel();
                if (!string.IsNullOrEmpty(Request.QueryString["LID"]))
                {
                    DataTable dtlevelId = admin.getLevelbyLevelId(Request.QueryString["LID"]);
                    txtLevel.Text = dtlevelId.Rows[0]["LevelNo"].ToString();
                    txtNumberOfTicket.Text = dtlevelId.Rows[0]["NumberofTicket"].ToString();
                    btnSubmit.Text = "Update";
                    txtLevel.ReadOnly = true;
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

    private void BindLevel()
    {
        DataTable dtlevel = admin.FillLevelGrid();
        if (dtlevel.Rows.Count > 0)
        {
            grdlevels.DataSource = dtlevel;
            grdlevels.DataBind();
            for (int i = 0; i < grdlevels.Rows.Count; i++)
            {
                Label label = (Label)grdlevels.Rows[i].FindControl("lblLevelNo");
            }
        }
        else
        {
            grdlevels.DataSource = null;
            grdlevels.DataBind();
        }
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(Request.QueryString["LID"]))
        {
            if (admin.UpdateLevelData(Request.QueryString["LID"], txtNumberOfTicket.Text) > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "update", "alert('Successfully Updated.');window.location='levels.aspx';", true);
                ClearAllControl();
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "update", "alert('Problem to Update the data.');window.location='levels.aspx';", true);
            }
        }
        else
        {
            if (admin.InsertLevelData(txtLevel.Text, txtNumberOfTicket.Text) > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "insert", "alert('Successfully Saved.');", true);
                ClearAllControl();
                BindLevel();
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "insert", "alert('Problem to save the data.');", true);
            }
        }

    }
    public void ClearAllControl()
    {
        txtNumberOfTicket.Text = "";
        txtLevel.Text = "";
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        txtNumberOfTicket.Text = "";
    }
    protected void grdLevel_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "btnEdit")
        {
            Response.Redirect("levels.aspx?LID=" + Convert.ToInt32(e.CommandArgument) + "");
        }
        else if (e.CommandName == "btnActive")
        {
            admin.ChangeStatus(Convert.ToString(e.CommandArgument));
        }
        else if (e.CommandName == "btnDelete")
        {
            admin.DeleteStatus(Convert.ToString(e.CommandArgument));
        }
        BindLevel();

    }
    protected void pageindexchange(object sender, GridViewPageEventArgs e)
    {
        grdlevels.PageIndex = e.NewPageIndex;
        BindLevel();
    }
    protected void grdLevel_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.EmptyDataRow)
        {
            Label label = (Label)e.Row.FindControl("lblLevelNo");
        }
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            ImageButton btn = (ImageButton)e.Row.FindControl("imgbtnEdit");
            Label label = (Label)e.Row.FindControl("lblLevelNo");
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label label = (Label)e.Row.FindControl("lblLevelNo");
        }
        if (e.Row.RowType == DataControlRowType.Header)
        {
            Label label = (Label)e.Row.FindControl("lblLevelNo");
        }
        if (e.Row.RowType == DataControlRowType.Pager)
        {
            Label label = (Label)e.Row.FindControl("lblLevelNo");
        }
        if (e.Row.RowType == DataControlRowType.Separator)
        {
            Label label = (Label)e.Row.FindControl("lblLevelNo");
        }
    }
}