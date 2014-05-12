using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Sql;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MusicConnect.Views
{
    public partial class SearchPage : System.Web.UI.Page
    {
        int userId;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userId"] == null)
            {
                Response.Redirect("~/Views/login.aspx");
            }
            else
            {
                userId = Convert.ToInt16(Session["userId"]);
                lblUname.Text = Session["fName"].ToString() + " " + Session["lName"].ToString();
                SearchList();
            }
        }

        public void SearchList()
        {
            if(Session["searchText"] != null)
            {
                string searchText = Session["searchText"].ToString();
                try
                {
                    SqlConnection con = new SqlConnection(Session["connString"].ToString());
                    DataSet ds = RunQuery("select * from UserTable where (fName like '%"+searchText+"%' or lName like '%"+searchText+"%') and userId <>"+userId);
                    if (ds.Tables.Count > 0)
                    {
                        DataTable dt = ds.Tables[0];
                        if (dt.Rows.Count > 0)
                        {
                            searchList.DataSource = dt;
                            searchList.DataBind();
                            lblSearchResult.Text = searchText;
                        }
                        else
                        {
                            lblSearchResult.Text = "No Results Found!";
                        }
                    }
                    else
                    {
                        lblSearchResult.Text = "No Results Found!";
                    }
                }catch(Exception ex)
                {
                    lblSearchResult.Text = ex.Message.ToString();
                }
               
            }
            else
            {
                lblSearchResult.Text = "No Results Found!";
            }
        }

        DataSet RunQuery(String Query)
        {
            DataSet ds = new DataSet();
            using (SqlConnection conn = new SqlConnection(Session["connString"].ToString()))
            {
                SqlCommand objCommand = new SqlCommand(Query, conn);
                SqlDataAdapter da = new SqlDataAdapter(objCommand);
                try
                {
                    da.Fill(ds);
                    da.Dispose();
                }
                catch (Exception ex)
                {
                    MessageBox("Error!" + "\\n" + ex.Message.ToString());
                }
            }
            return ds;
        }
        public void MessageBox(string message)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "My title", "alert('" + message + "');", true);
            return;
        }
        protected void searchButton_Click(object sender, ImageClickEventArgs e)
        {

            if ("" == txtSearch.Value)
            {
                txtSearch.Attributes["placeholder"] = "Please type keyword";
                txtSearch.Focus();
                txtSearch.Attributes["style"] = "border-color:red";
            }
            else
            {
                Session["searchText"] = txtSearch.Value;
                Response.Redirect("~/Views/SearchPage.aspx");
            }

        }

        protected void lnkName_Click(object sender, EventArgs e)
        {
            LinkButton lnk = sender as LinkButton;
            int id = ((RepeaterItem)lnk.NamingContainer).ItemIndex;
            // int i = Convert.ToInt64(e.CommandArgument);
            HiddenField hidden = (HiddenField)searchList.Items[id].FindControl("userId");
            int fid = Convert.ToInt32(hidden.Value);
            if (fid == userId)
            {
                Response.Redirect("~/Views/Profile.aspx");
            }
            else
            {
                Session["followerId"] = hidden.Value;
                Response.Redirect("~/Views/ViewProfile.aspx");
            }
        }

        protected void lnkLogout_Click(object sender, EventArgs e)
        {
            Session["userId"] = null;
            Session.Clear();
            Session.Abandon();
            Response.Redirect("~/index.aspx");
        }
    }
}