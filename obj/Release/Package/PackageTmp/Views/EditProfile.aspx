<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="EditProfile.aspx.cs" Inherits="MusicConnect.Views.EditProfile" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
    <title>music connect - Profile</title>
    <link href="../css/bootstrap.css" rel="stylesheet" />
    <link href="../css/sb-admin.css" rel="stylesheet" />
    <link href="../font-awesome/css/font-awesome.css" rel="stylesheet" />
    <script src="../js/jquery-1.10.2.js"></script>
    <script src="../js/bootstrap.js"></script>
    <script src="../js/calendar/jquery-ui-1.10.4.custom.js"></script>
    <link href="../js/calendar/jquery-ui-1.10.4.custom.css" rel="stylesheet" />


    <script>
        $(document).ready(function () {
            $("#txtDob").datepicker({
                changeMonth: true,
                changeYear: true,
                yearRange: "-100:+10",
                gotoCurrent: true
            });
            //$("#inputDate").datepicker();
        });

</script>
</head>

<body>
    <form id="form1" runat="server">
        <div id="wrapper">
            <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>

            <!-- Sidebar -->
            <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href="wall.aspx"><i class="fa fa-music"></i>&nbsp music-connect</a>
                </div>

                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse navbar-ex1-collapse">
                    <ul class="nav navbar-nav side-nav">
                        <li class=""><a href="wall.aspx"><i class="fa fa-headphones"></i>&nbsp Music Wall</a></li>
                        <li class=""><a href="ShareMusic.aspx"><i class="fa fa-share-square-o"></i>&nbsp Share Music</a></li>
                       <li class=""><a href="Followers.aspx"><i class="fa fa-group"></i>&nbsp Followers</a></li>
                        <li class=""><a href="Following.aspx"><i class="fa fa-group"></i>&nbsp Following</a></li>
                        <li class=""><a href="MostLiked.aspx"><i class="fa fa-list-ol"></i>&nbsp Most Liked Tracks</a></li>
                        <li><a>
                            <input id="txtSearch" type="text" class="form-control input-sm" runat="server" placeholder="Search" /><asp:ImageButton ID="searchButton" runat="server" ImageUrl="~/images/ic_action_search.png" Width="25" Height="25" OnClick="searchButton_Click" /></a></li>

                    </ul>

                    <ul class="nav navbar-nav navbar-right navbar-user">

                        <li class="dropdown user-dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown"><i class="fa fa-user"></i>&nbsp<asp:Label ID="lblUname" runat="server" ForeColor="White"></asp:Label>
                                <b class="caret"></b></a>
                            <ul class="dropdown-menu">
                                <li><a href="Profile.aspx"><i class="fa fa-user"></i>&nbsp Profile</a></li>
                                <li class="divider"></li>
                                <li>
                                    <asp:LinkButton ID="lnkLogout" CssClass="btn btn-link" runat="server" OnClick="lnkLogout_Click"><i class="fa fa-power-off"></i>&nbsp Log Out</asp:LinkButton></li>
                            </ul>
                        </li>
                    </ul>
                </div>
                <!-- /.navbar-collapse -->
            </nav>
            <div id="page-wrapper">
                
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <div class="col-lg-3">
                            <fieldset>
                                <asp:Image ID="profilePic" runat="server" Width="200" Height="200" />
                                <br />
                                <asp:Label ID="lblProfileName" runat="server" ForeColor="#3276b1" Font-Size="Large"></asp:Label>
                                <%--<!-- Button trigger modal -->
                                <a data-toggle="modal" href="#myModal" class="btn btn-default">Change Profile Pic</a>--%>
                                
                                <br />
                               
                               <%-- <!-- Modal -->
                                <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                                    <div class="modal-dialog">
                                        <div class="modal-content">
                                            <div class="modal-header">
                                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                                                <h4 class="modal-title">Change Profile Pic</h4>
                                            </div>
                                            <div class="modal-body">
                                                <asp:FileUpload ID="uploadPic" runat="server" CssClass="btn btn-default" />
                                            </div>
                                            <div class="modal-footer">
                                                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                                                <asp:Button ID="btnUpload" runat="server" Text="Save" CssClass="btn btn-primary" OnClick="btnUpload_Click" />
                                            </div>
                                        </div>
                                        <!-- /.modal-content -->
                                    </div>
                                    <!-- /.modal-dialog -->
                                </div>
                                <!-- /.modal -->--%>
                            </fieldset>

                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
                
                <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                    <ContentTemplate>

                        <asp:Panel ID="Panel1" runat="server" DefaultButton="btnSave">
                <div class="col-lg-8">
                    <div class="form-horizontal">
                        <fieldset>
                            <legend>Edit Profile</legend>
                            <div class="form-group" style="text-align: right">
                                <div class="col-lg-12">
                                    <a href="Profile.aspx" class="btn btn-default"><i class="fa fa-backward"></i>&nbsp Back to Profile</a>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="inputName" class="col-lg-2 control-label">Name</label>
                                <div class="col-lg-5">
                                    <asp:TextBox ID="txtFname" placeholder="First Name" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                                <div class="col-lg-5">
                                    <asp:TextBox ID="txtLname" placeholder="Last Name" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="sex" class="col-lg-2 control-label">Sex</label>
                                <div class="col-lg-5">
                                    <asp:Label ID="lblSex" runat="server" Text="" CssClass="control-label"></asp:Label>
                                </div>
                                <div class="col-lg-5">
                                    <asp:DropDownList ID="ddlSex" CssClass="form-control" runat="server">
                                        <asp:ListItem>--Select sex to change--</asp:ListItem>
                                        <asp:ListItem>Male</asp:ListItem>
                                        <asp:ListItem>Female</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                                
                            </div>
                            <div class="form-group">
                                <label for="dob" class="col-lg-2 control-label">BirthDate</label>
                                <div class="col-lg-5">
                                    <asp:TextBox ID="txtDob" runat="server" CssClass="form-control"></asp:TextBox>
                                </div>
                                
                            </div>
                            <div class="form-group">
                                <label for="Email" class="col-lg-2 control-label">Email</label>
                                <div class="col-lg-5">
                                    <asp:Label ID="lblMail" CssClass="form-control" runat="server" Text=""></asp:Label>
                                </div>
                                
                            </div>
                            <div class="form-group">
                                <div class="col-lg-5 col-lg-offset-2">
                                    <asp:Button ID="btnSave" CssClass="btn btn-primary" runat="server" Text="Save Changes" OnClick="btnSave_Click" />
                                    <asp:Button ID="btnDiscard" runat="server" Text="Discard"  CssClass="btn btn-default" OnClientClick="return confirm('All changes will be discarded. Are you sure?');"/>
                                    
                                </div>
                                
                            </div>
                            <div class="form-group">
                                <div class="col-lg-5">
                                   
                                    <asp:Label ID="lblMsg" runat="server" Text="" CssClass="control-label"></asp:Label>
                                </div>
                                
                            </div>
                        </fieldset>
                    </div>

                </div>
                            </asp:Panel>
                         </ContentTemplate>
                </asp:UpdatePanel>
                <div class="col-lg-8 col-lg-offset-3">
                    <div class="form-horizontal">
                        <fieldset>
                            <legend>Change Profile Pic</legend>
                           
                            <asp:Panel ID="Panel3" runat="server" DefaultButton="btnUpload">
                            <div class="form-group">
                                <div class="col-lg-8">
                                     <asp:FileUpload ID="uploadPic" runat="server" CssClass="btn btn-default" /><br />
                                    <asp:Label ID="lblError" runat="server" Text="" CssClass="control-label"></asp:Label>
                                
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-lg-8">
                                     <asp:Button ID="btnUpload" runat="server" Text="Save" CssClass="btn btn-primary" OnClick="btnUpload_Click" />
                                </div>
                            </div>
                            </asp:Panel>
                                   
                        </fieldset>
                    </div>
                </div>
                <div class="col-lg-8 col-lg-offset-3">
                    <div class="form-horizontal">
                        <fieldset>
                            <legend>Change Password</legend>
                            <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                <ContentTemplate>
                            <asp:Panel ID="Panel2" runat="server" DefaultButton="btnSavePassword">
                            <div class="form-group">
                                <label for="inputPassword" class="col-lg-3 control-label">Old Password</label>
                                <div class="col-lg-5">
                                    <asp:TextBox ID="txtOldPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Old Password"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="inputPassword" class="col-lg-3 control-label">New Password</label>
                                <div class="col-lg-5">
                                    <asp:TextBox ID="txtNewPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="New Password"></asp:TextBox>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="inputConfirmPassword" class="col-lg-3 control-label">Confirm Password</label>
                                <div class="col-lg-5">
                                    <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="Confirm Password"></asp:TextBox>
                                </div>
                            </div>
                             <div class="form-group">
                                <div class="col-lg-10 col-lg-offset-2">
                                    <asp:Button ID="btnSavePassword" runat="server" Text="Save Changes" CssClass="btn btn-primary" OnClick="btnSavePassword_Click"/>
                                    <asp:Label ID="lblMessage" runat="server" CssClass="col-lg-10 control-label" Text=""></asp:Label>
                                </div>
                            </div>
                                </asp:Panel>
                                    </ContentTemplate>
                            </asp:UpdatePanel>
                        </fieldset>
                    </div>
                </div>
            </div>
        </div>
    </form>
</body>
</html>
