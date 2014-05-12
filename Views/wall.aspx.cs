using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Data.Sql;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.IO;
using System.Web.Services;

namespace MusicConnect.Views
{
    public partial class profile : System.Web.UI.Page
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
                GetData();
                if (!IsPostBack)
                {
                    GenreList();
                }
                
            }
        }

        public void GenreList()
        {
            try
            {
                DataSet ds = RunQuery("select * from Genres");
                if (ds.Tables.Count > 0)
                {
                    DataTable dt = ds.Tables[0];
                    if (dt.Rows.Count > 0)
                    {
                        genreList.DataSource = dt;
                        genreList.DataTextField = "musicGenre";
                        genreList.DataValueField = "genreId";
                        genreList.DataBind();
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
                string query = "select a.genreId as genreid,a.musicGenre as musicgenre,count(comment) as Comment_Count,a.musicid as musicid,a.vpath as vpath,a.path as path,a.up as up,a.down as down,a.createTime as createtime,a.userid as userid,a.typeid as typeid,a.caption as caption,a.apath as apath,a.fname as fname,a.lname as lname,a.profilepic as profilepic from comments c full outer join (select * from genres as g inner join (select m.musicid as musicid,m.vpath as vpath,m.path as path,m.up as up,m.down as down,m.createTime as createtime,m.userid as userid,m.typeid as typeid,m.caption as caption,m.apath as apath,u.fname as fname,u.lname as lname,u.profilepic as profilepic from musictable as m inner join usertable u on m.userId=u.userId) as t on t.typeId=g.genreId) as a on a.musicid=c.musicId where a.userid="+userId+" or a.userid in (select frienduserid  from friends where userid="+userId+") group by a.genreId,a.musicGenre,a.musicid,a.vpath,a.path,a.up,a.down,a.createTime,a.userid,a.typeid,a.caption,a.apath,a.fname,a.lname,a.profilepic  order by a.createtime desc";

                DataSet ds = RunQuery(query);
                if (ds.Tables.Count > 0)
                {
                    DataTable dt = ds.Tables[0];
                    if (dt.Rows.Count > 0) 
                    {
                        dynamic.DataSource = dt;
                        dynamic.DataBind();
                        lblMessage.Text = "";
                    }
                    else
                    {
                        dynamic.DataSource = null;
                        dynamic.DataBind();
                        lblMessage.Text = "No music available. Start following your friends and see what they are creating.";
                    }
                }

            }
            catch (Exception ex)
            {
                lblMessage.Text = ex.Message.ToString();
            }
        }

        public void GetByGenre(int genreId)
        {
            try
            {
                string query = "select a.genreId as genreid,a.musicGenre as musicgenre,count(comment) as Comment_Count,a.musicid as musicid,a.vpath as vpath,a.path as path,a.up as up,a.down as down,a.createTime as createtime,a.userid as userid,a.typeid as typeid,a.caption as caption,a.apath as apath,a.fname as fname,a.lname as lname,a.profilepic as profilepic from comments c full outer join (select * from genres as g inner join (select m.musicid as musicid,m.vpath as vpath,m.path as path,m.up as up,m.down as down,m.createTime as createtime,m.userid as userid,m.typeid as typeid,m.caption as caption,m.apath as apath,u.fname as fname,u.lname as lname,u.profilepic as profilepic from musictable as m inner join usertable u on m.userId=u.userId) as t on t.typeId=g.genreId) as a on a.musicid=c.musicId where (a.userid="+userId+" or a.userid in (select frienduserid  from friends where userid="+userId+")) and a.genreId="+genreId+" group by a.genreId,a.musicGenre,a.musicid,a.vpath,a.path,a.up,a.down,a.createTime,a.userid,a.typeid,a.caption,a.apath,a.fname,a.lname,a.profilepic  order by a.createtime desc";

                DataSet ds = RunQuery(query);
                if (ds.Tables.Count > 0)
                {
                    DataTable dt = ds.Tables[0];
                    if (dt.Rows.Count > 0)
                    {
                        dynamic.DataSource = dt;
                        dynamic.DataBind();
                        lblMessage.Text = "";
                    }
                    else
                    {
                        dynamic.DataSource = null;
                        dynamic.DataBind();
                        lblMessage.Text = "No music available in this Genre";
                    }
                }

            }
            catch (Exception ex)
            {
                lblMessage.Text = ex.Message.ToString();
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
                    lblMessage.Text = ex.Message.ToString();
                }
            }
            return ds;
        }
        public void MessageBox(string message)
        {
            ClientScript.RegisterStartupScript(this.GetType(), "My title", "alert('" + message + "');", true);
            return;
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

        protected void lnkName_Click(object sender, EventArgs e)
        {
            LinkButton lnk = sender as LinkButton;
            int id = ((RepeaterItem)lnk.NamingContainer).ItemIndex;
            // int i = Convert.ToInt64(e.CommandArgument);
            HiddenField hidden = (HiddenField)dynamic.Items[id].FindControl("userId");
            int fid = Convert.ToInt32(hidden.Value);
            if(fid == userId)
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

        protected void genreList_SelectedIndexChanged(object sender, EventArgs e)
        {
            string genre = genreList.SelectedItem.Value;
            if(genre == "All Genres")
            {
                GetData();
            }
            else
            {
                GetByGenre(Convert.ToInt32(genre));
            }

        }

    }
}