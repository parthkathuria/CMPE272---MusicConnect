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
    public partial class ViewMusic : System.Web.UI.Page
    {
        int userId;
        int musicId;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["userId"] == null)
            {

                Response.Redirect("~/Views/login.aspx");
            }
            else
            {
                userId = Convert.ToInt16(Session["userId"]);
                if(Session["musicID"] == null)
                {
                    Response.Redirect("~/Views/wall.aspx");
                }
                else
                {
                    lblUname.Text = Session["fName"].ToString() + " " + Session["lName"].ToString();
                    musicId = Convert.ToInt16(Session["musicId"]);
                    GetData();
                    GetComments();
                }
                
                
            }
        }


        public void GetData()
        {
            try
            {
                DataSet ds = RunQuery("select  * from dbo.MusicTable where musicId=" + musicId);
                if(ds.Tables.Count>0)
                {
                    DataTable dt = ds.Tables[0];
                    if(dt.Rows.Count>0)
                    {
                        int fId = Convert.ToInt32(dt.Rows[0]["userId"].ToString());
                        int genreId = Convert.ToInt32(dt.Rows[0]["typeId"]);
                        DataSet a = RunQuery("Select * from Genres where genreId=" + genreId);
                        DataSet d = RunQuery("select * from UserTable where userId=" + fId);
                        if(d.Tables.Count>0)
                        {
                            DataTable t = d.Tables[0];
                            if(t.Rows.Count>0)
                            {
                                lblName.Text = t.Rows[0]["fName"].ToString() + " " + t.Rows[0]["lName"].ToString();
                                profileImg.ImageUrl = t.Rows[0]["profilepic"].ToString();
                            }
                        }
                        if(a.Tables.Count>0)
                        {
                            DataTable b = a.Tables[0];
                            if(b.Rows.Count>0)
                            {
                                lblGenre.Text = "Genre: " + b.Rows[0]["musicGenre"];
                            }
                        }
                        
                        lblTimestamp.Text = dt.Rows[0]["createTime"].ToString();
                        lblUp.Text = dt.Rows[0]["up"].ToString();
                        lblDown.Text = dt.Rows[0]["down"].ToString();
                        lblCaption.Text = dt.Rows[0]["caption"].ToString();
                        audio.Attributes["src"] = dt.Rows[0]["aPath"].ToString();
                    }
                }
                DataSet ds1 = RunQuery("select * from dbo.LikeDetails where userId = " + userId + " and musicId = " + musicId);
                if (ds1.Tables.Count > 0)
                {
                    DataTable dt1 = ds1.Tables[0];
                    if(dt1.Rows.Count>0)
                    {
                        string like = dt1.Rows[0]["likeValue"].ToString();
                        if(like == "U")
                        {
                            lnkUp.Enabled = false;
                            lblMessage.Text = "You Liked this Post";
                        }
                        else if(like == "D")
                        {
                            lnkDown.Enabled = false;
                            lblMessage.Text = "You Disliked this Post";
                        }
                    }
                }

            }catch(Exception ex)
            {
                lblMessage.Text = ex.Message.ToString();
            }
        }


        public void GetComments()
        {
            try
            {
                DataSet ds = RunQuery("select * from UserTable u,comments c where  u.userid=c.followerId and musicid=" + musicId + " order by createTime ASC");
                if(ds.Tables.Count>0)
                {
                    DataTable dt = ds.Tables[0];
                    if(dt.Rows.Count>0)
                    {
                        rptComments.DataSource = dt;
                        rptComments.DataBind();
                    }
                    else
                    {
                        lblMsg.Text = "No Comments to display";
                    }
                }
                else
                {
                    lblMsg.Text = "No Comments to display";
                }
            }catch(Exception ex)
            {
                lblMsg.Text = ex.Message.ToString();
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

        protected void lnkUp_Click(object sender, EventArgs e)
        {
            
            try
            {
                DataSet ds = RunQuery("select up,down from dbo.MusicTable where musicId="+musicId);
                DataTable dt = ds.Tables[0];
                int upCount = Convert.ToInt32(dt.Rows[0]["up"]);
                int downCount = Convert.ToInt32(dt.Rows[0]["down"]);
                DataSet ds1 = RunQuery("select * from dbo.LikeDetails where userId = " + userId + " and musicId = " + musicId);
                if (ds1.Tables.Count > 0)
                {
                    DataTable dt1 = ds1.Tables[0];
                    if(dt1.Rows.Count>0)
                    {
                        string like = dt1.Rows[0]["likeValue"].ToString();
                        if(like == "D")
                        {
                            SqlConnection con = new SqlConnection(Session["connString"].ToString());
                            SqlCommand cmd = new SqlCommand("update dbo.MusicTable set up=@up,down=@down where musicId= @musicId", con);
                            SqlCommand com = new SqlCommand("update dbo.LikeDetails set likeValue=@val where musicId=@musicId and userId=@userId", con);
                            cmd.Parameters.Add("@up", SqlDbType.Int).Value = upCount + 1;
                            cmd.Parameters.Add("@down", SqlDbType.Int).Value = downCount - 1;
                            cmd.Parameters.Add("@musicId", SqlDbType.Int).Value = musicId;
                            com.Parameters.Add("@val", SqlDbType.VarChar).Value = "U";
                            com.Parameters.Add("@musicId", SqlDbType.Int).Value = musicId;
                            com.Parameters.Add("@userId", SqlDbType.Int).Value = userId;
                            con.Open();
                            cmd.ExecuteNonQuery();
                            com.ExecuteNonQuery();
                            lnkDown.Enabled = true;
                            lnkUp.Enabled = false;
                            lblMessage.Text = "You Liked this Post";
                            lblUp.Text = Convert.ToString(upCount + 1);
                            lblDown.Text = Convert.ToString(downCount - 1);
                            con.Close();
                        }
                    }
                    else
                    {
                        SqlConnection con = new SqlConnection(Session["connString"].ToString());
                        SqlCommand cmd = new SqlCommand("update dbo.MusicTable set up=@up where musicId= @musicId", con);
                        SqlCommand com = new SqlCommand("insert into dbo.LikeDetails values (@userId,@musicId,@likeValue)", con);
                        cmd.Parameters.Add("@up", SqlDbType.Int).Value = upCount + 1;
                        cmd.Parameters.Add("@musicId", SqlDbType.Int).Value = musicId;
                        com.Parameters.Add("@likeValue", SqlDbType.VarChar).Value = "U";
                        com.Parameters.Add("@musicId", SqlDbType.Int).Value = musicId;
                        com.Parameters.Add("@userId", SqlDbType.Int).Value = userId;
                        con.Open();
                        cmd.ExecuteNonQuery();
                        com.ExecuteNonQuery();
                        lnkDown.Enabled = true;
                        lnkUp.Enabled = false;
                        lblMessage.Text = "You Liked this Post";
                        lblUp.Text = Convert.ToString(upCount + 1);
                        con.Close();
                    }
                }
                else
                {
                    SqlConnection con = new SqlConnection(Session["connString"].ToString());
                    SqlCommand cmd = new SqlCommand("update dbo.MusicTable set up=@up where musicId= @musicId", con);
                    SqlCommand com = new SqlCommand("insert into dbo.LikeDetails values (@userId,@musicId,@likeValue)", con);
                    cmd.Parameters.Add("@up", SqlDbType.Int).Value = upCount + 1;
                    cmd.Parameters.Add("@musicId", SqlDbType.Int).Value = musicId;
                    com.Parameters.Add("@likeValue", SqlDbType.VarChar).Value = "U";
                    com.Parameters.Add("@musicId", SqlDbType.Int).Value = musicId;
                    com.Parameters.Add("@userId", SqlDbType.Int).Value = userId;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    com.ExecuteNonQuery();
                    lnkDown.Enabled = true;
                    lnkUp.Enabled = false;
                    lblMessage.Text = "You Liked this Post";
                    lblUp.Text = Convert.ToString(upCount + 1);
                    con.Close();
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = ex.Message.ToString();
            }
        }

        protected void lnkDown_Click(object sender, EventArgs e)
        {
            try
            {
                DataSet ds = RunQuery("select up,down from dbo.MusicTable where musicId=" + musicId);
                DataTable dt = ds.Tables[0];
                int upCount = Convert.ToInt32(dt.Rows[0]["up"]);
                int downCount = Convert.ToInt32(dt.Rows[0]["down"]);
                DataSet ds1 = RunQuery("select * from dbo.LikeDetails where userId = " + userId + " and musicId = " + musicId);
                if (ds1.Tables.Count > 0)
                {
                    DataTable dt1 = ds1.Tables[0];
                    if (dt1.Rows.Count > 0)
                    {
                        string like = dt1.Rows[0]["likeValue"].ToString();
                        if (like == "U")
                        {
                            SqlConnection con = new SqlConnection(Session["connString"].ToString());
                            SqlCommand cmd = new SqlCommand("update dbo.MusicTable set up=@up,down=@down where musicId= @musicId", con);
                            SqlCommand com = new SqlCommand("update dbo.LikeDetails set likeValue=@val where musicId=@musicId and userId=@userId", con);
                            cmd.Parameters.Add("@up", SqlDbType.Int).Value = upCount - 1;
                            cmd.Parameters.Add("@down", SqlDbType.Int).Value = downCount + 1;
                            cmd.Parameters.Add("@musicId", SqlDbType.Int).Value = musicId;
                            com.Parameters.Add("@val", SqlDbType.VarChar).Value = "D";
                            com.Parameters.Add("@musicId", SqlDbType.Int).Value = musicId;
                            com.Parameters.Add("@userId", SqlDbType.Int).Value = userId;
                            con.Open();
                            cmd.ExecuteNonQuery();
                            com.ExecuteNonQuery();
                            lnkDown.Enabled = false;
                            lnkUp.Enabled = true;
                            lblMessage.Text = "You Disliked this Post";
                            lblDown.Text = Convert.ToString(downCount + 1);
                            lblUp.Text = Convert.ToString(upCount - 1);
                            con.Close();
                        }
                    }
                    else
                    {
                        SqlConnection con = new SqlConnection(Session["connString"].ToString());
                        SqlCommand cmd = new SqlCommand("update dbo.MusicTable set up=@up where musicId= @musicId", con);
                        SqlCommand com = new SqlCommand("insert into dbo.LikeDetails values (@userId,@musicId,@likeValue)", con);
                        cmd.Parameters.Add("@up", SqlDbType.Int).Value = downCount + 1;
                        cmd.Parameters.Add("@musicId", SqlDbType.Int).Value = musicId;
                        com.Parameters.Add("@likeValue", SqlDbType.VarChar).Value = "D";
                        com.Parameters.Add("@musicId", SqlDbType.Int).Value = musicId;
                        com.Parameters.Add("@userId", SqlDbType.Int).Value = userId;
                        con.Open();
                        cmd.ExecuteNonQuery();
                        com.ExecuteNonQuery();
                        lnkDown.Enabled = false;
                        lnkUp.Enabled = true;
                        lblMessage.Text = "You Disliked this Post";
                        lblDown.Text = Convert.ToString(downCount + 1);
                        con.Close();
                    }
                }
                else
                {
                    SqlConnection con = new SqlConnection(Session["connString"].ToString());
                    SqlCommand cmd = new SqlCommand("update dbo.MusicTable set up=@up where musicId= @musicId", con);
                    SqlCommand com = new SqlCommand("insert into dbo.LikeDetails values (@userId,@musicId,@likeValue)", con);
                    cmd.Parameters.Add("@up", SqlDbType.Int).Value = downCount + 1;
                    cmd.Parameters.Add("@musicId", SqlDbType.Int).Value = musicId;
                    com.Parameters.Add("@likeValue", SqlDbType.VarChar).Value = "D";
                    com.Parameters.Add("@musicId", SqlDbType.Int).Value = musicId;
                    com.Parameters.Add("@userId", SqlDbType.Int).Value = userId;
                    con.Open();
                    cmd.ExecuteNonQuery();
                    com.ExecuteNonQuery();
                    lnkDown.Enabled = false;
                    lnkUp.Enabled = true;
                    lblMessage.Text = "You Disliked this Post";
                    lblDown.Text = Convert.ToString(downCount + 1);
                    con.Close();
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = ex.Message.ToString();
            }
        }

        protected void btnComment_Click(object sender, EventArgs e)
        {
            if("" == txtComment.Text)
            {
                txtComment.BorderColor = System.Drawing.Color.Red;
                txtComment.Attributes["placeholder"] = "Please write something..";
            }
            else
            {
                txtComment.BorderColor = System.Drawing.Color.Empty;
                txtComment.Attributes["placeholder"] = "Comment";
                lblMsg.Text = "";
                try
                {
                    SqlConnection con = new SqlConnection(Session["connString"].ToString());
                    SqlCommand com = new SqlCommand("insert into dbo.Comments values (@comment,@musicId,@followerId,@createTime)", con);
                    com.Parameters.Add("@comment", SqlDbType.VarChar).Value = txtComment.Text;
                    com.Parameters.Add("@musicId", SqlDbType.Int).Value = musicId;
                    com.Parameters.Add("@followerId", SqlDbType.Int).Value = userId;
                    com.Parameters.Add("@createTime", SqlDbType.DateTime).Value = System.DateTime.Now;
                    con.Open();
                    com.ExecuteNonQuery();
                    con.Close();
                    Response.Redirect(Request.RawUrl);
                }catch(Exception ex)
                {
                    lblMsg.Text = ex.Message.ToString();
                }
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