using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
public partial class Themes : System.Web.UI.Page
{
    Admin admin = new Admin();
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Session["username"] != null)
        {
            if (!IsPostBack)
            {
                BindThemesGrid();
               
                BindLevels();
                if (!string.IsNullOrEmpty(Request.QueryString["TID"]))
                {
                    DataTable dtThemeId = admin.getThemebyId(Request.QueryString["TID"]);
                    ddlLevel.SelectedValue = dtThemeId.Rows[0]["LevelId"].ToString();
                    txtThemeName.Text = dtThemeId.Rows[0]["ThemeName"].ToString();
                    txtThemeDesc.Text = dtThemeId.Rows[0]["ThemeDesc"].ToString();
                    txtImagename.Text = dtThemeId.Rows[0]["ImageName"].ToString();
                    txtImagename1.Text = dtThemeId.Rows[0]["ImageName1"].ToString();
                    btnSubmit.Text = "Update";
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
    
    protected void BindLevels()
    {
        ddlLevel.DataSource = admin.getLevel();
        ddlLevel.DataTextField = "LevelNo";
        ddlLevel.DataValueField = "LevelId";
        ddlLevel.DataBind();
        ddlLevel.Items.Insert(0, new ListItem("Select Level", "-1"));
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(Request.QueryString["TID"]))
        {
            if (admin.UpdateTheme(Request.QueryString["TID"], ddlLevel.SelectedValue, txtThemeName.Text , txtThemeDesc.Text, txtImagename.Text, txtImagename1.Text) > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "update", "alert('Successfully Updated.');window.location='Themes.aspx';", true);
                ClearAllControl();

            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "update", "alert('Problem to Update the data.');window.location='Themes.aspx';", true);
            }
        }
        else
        {
            if (admin.insertTheme(ddlLevel.SelectedValue,txtThemeName.Text, txtThemeDesc.Text, txtImagename.Text,txtImagename1.Text) > 0)
            {
                ClientScript.RegisterStartupScript(this.GetType(), "insert", "alert('Successfully Saved.');", true);
                ClearAllControl();
                BindThemesGrid();
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "insert", "alert('Problem to save the data.');", true);
            }
        }

    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        ddlLevel.SelectedValue = "-1";
        txtThemeName.Text = "";
        txtThemeDesc.Text = "";
        txtImagename.Text = "";
        txtImagename1.Text = "";
    }
    public void ClearAllControl()
    {
        ddlLevel.SelectedValue = "-1";
        txtThemeName.Text = "";
        txtThemeDesc.Text = "";
        txtImagename.Text = "";
        txtImagename1.Text = "";
    }

    private void BindThemesGrid()
    {
        DataTable dtTheme = admin.FillThemeGrid();
        if (dtTheme.Rows.Count > 0)
        {
            grdThemes.DataSource = dtTheme;
            grdThemes.DataBind();
        }
        else
        {
            grdThemes.DataSource = null;
            grdThemes.DataBind();
        }
    }
    protected void grdTheme_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "btnEdit")
        {
            Response.Redirect("Themes.aspx?TID=" + Convert.ToInt32(e.CommandArgument) + "");
        }
        else if (e.CommandName == "btnActive")
        {
            admin.ActivateThemeStatus(Convert.ToString(e.CommandArgument));
        }
        else if (e.CommandName == "btnDelete")
        {
            admin.DeleteThemeStatus(Convert.ToString(e.CommandArgument));
        }
        BindThemesGrid();
    }
    protected void pageindexchange(object sender, GridViewPageEventArgs e)
    {
        grdThemes.PageIndex = e.NewPageIndex;
        BindThemesGrid();
    }
    
}