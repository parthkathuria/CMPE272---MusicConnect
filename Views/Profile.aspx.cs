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
    public partial class Profile : System.Web.UI.Page
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
                try
                {
                    DataSet ds = RunQuery("select * from UserTable where userId=" + userId);
                    if(ds.Tables.Count>0)
                    {
                        DataTable dt = ds.Tables[0];
                        if(dt.Rows.Count>0)
                        {
                            impPic.ImageUrl = dt.Rows[0]["profilepic"].ToString();
                            lblProfileName.Text = dt.Rows[0]["fName"].ToString() + " " + dt.Rows[0]["lName"].ToString();
                        }
                    }
                }catch(Exception ex)
                {
                    lblMessage.Text = ex.Message.ToString();
                }
                GetData();
                GetPosts();
                GetFollowers();
                GetFollowing();
            }
        }


        public void GetPosts()
        {
            try
            {
                DataSet ds = RunQuery("select COUNT(*) from MusicTable where userId=" + userId);
                if(ds.Tables.Count>0)
                {
                    DataTable dt = ds.Tables[0];
                    if(dt.Rows.Count>0)
                    {
                        lblPosts.Text = dt.Rows[0][0].ToString();
                    }
                    else
                    {
                        lblPosts.Text = "0";
                    }
                }
            }
            catch(Exception ex)
            {
                lblMessage.Text = ex.Message.ToString();
            }
        }

        public void GetFollowers()
        {
            try
            {
                DataSet ds = RunQuery("select COUNT(*) from Friends where friendUserId=" + userId);
                if (ds.Tables.Count > 0)
                {
                    DataTable dt = ds.Tables[0];
                    if (dt.Rows.Count > 0)
                    {
                        lblFollowers.Text = dt.Rows[0][0].ToString();
                    }
                    else
                    {
                        lblFollowers.Text = "0";
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = ex.Message.ToString();
            }
        }

        public void GetFollowing()
        {
            try
            {
                DataSet ds = RunQuery("select COUNT(*) from Friends where userId=" + userId);
                if (ds.Tables.Count > 0)
                {
                    DataTable dt = ds.Tables[0];
                    if (dt.Rows.Count > 0)
                    {
                        lblFollowing.Text = dt.Rows[0][0].ToString();
                    }
                    else
                    {
                        lblFollowing.Text = "0";
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = ex.Message.ToString();
            }
        }
        protected void GetData()
        {
            try
            {
                string query = "select a.genreId as genreid,a.musicGenre as musicgenre, count(c.comment) as Comment_Count,a.musicid as musicid,a.vpath as vpath,a.path as path,a.up as up,a.down as down,a.createTime as createtime,a.userid as userid,a.typeid as typeid,a.caption as caption,a.apath as apath,a.fname as fname,a.lname as lname,a.profilepic as profilepic from comments c full outer join (select * from genres as g inner join (select m.musicid as musicid,m.vpath as vpath,m.path as path,m.up as up,m.down as down,m.createTime as createtime,m.userid as userid,m.typeid as typeid,m.caption as caption,m.apath as apath,u.fname as fname,u.lname as lname,u.profilepic as profilepic from musictable as m inner join usertable u on m.userId=u.userId) as t on t.typeId=g.genreId) as a on a.musicid=c.musicId where a.userid="+userId+" group by a.genreid,a.musicgenre,a.musicid,a.vpath,a.path,a.up,a.down,a.createTime,a.userid,a.typeid,a.caption,a.apath,a.fname,a.lname,a.profilepic  order by a.createtime desc";

                DataSet ds = RunQuery(query);
                if (ds.Tables.Count > 0)
                {
                    DataTable dt = ds.Tables[0];
                    if (dt.Rows.Count > 0)
                    {
                        dynamic.DataSource = dt;
                        dynamic.DataBind();
                    }
                    else
                    {
                        lblMessage.Text = "You have not posted anything yet.";
                    }
                }
                else
                {
                    lblMessage.Text = "You have not posted anything yet.";
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

        protected void lnkEditProfile_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Views/EditProfile.aspx");
        }

        protected void lnkButton_Click(object sender, EventArgs e)
        {
            LinkButton lnk = sender as LinkButton;
            int id = ((RepeaterItem)lnk.NamingContainer).ItemIndex;
            // int i = Convert.ToInt64(e.CommandArgument);
            HiddenField hidden = (HiddenField)dynamic.Items[id].FindControl("musicId");
            Session["musicId"] = hidden.Value;
            Response.Redirect("~/Views/ViewMusic.aspx");
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