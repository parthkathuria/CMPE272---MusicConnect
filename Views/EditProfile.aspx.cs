using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MusicConnect.Views
{
    public partial class EditProfile : System.Web.UI.Page
    {
        int userId;
        string fname;
        string lname;
        string sex;
        string dob;
        string email;
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
            }
        }

        public void GetData()
        {
            try
            {
                DataSet ds = RunQuery("select * from UserTable where userId=" + userId);
                if(ds.Tables.Count>0)
                {
                    DataTable dt = ds.Tables[0];
                    if(dt.Rows.Count>0)
                    {
                        lblProfileName.Text = dt.Rows[0]["fName"].ToString() + " " + dt.Rows[0]["lName"];
                        txtFname.Attributes["placeholder"] = dt.Rows[0]["fName"].ToString();
                        fname = dt.Rows[0]["fName"].ToString();
                        txtLname.Attributes["placeholder"] = dt.Rows[0]["lName"].ToString();
                        lname = dt.Rows[0]["lName"].ToString();
                        txtDob.Attributes["placeholder"] = dt.Rows[0]["dob"].ToString();
                        dob = dt.Rows[0]["dob"].ToString();
                        lblMail.Text = dt.Rows[0]["email"].ToString();
                        email = dt.Rows[0]["email"].ToString(); ;
                        sex = dt.Rows[0]["sex"].ToString();
                        profilePic.ImageUrl = dt.Rows[0]["profilepic"].ToString();
                        //string sex = dt.Rows[0]["sex"].ToString();
                        if (sex == "Male")
                        {
                            lblSex.Text = sex;
                        }
                        if (sex == "Female")
                        {
                            lblSex.Text = sex;
                        }
                    }
                }
            }catch(Exception ex)
            {
                lblMsg.Text = ex.Message.ToString();
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
        protected void btnSavePassword_Click(object sender, EventArgs e)
        {
            try
            {
                if ("" == txtOldPassword.Text || "" == txtNewPassword.Text || "" == txtConfirmPassword.Text)
                {
                    if ("" == txtOldPassword.Text)
                    {
                        txtOldPassword.BorderColor = System.Drawing.Color.Red;
                        lblMessage.Text = "Please enter your old password";
                    }
                    if ("" == txtNewPassword.Text)
                    {
                        txtNewPassword.BorderColor = System.Drawing.Color.Red;
                        lblMessage.Text = "Please enter your new Password";
                    }
                    if ("" == txtConfirmPassword.Text)
                    {
                        txtConfirmPassword.BorderColor = System.Drawing.Color.Red;
                        lblMessage.Text = "Please confirm your new password";
                    }
                }
                else
                {
                    string old = txtOldPassword.Text;
                    string newP = txtNewPassword.Text;
                    string conf = txtConfirmPassword.Text;
                    DataSet ds = RunQuery("select * from UserTable where email='" + email + "' and password='"+old+"'");
                    if(ds.Tables.Count>0)
                    {
                        DataTable dt = ds.Tables[0];
                        if(dt.Rows.Count>0)
                        {
                            SqlConnection con = new SqlConnection(Session["connString"].ToString());
                            SqlCommand cmd = new SqlCommand("update dbo.UserTable set password=@pass where userId= @userId", con);
                            cmd.Parameters.Add("@pass", SqlDbType.VarChar).Value = conf;
                            cmd.Parameters.Add("@userId", SqlDbType.Int).Value = userId;
                            con.Open();
                            cmd.ExecuteNonQuery();
                            con.Close();
                            lblMessage.Text = "Changes Saved";
                        }
                        else
                        {
                            lblMessage.Text = "Password dont match. Please try again";
                        }

                    }
                    else
                    {
                        lblMessage.Text = "Password dont match. Please try again";
                    }
                }
                

            }catch(Exception ex)
            {
                lblMessage.Text = ex.Message.ToString();
            }
        }

        protected void btnDiscard_Click(object sender, EventArgs e)
        {
            Response.Redirect("~/Views/Profile.aspx");
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                if ("" == txtFname.Text)
                {

                }
                else
                {
                    fname = txtFname.Text;
                }
                if ("" == txtLname.Text)
                {

                }
                else
                {
                    lname = txtLname.Text;
                }

                if ("" == txtDob.Text)
                {

                }
                else
                {
                    dob = txtDob.Text;
                }


                if (ddlSex.SelectedItem.Text == "--Select sex to change--")
                {
                    lblMsg.Text = "Please select sex";
                    ddlSex.BorderColor = System.Drawing.Color.Red;
                }
                else
                {
                    sex = ddlSex.SelectedItem.Text;
                }

                SqlConnection con = new SqlConnection(Session["connString"].ToString());
                SqlCommand cmd = new SqlCommand("update dbo.UserTable set fName=@fname,lName=@lname,sex=@sex,dob=@dob where userId= @userId", con);
                cmd.Parameters.Add("@fname", SqlDbType.VarChar).Value = fname;
                cmd.Parameters.Add("@lname", SqlDbType.VarChar).Value = lname;
                cmd.Parameters.Add("@sex", SqlDbType.VarChar).Value = sex;
                cmd.Parameters.Add("@dob", SqlDbType.VarChar).Value = dob;
                cmd.Parameters.Add("@userId", SqlDbType.Int).Value = userId;
                con.Open();
                cmd.ExecuteNonQuery();
                con.Close();
                Session["fName"] = fname;
                Session["lName"] = lname;
                lblMsg.Text = "Changes Saved";
                GetData();

            }
            catch (Exception ex)
            {
                lblMsg.Text = ex.Message.ToString();
            }
        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            string[] validFileTypes = { "jpep","jpg","png","JPG","JPEG","PNG" };
            string fPath;
            if (uploadPic.HasFile)
            {
                string filename = Path.GetFileName(uploadPic.PostedFile.FileName);
                string ext = Path.GetExtension(uploadPic.PostedFile.FileName);
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
                    if (Directory.Exists(Server.MapPath("~//ProfilePic//" + userId)))
                    {
                        fPath = Server.MapPath("~//ProfilePic//" + userId + "//");
                    }
                    else
                    {
                        Directory.CreateDirectory(Server.MapPath("~//ProfilePic//" + userId));
                        fPath = Server.MapPath("~//ProfilePic//" + userId + "//");
                    }
                    string path = Server.MapPath("~//ProfilePic//" + userId + "//" + filename);
                    String vPath = @"~\" + path.Replace(HttpContext.Current.Request.PhysicalApplicationPath, String.Empty);
                    string a = vPath.Replace("~", "..");
                    string aPath = a.Replace('\\', '/');
                    try
                    {
                        SqlConnection con = new SqlConnection(Session["connString"].ToString());
                        SqlCommand cmd = new SqlCommand("update dbo.UserTable set profilepic=@profilepic where userId= @userId", con);
                        con.Open();
                        cmd.Parameters.Add("@profilepic", SqlDbType.VarChar).Value = aPath;
                        cmd.Parameters.Add("@userId", SqlDbType.Int).Value = userId;
                        cmd.ExecuteNonQuery();
                        uploadPic.PostedFile.SaveAs(path);
                        Response.Redirect(Request.RawUrl);
                    }
                    catch (Exception ex)
                    {
                        lblError.Text = ex.Message.ToString();
                    }
                }
                else
                {
                    lblError.Text = "Invalid File type. Only .MP3 and .WAV files allowed.";
                }
            }
            else
            {
                lblError.Text = "Please select a file to upload.";
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