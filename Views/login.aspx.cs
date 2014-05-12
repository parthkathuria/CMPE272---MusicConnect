using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Sql;

namespace MusicConnect.Views
{
    public partial class login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["connString"] = "";
        }

        protected void registerButton_Click(object sender, EventArgs e)
        {
            try
            {
                string fname = inputFname.Text;
                string lname = inputLname.Text;
                string sex = "";
                if(RadioButton1.Checked == true){
                    sex = RadioButton1.Text;
                }
                if (RadioButton2.Checked == true)
                {
                    sex = RadioButton2.Text;
                }

                string email = inputEmail.Text;
                string password = confirmPassword.Text;

                bool emailChk = CheckUserName();
                if (emailChk) {

                    SqlConnection con = new SqlConnection(Session["connString"].ToString());
                    SqlCommand cmd = new SqlCommand("insert into dbo.UserTable values (@fName,@lName,@email,@sex,@dob,@password,@profilepic)", con);
                    con.Open();
                    cmd.Parameters.Add("@fName", SqlDbType.VarChar).Value = fname;
                    cmd.Parameters.Add("@lName", SqlDbType.VarChar).Value = lname;
                    cmd.Parameters.Add("@email", SqlDbType.VarChar).Value = email;
                    cmd.Parameters.Add("@dob", SqlDbType.VarChar).Value = dateOfBirth.Text;
                    cmd.Parameters.Add("@sex", SqlDbType.VarChar).Value = sex;
                    cmd.Parameters.Add("@password", SqlDbType.VarChar).Value = password;
                    cmd.Parameters.Add("@profilepic", SqlDbType.VarChar).Value = "../images/default-profile-pic.jpg";
                    cmd.ExecuteNonQuery();
                    con.Close();
                    message1.ForeColor = System.Drawing.Color.Green;
                    message1.Text = "Registration Complete";
                }
                else
                {
                    inputEmail.BorderColor = System.Drawing.Color.Red;
                    inputEmail.BorderStyle = BorderStyle.Solid;
                    inputEmail.Focus();
                    lblEmail.Text = "Email already in use";
                    lblEmail.ForeColor = System.Drawing.Color.Red;
                    message1.ForeColor = System.Drawing.Color.Red;
                    message1.Text = "Error in registration.Please try again.";
                }

            }
            catch (Exception ex)
            {
                message1.Text = ex.Message.ToString();
            }
        }

        public bool CheckUserName()
        {
            SqlConnection con = new SqlConnection(Session["connString"].ToString());
            try
            {
                SqlCommand cmd = new SqlCommand("select * from dbo.UserTable where email =@email ", con);
                con.Open();
                cmd.Parameters.Add("@email", SqlDbType.VarChar).Value = inputEmail.Text;
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.HasRows)
                {
                    return false;
                }
                else
                {
                    return true;
                }

            }
            catch (Exception ex)
            {
                message1.Text = ex.Message.ToString();
                return false;
            }
            finally
            {
                con.Close();
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

        protected void inputEmail_TextChanged(object sender, EventArgs e)
        {
            if ("" == inputEmail.Text)
            {
                inputEmail.BorderColor = System.Drawing.Color.Red;
                inputEmail.BorderStyle = BorderStyle.Solid;
                inputEmail.Focus();
                lblEmail.Text = "Please enter email Id";
                lblEmail.ForeColor = System.Drawing.Color.Red;
            }
            else
            {
                bool checkEmail = CheckUserName();
                if (checkEmail)
                {
                    inputEmail.BorderColor = System.Drawing.Color.Green;
                    inputEmail.BorderStyle = BorderStyle.Solid;
                    inputPassword.Focus();
                    lblEmail.Text = "Available";
                    lblEmail.ForeColor = System.Drawing.Color.Green;
                }
                else
                {
                    inputEmail.BorderColor = System.Drawing.Color.Red;
                    inputEmail.BorderStyle = BorderStyle.Solid;
                    inputEmail.Focus();
                    lblEmail.Text = "Email already in use";
                    lblEmail.ForeColor = System.Drawing.Color.Red;
                }
            }
        }

        protected void LoginButton_Click(object sender, EventArgs e)
        {
            SqlConnection con = new SqlConnection(Session["connString"].ToString());
            string pass = password.Text;
            try
            {
                DataSet ds = RunQuery("select * from dbo.UserTable where email = '" + email.Text +"'");
                if (ds.Tables.Count > 0)
                {
                    DataTable dt = ds.Tables[0];
                    if (dt.Rows.Count > 0)
                    {
                        for (int i = 0; i < dt.Rows.Count; i++)
                        {
                            if (dt.Rows[i]["password"].ToString().Equals(pass))
                            {
                                Session["userId"] = dt.Rows[i]["userId"].ToString();
                                Session["fName"] = dt.Rows[i]["fName"].ToString();
                                Session["lName"] = dt.Rows[i]["lName"].ToString();
                                Response.Redirect("~/Views/wall.aspx");
                            }
                            else
                            {
                                message2.Text = "Invalid Username or Password. Please try again.";
                            }
                        }
                    }
                    else
                    {
                        message2.Text = "Invalid Username or Password. Please try again.";
                    }
                }

            }
            catch (Exception ex)
            {
                message2.Text = ex.Message.ToString();
            }
        }
    }
}