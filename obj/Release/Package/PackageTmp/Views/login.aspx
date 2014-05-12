<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="MusicConnect.Views.login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta name="description" content="" />
    <meta name="author" content="" />

    <title>Music Connect - Login</title>

    <!-- Bootstrap core CSS -->
    <link href="../css/bootstrap.css" rel="stylesheet" />
    <script src="../js/jquery-1.10.2.js"></script>
        <script src="../js/bootstrap.js"></script>
    <script src="../js/calendar/jquery-ui-1.10.4.custom.js"></script>
    <!-- Add custom CSS here -->
    <link href="../js/calendar/jquery-ui-1.10.4.custom.css" rel="stylesheet" />
    <link href="../font-awesome/css/font-awesome.css" rel="stylesheet" />
    <style>
        body {
            margin-top: 60px;
        }
    </style>

   
   <%-- <script>
        /*validation code starts*/
        var color = "#F71313";
        var default_color = "#ACB6C0";
        function frm_register(){

            var Fname = $.trim($("#inputFname").val());
            //alert(Fname);
            //alert(document.getElementById("inputFname"));
            var Lname = $.trim($("#inputLname").val());
            var Email 						= $.trim($("#inputEmail").val());
            var inputDate = $.trim($("#dateOfBirth").val());
			
            var inputNewPassword 			= $.trim($("#inputPassword").val());
            var passwordLength 				= inputNewPassword.length;
            var inputConfirmPassword = $.trim($("#confirmPassword").val());
            var error_count = 0;
            var name_flag = 0;
            if(Fname == ""){
                error_count++;
                $("#inputFname").css("border-color", color);
                name_flag = 1;
           /* }else if(chk_spcl_chr(name)== false){	
                error_count++;
                name_flag = 2;
                $("#inputFname").css("border-color", color);*/
            }else{
                $("#inputFname").css("border-color", default_color);
            }
			
            if(Lname == ""){
                error_count++;
                name_flag = 1;
                $("#inputLname").css("border-color", color);
            /*}else if(chk_spcl_chr(name) == false){	
                error_count++;
                name_flag =2;
                $("#inputLname").css("border-color", color);*/
            }else{
		
                $("#inputLname").css("border-color",default_color);
            }
			
            if(name_flag == 1){
                $("#error_name").html("First and Last name cannot be blank.");
            }else if(name_flag == 2){
                $("#error_name").html("First and Last name cannot contain special characters.");
            }else{
                $("#error_name").html("");
            }
			
            if($("#Sex").is(":checked")== true){
                $("#inputSex").css("border-color",default_color);
                $("#error_sex").html("");
            }else{error_count++;
                $("#error_sex").html("Please select one option");
                $("#inputSex").css("border-color",color);
            }
			
            if(inputDate != ''){
                $("#error_dob").html("");
                $("#dateOfBirth").css("border-color", default_color);
            }else{
                error_count++;
                $("#error_dob").html("Please enter date of birth");
                $("#dateOfBirth").css("border-color", color);
            }
			
            /*if(IsEmail(Email) == true){
                $("#error_email").html("");
                $("#inputEmail").css("border-color",default_color);
            }else{
                error_count++;
                $("#error_email").html("Please enter a valid Email");
                $("#inputEmail").css("border-color",color);
            }*/
			
            if((inputNewPassword != inputConfirmPassword) ||(inputNewPassword =='' || (passwordLength < 8)) ){
                error_count++;
                $("#inputPassword").css("border-color",color);
                $("#inputPassword").val("");
                $("#confirmPassword").val("");
                if(inputNewPassword ==''){
                    $("#error_password").html("Please enter a your password");
                }else if(passwordLength < 8){
                    $("#error_password").html("Password should be atleast 8 characters");
                }else if(inputNewPassword != inputConfirmPassword){
                    $("#error_password").html("Your password doesn't match");
                }
            }else{
                $("#error_password").html("");
                $("#inputPassword").css("border-color",default_color);
            }
			
            if(error_count>0){
                return false;
            }else{
                return true;
            }
        }

		
        function reset_frm(){
            $("#inputFname").val("");
            $("#inputLname").val("");
            $("#inputEmail").val("");
            $("#inputPassword").val("");
            $("#dateOfBirth").val("");
            $("#confirmPassword").val("");
            return false;
        }
        function IsEmail(email) {
            var regex = /^([a-zA-Z0-9_.+-])+\@(([a-zA-Z0-9-])+\.)+([a-zA-Z0-9]{2,4})+$/;
            return regex.test(email);
        }

        function chk_spcl_chr(val)
        {
            var regex = new RegExp("^[a-zA-Z0-9 ]+$");
            var key = val;
            if (regex.test(key) == false) {
                return false;
            }
            return true;
        }

        function chk_login() {

            var Email = $("#email").val();
            var password = $("#password").val();
            error_count = 0;
            if(IsEmail(Email) == true){
                /*error_count++;
                $.ajax({
                    url: "chkemail.php?email="+Email",
                    async: true,
                success: function(result){
                    if(result){
                        error_cout--;
                        $("#error_Lemail").html("");
                        $("#inputLEmail").css("border-color",default_color);
                    }else{
                        error_count++;
                        $("#error_Lemail").html("Email already exists");
                        $("#inputLEmail").css("border-color",color);
                    }
                }
            });*/
            $("#error_Lemail").html("");
            $("#email").css("border-color", default_color);
        }else{
		error_count++;
        $("#error_Lemail").html("Please enter a valid Email");
        $("#email").css("border-color", color);
        }
	
        if(password != ''){
            $("#error_Lpassword").html("");
            $("#password").css("border-color", default_color);
        }else{
            error_count++;
            $("#error_Lpassword").html("Please your password");
            $("#password").css("border-color", color);
        }
	
        if(error_count>0){
            return false;
        }else{
            return true;
        }
        }
        /*Validation code end*/
