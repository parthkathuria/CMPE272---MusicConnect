<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="index.aspx.cs" Inherits="MusicConnect.index" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
   <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <meta name="description" content=""/>
    <meta name="author" content=""/>

    <title>Music Connect</title>

    <!-- Bootstrap core CSS -->
    <link href="css/bootstrap.css" rel="stylesheet"/>
    <!-- Add custom CSS here -->
    <link href="font-awesome/css/font-awesome.css" rel="stylesheet" />
    <style>
    body {
        margin-top: 60px;
    }
    </style>

</head>
<body>
    <form id="form1">
        <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-ex1-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="index.aspx"><i class="fa fa-music"></i>&nbsp music-connect</a>
            </div>

            <!-- Collect the nav links, forms, and other content for toggling -->
            <div class="collapse navbar-collapse navbar-ex1-collapse">
                <ul class="nav navbar-nav navbar-right">
                    <li><a href="Views/login.aspx">Sign Up</a>
                    </li>
                    
                </ul>
            </div>
            <!-- /.navbar-collapse -->
        </div>
        <!-- /.container -->
    </nav>
        
        <div class="container">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="form-horizontal" runat="server">
                            <fieldset>
                                <legend>Music Connect</legend>
                                <p>Description</p>
                            </fieldset>
                        </div>
                    </div>
                </div>
        </div>
        <script src="js/jquery-1.10.2.js"></script>
    <script src="js/bootstrap.js"></script>
    </form>
</body>

</html>
