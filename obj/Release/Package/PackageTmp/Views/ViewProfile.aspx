<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewProfile.aspx.cs" Inherits="MusicConnect.Views.ViewProfile" %>

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
                                <asp:Image ID="imgProfile" runat="server" Width="200" Height="200"/>
                                <br />
                                <asp:Label ID="lblProfileName" runat="server" ForeColor="#3276b1" Font-Size="Large"></asp:Label>
                            </fieldset>

                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>
                <div class="col-lg-8">
                    <div class="form-horizontal">
                        <fieldset>
                            <legend>Profile</legend>
                            <div class="form-group" style="text-align: right">
                                <div class="col-lg-12">
                                    <asp:LinkButton ID="lnkFollow" CssClass="btn btn-primary" runat="server" OnClick="lnkFollow_Click"><i class="fa fa-plus"></i>&nbsp Follow</asp:LinkButton>
                                    <asp:LinkButton ID="lnkUnFollow" CssClass="btn btn-default" runat="server" OnClick="lnkUnFollow_Click"><i class="fa fa-arrows-alt"></i>&nbsp Unfollow</asp:LinkButton>
                                </div>
                            </div>
                            <div class="form-group" style="text-align: center">
                                <div class="col-lg-6">
                                    <table>
                                        <thead>
                                            <tr>
                                                <th style="width:100px;text-align:center;">
                                                    <asp:Label ID="lblPosts" runat="server"></asp:Label>

                                                </th>
                                                <th style="width:100px;text-align:center;">
                                                    <asp:Label ID="lblFollowers" runat="server"></asp:Label>
                                                </th>
                                                <th style="width:100px;text-align:center">
                                                    <asp:Label ID="lblFollowing" runat="server"></asp:Label>

                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <tr>
                                                <td style="width:100px;text-align:center"><label class="control-label" style="font-weight:100">Posts</label></td>
                                                <td style="width:100px;text-align:center"><label class="control-label" style="font-weight:100">Followers</label></td>
                                                <td style="width:100px;text-align:center"><label class="control-label" style="font-weight:100">Following</label></td>
                                            </tr>
                                        </tbody>
                                    </table>

                                </div>
                            </div>
                        </fieldset>
                    </div>
                </div>
                <div id="dynamicUpdate" class="col-lg-8 col-lg-offset-3" runat="server">
                    <fieldset>
                        
                        <legend>Posts</legend>
                        <asp:Label ID="lblMessage" runat="server" ForeColor="#3276b1"></asp:Label>
                        <asp:Repeater ID="dynamic" runat="server">
                            <ItemTemplate>
                                <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                    <ContentTemplate>
                                        <div class="form-horizontal">

                                            <div class="form-group">
                                                <div class="col-lg-6">
                                                    <asp:Image ID="profileImg" ImageUrl='<%#Eval("profilepic") %>' Width="20" Height="20" runat="server" />
                                                    <asp:LinkButton ID="lnkName" runat="server" Font-Underline="false"><%#Eval("fname") %>&nbsp<%#Eval("lname") %></asp:LinkButton>
                                                    <%--<asp:Label ID="lblName" runat="server" ForeColor="#3276b1"><%#Eval("fname") %>&nbsp<%#Eval("lname") %></asp:Label>--%>
                                                    <br />
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<label for="timestamp" style="color: GrayText;font-weight:100; font-size: smaller">Updated on <i class="fa fa-clock-o"></i>&nbsp<%#Eval("createtime") %></label>

                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-lg-6">
                                                    <label for="caption" class="control-label"><%#Eval("caption") %></label>
                                                    <br />
                                                    <br />
                                                    <audio controls="controls">
                                                        <source src="<%#Eval("apath") %>" type="audio/mp3" />
                                                    </audio>
                                                    <br />
                                                    <label for="genre" style="color: GrayText;font-weight:100; font-size: smaller">Genre:&nbsp<%#Eval("musicgenre") %></label><br />
                                                </div>
                                            </div>
                                            <div class="form-group">
                                                <div class="col-lg-6">
                                                    <asp:HiddenField ID="musicId" runat="server" Value='<%#Eval("musicid") %>' />
                                                    <asp:LinkButton ID="lnkButton" runat="server" CssClass="btn btn-default" OnClick="lnkButton_Click"><i class="fa fa-thumbs-o-up"></i> <%#Eval("up") %> &nbsp&nbsp <i class="fa fa-thumbs-o-down"></i> <%#Eval("down") %> &nbsp&nbsp Comments <%#Eval("Comment_Count") %></asp:LinkButton>
                                                    <%-- <asp:LinkButton ID="lnkUp" runat="server" Font-Underline="false" OnClick="lnkUp_Click"><i class="fa fa-thumbs-o-up"></i> <%#Eval("up") %></asp:LinkButton>&nbsp&nbsp&nbsp&nbsp
                                                    <asp:LinkButton ID="lnkDown" runat="server" Font-Underline="false" OnClick="lnkDown_Click"><i class="fa fa-thumbs-o-down"></i> <%#Eval("down") %></asp:LinkButton>--%>
                                                    <%--<a class="btn btn-default" data-toggle="modal" href="#myModal"><i class="fa fa-thumbs-o-up"></i> <%#Eval("up") %> &nbsp&nbsp <i class="fa fa-thumbs-o-down"></i> <%#Eval("down") %></a>--%>
                                                    <%--<asp:LinkButton ID="lnkUp" CssClass="btn btn-default" runat="server"><i class="fa fa-thumbs-o-up"></i> <%#Eval("up") %> &nbsp&nbsp <i class="fa fa-thumbs-o-down"></i> <%#Eval("down") %></asp:LinkButton>--%>
                                                </div>
                                            </div>

                                        </div>
                                        <legend></legend>
                                    </ContentTemplate>
                                    <Triggers>
                                        <asp:PostBackTrigger ControlID="lnkButton" />
                                    </Triggers>
                                </asp:UpdatePanel>
                            </ItemTemplate>
                        </asp:Repeater>
                    </fieldset>

                </div>
                
            </div>
        </div>
    </form>
</body>
</html>
