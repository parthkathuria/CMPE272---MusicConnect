<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Followers.aspx.cs" Inherits="MusicConnect.Views.Followers" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
    <title>music connect - Search</title>
    <link href="../css/bootstrap.css" rel="stylesheet" />
    <link href="../css/sb-admin.css" rel="stylesheet" />
    <link href="../font-awesome/css/font-awesome.css" rel="stylesheet" />
    <script src="../js/jquery-1.10.2.js"></script>
    <script src="../js/bootstrap.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div id="wrapper">
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
                        <li class="active"><a href="Followers.aspx"><i class="fa fa-group"></i>&nbsp Followers</a></li>
                        <li class=""><a href="Following.aspx"><i class="fa fa-group"></i>&nbsp Following</a></li>
                        <li class=""><a href="MostLiked.aspx"><i class="fa fa-list-ol"></i>&nbsp Most Liked Tracks</a></li>
                        <li class=""><a>
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

                <div class="col-lg-10">
                    <div class="form-horizontal">
                        <fieldset>
                            <legend>Followers:</legend>
                            <div class="form-group">
                                <asp:Label ID="lblMessage" runat="server" CssClass="control-label"></asp:Label>
                                <asp:Repeater ID="followerList" runat="server">
                                    <ItemTemplate>
                                        <div class="col-lg-8">
                                            <asp:HiddenField ID="userId" runat="server" Value='<%#Eval("userId") %>' />
                                            <asp:Image ID="imgProfile" runat="server" Width="50" Height="50" ImageUrl='<%#Eval("profilepic") %>'/>
                                            <asp:LinkButton ID="lnkName" runat="server" CssClass="btn btn-link" OnClick="lnkName_Click"><%#Eval("fName") %>&nbsp <%#Eval("lName") %></asp:LinkButton>
                                            <br />
                                            <br />
                                            <legend></legend>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </fieldset>
                    </div>
                </div>

            </div>
        </div>
    </form>
</body>
</html>
