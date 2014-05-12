<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewMusic.aspx.cs" Inherits="MusicConnect.Views.ViewMusic" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1" />
    <title>music connect - Music</title>
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
                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                    <ContentTemplate>

                   
                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse navbar-ex1-collapse">
                    <ul class="nav navbar-nav side-nav">
                        <li class="active"><a href="wall.aspx"><i class="fa fa-headphones"></i>&nbsp Music Wall</a></li>
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
                         </ContentTemplate>
                    <Triggers>
                        <asp:PostBackTrigger ControlID="searchButton" />
                    </Triggers>
                </asp:UpdatePanel>
                <!-- /.navbar-collapse -->
            </nav>
            <div id="page-wrapper">
                <div id="dynamicUpdate" class="col-lg-6" runat="server">
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <div class="form-horizontal">
                                <fieldset>
                                    <legend></legend>
                                    <div class="form-group">
                                        <div class="col-lg-6">
                                            <asp:Image ID="profileImg" Width="40" Height="40" runat="server" />
                                            <asp:Label ID="lblName" runat="server"></asp:Label>
                                            <br />
                                            &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<label for="timestamp" style="color: GrayText; font-size: smaller;font-weight:100">Updated on <i class="fa fa-clock-o"></i></label>
                                            <asp:Label ID="lblTimestamp" runat="server" Text="" ForeColor="GrayText" Font-Size="Smaller"></asp:Label>

                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-lg-6">
                                            <asp:Label ID="lblCaption" runat="server" Text="" CssClass="control-label"></asp:Label>
                                            <br />
                                            <br />
                                            <audio controls="controls">
                                                <source id="audio" runat="server" type="audio/mp3" />
                                            </audio>
                                            <br />
                                            <asp:Label ID="lblGenre" runat="server" CssClass="control-label" Font-Size="Smaller" ForeColor="GrayText"></asp:Label>
                                        </div>
                                    </div>
                                    <div class="form-group">
                                        <div class="col-lg-6">
                                            <%--<asp:LinkButton ID="lnkButton" runat="server" CssClass="btn btn-default" OnClick="lnkButton_Click"><i class="fa fa-thumbs-o-up"></i> <%#Eval("up") %> &nbsp&nbsp <i class="fa fa-thumbs-o-down"></i> <%#Eval("down") %></asp:LinkButton>--%>
                                            <asp:LinkButton ID="lnkUp" runat="server" Font-Underline="false" OnClick="lnkUp_Click"><i class="fa fa-thumbs-o-up"></i></asp:LinkButton>&nbsp<asp:Label ID="lblUp" runat="server" Text=""></asp:Label> &nbsp&nbsp&nbsp&nbsp
                                            <asp:LinkButton ID="lnkDown" runat="server" Font-Underline="false" OnClick="lnkDown_Click"><i class="fa fa-thumbs-o-down"></i></asp:LinkButton>&nbsp<asp:Label ID="lblDown" runat="server" Text=""></asp:Label>
                                            <%--<a class="btn btn-default" data-toggle="modal" href="#myModal"><i class="fa fa-thumbs-o-up"></i> <%#Eval("up") %> &nbsp&nbsp <i class="fa fa-thumbs-o-down"></i> <%#Eval("down") %></a>--%>
                                            <%--<asp:LinkButton ID="lnkUp" CssClass="btn btn-default" runat="server"><i class="fa fa-thumbs-o-up"></i> <%#Eval("up") %> &nbsp&nbsp <i class="fa fa-thumbs-o-down"></i> <%#Eval("down") %></asp:LinkButton>--%>
                                            <br />
                                            <asp:Label ID="lblMessage" runat="server" Text="" ForeColor="#3276b1"></asp:Label>
                                        </div>
                                    </div>
                                </fieldset>
                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <asp:PostBackTrigger ControlID="lnkUp" />
                            <asp:PostBackTrigger ControlID="lnkDown" />
                        </Triggers>
                    </asp:UpdatePanel>

                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                        <ContentTemplate>
                            <asp:Panel ID="Panel1" runat="server" DefaultButton="btnComment">
                                
                            
                            <div class="form-horizontal">
                                <fieldset>
                                    <legend>Comments</legend>
                                    <asp:Label ID="lblMsg" runat="server" ></asp:Label>
                                    <asp:Repeater ID="rptComments" runat="server">
                                        <ItemTemplate>
                                            <div class="form-group">
                                                <div class="col-lg-10">
                                                    <asp:Image ID="imgPic" runat="server" Width="30" Height="30" ImageUrl='<%#Eval("profilepic") %>' />
                                                    <asp:Label ID="lblCmntName" runat="server" Font-Bold="true" ForeColor="GrayText"><%#Eval("fName") %>&nbsp<%#Eval("lName") %> : </asp:Label>
                                                        <asp:Label ID="lblComment" runat="server" ForeColor="#3276b1"><%#Eval("comment") %></asp:Label>
                                                    <br />
                                                    &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp<label for="timestamp" style="color: Gray; font-size: xx-small">Commented on <i class="fa fa-clock-o"></i> <%#Eval("createTime") %></label>
                                                    
                                                        <legend></legend>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                    <div class="form-group">
                                                <div class="col-lg-10">
                                                    <asp:TextBox ID="txtComment" CssClass="form-control" placeholder="Comment" runat="server"></asp:TextBox>
                                                    <asp:Button ID="btnComment" CssClass="btn btn-primary btn-xs" runat="server" Text="Comment" OnClick="btnComment_Click"/>
                                                    </div>
                                            </div>
                                </fieldset>
                            </div>
                                </asp:Panel>
                        </ContentTemplate>
                        <Triggers>
                            <asp:PostBackTrigger ControlID="btnComment" />
                        </Triggers>
                    </asp:UpdatePanel>
                </div>

            </div>

        </div>
    </form>
</body>
</html>
