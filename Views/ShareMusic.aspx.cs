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

namespace MusicConnect.Views
{
    public partial class ShareMusic : System.Web.UI.Page
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
                if(ds.Tables.Count>0)
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
            }catch(Exception ex)
            {
                lblMsg2.Text = ex.Message.ToString();
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

        protected void upload_Click(object sender, EventArgs e)
        {
            string[] validFileTypes = {"mp3" };
            string fPath;
            string genre = genreList.SelectedItem.Text;
            if (genre.Equals("--Select Genre--"))
            {
                lblMsg2.Text = "Please select Genre";
            }
            else
            {
                int genreId = Convert.ToInt16(genreList.SelectedValue);
                string caption = txtCaption.Text;
                if (uploadMusic.HasFile)
                {
                    string filename = Path.GetFileName(uploadMusic.PostedFile.FileName);
                    string ext = Path.GetExtension(uploadMusic.PostedFile.FileName);
                    bool isValidFile = false;

                    for (int i = 0; i < validFileTypes.Length; i++)
                    {

                        if (ext == "." + validFileTypes[i])
                        {

                            isValidFile = true;

                            break;

                        }

                    }
                    if (isValidFile)
                    {
                        if (Directory.Exists(Server.MapPath("~//Music//" + userId)))
                        {
                            fPath = Server.MapPath("~//Music//" + userId + "//");
                        }
                        else
                        {
                            Directory.CreateDirectory(Server.MapPath("~//Music//" + userId));
                            fPath = Server.MapPath("~//Music//" + userId + "//");
                        }
                        string path = Server.MapPath("~//Music//" + userId + "//" + filename);
                        String vPath = @"~\" + path.Replace(HttpContext.Current.Request.PhysicalApplicationPath, String.Empty);
                        string a = vPath.Replace("~","..");
                        string aPath = a.Replace('\\', '/');
                        try
                        {
                            SqlConnection con = new SqlConnection(Session["connString"].ToString());
                            SqlCommand cmd = new SqlCommand("insert into dbo.MusicTable values (@vPath,@path,@up,@down,@createTime,@userId,@typeId,@caption,@aPath)", con);
                            con.Open();
                            cmd.Parameters.Add("@vPath", SqlDbType.VarChar).Value = vPath;
                            cmd.Parameters.Add("@path", SqlDbType.VarChar).Value = path;
                            cmd.Parameters.Add("@up", SqlDbType.Int).Value = 0;
                            cmd.Parameters.Add("@down", SqlDbType.VarChar).Value = 0;
                            cmd.Parameters.Add("@createTime", SqlDbType.DateTime).Value = DateTime.Now;
                            cmd.Parameters.Add("@userId", SqlDbType.Int).Value = userId;
                            cmd.Parameters.Add("@typeId", SqlDbType.Int).Value = genreId;
                            cmd.Parameters.Add("@caption", SqlDbType.VarChar).Value = caption;
                            cmd.Parameters.Add("@aPath", SqlDbType.VarChar).Value = aPath;
                            cmd.ExecuteNonQuery();
                            aud.Visible = true;
                            aud.Attributes["src"] = vPath;
                            string[] ex = ext.Split('.');
                            aud.Attributes["type"] = "audio/" + ex[1];
                            uploadMusic.PostedFile.SaveAs(path);
                            lblMsg2.Text = "File uploaded successfully";
                        }
                        catch (Exception ex)
                        {
                            lblMsg2.Text = ex.Message.ToString();
                        }
                    }
                    else
                    {
                        lblMsg2.Text = "Invalid File type. Only .MP3 and .WAV files allowed.";
                    }
                }
                else
                {
                    lblMsg2.Text = "Please select a file to upload.";
                }
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

        protected void lnkLogout_Click(object sender, EventArgs e)
        {
            Session["userId"] = null;
            Session.Clear();
            Session.Abandon();
            Response.Redirect("~/index.aspx");
        }
    }
}