</script>--%>

    <script>
        $(document).ready(function () {
            $("#dateOfBirth").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: "-100:+10",
                gotoCurrent: true
            });
            //$("#inputDate").datepicker();
        });

</script>
<style>
.error{
	 color: #F71313;
    float: right;
    font-size: 11px;
    padding-right: 20px;
    text-align: center;
}
</style>
  


</head>
<body>
    <form id="form1" runat="server">
        <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="../index.aspx"><i class="fa fa-music"></i>&nbsp music-connect</a>
                </div>

                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse navbar-ex1-collapse">
                    <ul class="nav navbar-nav navbar-right">
                        <li><a href="login.aspx">Sign Up</a></li>
                        <li><a href="login.aspx">Login</a></li>
                    </ul>
                </div>
                <!-- /.navbar-collapse -->
            </div>
            <!-- /.container -->
        </nav>
        <div class="container">
            <div class="row">
                <div class="col-lg-6">
                    <asp:Panel ID="Panel1" runat="server" DefaultButton="registerButton">
                    <div class="form-horizontal" id="RegistrationForm">
                        <fieldset>
                            <legend>Register</legend>
                            <div class="form-group">
                                <label for="inputName" class="col-lg-2 control-label">Name</label>
                                <div class="col-lg-5">
                                    <asp:TextBox CssClass="form-control" ID="inputFname" runat="server" placeholder="First Name" ValidationGroup="register"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="validFname" runat="server" ErrorMessage="First Name field cannot be empty." ForeColor="Red" ValidationGroup="register" Font-Size="Smaller" CssClass="error" ControlToValidate="inputFname"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col-lg-5">
                                    <asp:TextBox CssClass="form-control" ID="inputLname" runat="server" placeholder="Last Name" ValidationGroup="register"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="validLname" runat="server" ControlToValidate="inputLname" ForeColor="Red" ValidationGroup="register" Font-Size="Smaller" CssClass="error" ErrorMessage="Last Name field cannot be empty."></asp:RequiredFieldValidator>
                                </div>
                                <label id="error_name" name="error_name" class="error"> </label>
                            </div>

                            <div class="form-group">
                                <label for="inputSex" class="col-lg-2 control-label">Sex</label>
                                <div class="col-lg-10">
                                    <label class="radio-inline">
                                    <asp:RadioButton ID="RadioButton1" runat="server" CssClass="radio" GroupName="sex" Text="Male" Checked="true" /></label>
                                    <label class="radio-inline">
                                    <asp:RadioButton ID="RadioButton2" runat="server" CssClass="radio" GroupName="sex" Text="Female" /></label>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="inputDoB" class="col-lg-2 control-label">BirthDate</label>
                                <div class="col-lg-10">
                                    <asp:TextBox ID="dateOfBirth" CssClass="form-control" runat="server" placeholder="Date of Birth" ValidationGroup="register"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="validDate" runat="server" ControlToValidate="dateOfBirth" ForeColor="Red" Font-Size="Smaller" ValidationGroup="register" CssClass="error" ErrorMessage="Date of Birth Field cannot be empty"></asp:RequiredFieldValidator>
                                </div>
                                <label id="error_dob" name="error_dob" class="error"> </label>
                            </div>
                            <div class="form-group">
                                <label for="inputEmail" class="col-lg-2 control-label">Email ID</label>
                                <div class="col-lg-10">
                                    <asp:TextBox ID="inputEmail" runat="server" CssClass="form-control" ValidationGroup="register" placeholder="Email ID"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="validEmail" runat="server" ErrorMessage="Email Id not valid" ControlToValidate="inputEmail" ValidationGroup="register" ForeColor="Red" Font-Size="Smaller" CssClass="error" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                    <asp:Label ID="lblEmail" runat="server" Text=""></asp:Label>
                                </div>
                                <label id="error_email" name="error_email" class="error"> </label>
                            </div>
                            <div class="form-group">
                                <label for="inputPassword" class="col-lg-2 control-label">Password</label>
                                <div class="col-lg-10">
                                    <asp:TextBox ID="inputPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Password" ValidationGroup="register"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="validPass" runat="server" ControlToValidate="inputPassword" ForeColor="Red" Font-Size="Smaller" ValidationGroup="register" CssClass="error" ErrorMessage="Password cannot be empty"></asp:RequiredFieldValidator>
                                </div>
                                <label id="error_password" name="error_password" class="error"> </label>
                            </div>
                            <div class="form-group">
                                <label for="inputConfirmPassword" class="col-lg-2 control-label">Confirm</label>
                                <div class="col-lg-10">
                                    <asp:TextBox ID="confirmPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Confirm Password" ValidationGroup="register"></asp:TextBox>
                                    <asp:CompareValidator ID="confirmPass" runat="server" ErrorMessage="Password do not match" ControlToCompare="inputPassword" ValidationGroup="register" ControlToValidate="confirmPassword" ForeColor="Red" Font-Size="Smaller" CssClass="error"></asp:CompareValidator>
                                </div>
                                <label id="error_Cpassword" name="error_Cpassword" class="error"> </label>
                            </div>
                            <div class="form-group">
                                <div class="col-lg-10 col-lg-offset-2">
                                    <asp:Button ID="registerButton" runat="server" Text="Register" CssClass="btn btn-primary" OnClick="registerButton_Click" ValidationGroup="register" />
                                    <asp:Button ID="cancelButton" runat="server" Text="Cancel" CssClass="btn btn-default" OnClientClick="return reset_frm()" />
                                    <asp:Label ID="message1" runat="server" CssClass="col-lg-10 control-label" Text=""></asp:Label>
                                </div>
                            </div>
                        </fieldset>
                    </div>
                        </asp:Panel>
                </div>
                <div class="col-lg-4 col-lg-offset-1">
                    <asp:Panel ID="Panel2" runat="server" DefaultButton="LoginButton">
                    <div class="form-horizontal">
                        <fieldset>
                            <legend>Login</legend>
                            <div class="form-group">
                                <label for="inputLEmail" class="col-lg-3 control-label">Email ID</label>
                                <div class="col-lg-9">
                                    <asp:TextBox ID="email" runat="server" CssClass="form-control" placeholder="Email ID" ValidationGroup="login"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="validLoginEmail" ControlToValidate="email" runat="server" ValidationGroup="login" ForeColor="Red" Font-Size="Smaller" CssClass="error" ErrorMessage="Email Id not valid" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                </div>
                                <label id="error_Lemail" name="error_Lemail" class="error"> </label>
                            </div>
                            <div class="form-group">
                                <label for="inputLPassword" class="col-lg-3 control-label">Password</label>
                                <div class="col-lg-9">
                                    <asp:TextBox ID="password" runat="server" CssClass="form-control" TextMode="Password" placeholder="Password" ValidationGroup="login"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="validLoginPass" runat="server" ErrorMessage="Please enter password." ValidationGroup="login" ControlToValidate="password" ForeColor="Red" Font-Size="Smaller" CssClass="error"></asp:RequiredFieldValidator>
                                </div>
                                <label id="error_Lpassword" name="error_Lpassword" class="error"> </label>
                            </div>
                            <div class="form-group">
                                <div class="col-lg-10 col-lg-offset-3">
                                    <asp:Button ID="LoginButton" runat="server" Text="Login" CssClass="btn btn-primary" OnClick="LoginButton_Click" ValidationGroup="login" />
                                    <asp:Label ID="message2" runat="server" CssClass="col-lg-10 control-label" Text=""></asp:Label>
                                </div>
                            </div>
                        </fieldset>
                    </div>
                        </asp:Panel>
                </div>
            </div>
        </div>
        
    </form>
</body>
    
</html>
