using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MusicConnect.Views
{
    public partial class Following : System.Web.UI.Page
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
                GetFollowing();
            }
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

        public void GetFollowing()
        {
            try
            {
                DataSet ds = RunQuery("select * from usertable where userid in (select  friendUserId from Friends where userid=" + userId + ")");
                if (ds.Tables.Count > 0)
                {
                    DataTable dt = ds.Tables[0];
                    if (dt.Rows.Count > 0)
                    {
                        followerList.DataSource = dt;
                        followerList.DataBind();
                    }
                    else
                    {
                        lblMessage.Text = "You are not following anyone";
                    }
                }
                else
                {
                    lblMessage.Text = "You are not following anyone";
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = ex.Message.ToString();
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

        protected void lnkName_Click(object sender, EventArgs e)
        {
            LinkButton lnk = sender as LinkButton;
            int id = ((RepeaterItem)lnk.NamingContainer).ItemIndex;
            // int i = Convert.ToInt64(e.CommandArgument);
            HiddenField hidden = (HiddenField)followerList.Items[id].FindControl("userId");
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