<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ShareMusic.aspx.cs" Inherits="MusicConnect.Views.ShareMusic" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
    <title>music connect - Share Music</title>
    <link href="../css/bootstrap.css" rel="stylesheet" />
    <link href="../css/sb-admin.css" rel="stylesheet" />
    <link href="../font-awesome/css/font-awesome.css" rel="stylesheet" />
    <script src="../js/jquery-1.10.2.js"></script>
    <script src="../js/bootstrap.js"></script>
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
                        <li class="active"><a href="ShareMusic.aspx"><i class="fa fa-share"></i>&nbsp Share Music</a></li>
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
                                    <asp:LinkButton ID="lnkLogout" CssClass="btn btn-link" runat="server" OnClick="lnkLogout_Click" ><i class="fa fa-power-off"></i>&nbsp Log Out</asp:LinkButton></li>
                            </ul>
                        </li>
                    </ul>
                </div>
                <!-- /.navbar-collapse -->
            </nav>
            <div id="page-wrapper">
                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                    <ContentTemplate>
                        <div class="col-lg-5">
                            <ul class="nav nav-tabs" style="margin-bottom: 15px;">
                                <li id="musicTab" class="active" runat="server"><a href="#music" data-toggle="tab">Upload Music</a></li>
                            </ul>
                            <div id="myTabContent" class="tab-content" style="text-align: left">
                                <div class="tab-pane fade active in" id="music" style="text-align: left" runat="server">
                                    <div class="form-group">
                                        <div class="col-lg-6" style="text-align: left">
                                           Select Genre:
                                        <asp:DropDownList ID="genreList" runat="server" CssClass="form-control" AppendDataBoundItems="True" >
                                            <asp:ListItem>--Select Genre--</asp:ListItem>
                                            </asp:DropDownList>
                                            <br />
                                            </div>
                                        <br />
                                        <div class="col-lg-10" style="text-align: left">
                                            <asp:FileUpload ID="uploadMusic" CssClass="btn btn-default" runat="server" /><br />
                                            <asp:TextBox ID="txtCaption" CssClass="form-control" runat="server" placeholder="Add Caption"></asp:TextBox>
                                           
                                           <br />
                                        </div>
                                        <div class="col-lg-10" style="text-align: left">
                                             <asp:Button ID="upload" CssClass="btn btn-primary" runat="server" Text="Upload" OnClick="upload_Click" />
                                            <asp:Label ID="lblMsg2" runat="server" CssClass="col-lg-10 control-label" Text=""></asp:Label><br />
                                            </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                    </ContentTemplate>
                    <Triggers>
                        <asp:PostBackTrigger ControlID="upload" />
                    </Triggers>
                </asp:UpdatePanel>
                <div class="col-lg-10">
                    <div class="form-horizontal">
                        <fieldset>
                            <legend></legend>

                            <div class="form-group">
                                <div class="col-lg-5">
                                     <audio id="audio" runat="server" controls="controls">
                                                <source id="aud" runat="server" />
                                            </audio>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-lg-10">
                                </div>
                            </div>
                        </fieldset>
                    </div>
                </div>

            </div>
        </div>
    </form>
</body>
</html>
