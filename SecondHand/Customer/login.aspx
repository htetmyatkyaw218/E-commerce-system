<%@ Page Title="" Language="C#" MasterPageFile="~/Customer/Customer.Master" AutoEventWireup="true" CodeBehind="login.aspx.cs" Inherits="SecondHand.Customer.login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <script>
        window.onload = function () {
            var seconds = 5;
            setTimeout(function () {
                document.getElementById("<%= lblMsg.ClientID %>").style.display = "none";
            }, seconds * 1000);
        };
    </script>
    <link rel="stylesheet" type="text/css" href="../template/css/bootstrap.css" />
    <link href="../template/css/style.css" rel="stylesheet" />
    <!-- responsive style-->
    <link href="../template/css/responsive.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <section class="book_section layout_padding">

        <div class="container">
            <div class=" text-right">
                <asp:Label ID="lblMsg" runat="server" CssClass=" text-right"></asp:Label>

            </div>
            <div class="heading_container text-center">
                <h2>User Login</h2>

            </div>

            <div class="row">

                <div class="col-md-6">
                    <div class="form_container">
                        <img  src="../file/login-security.gif" alt="" class="img-thumbnail" />
                       
                    </div>
                </div>
                <div class="col-md-6 pt-lg-5" >
                    <div class="form_container">
                        <div>

                            <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ErrorMessage="user name is required"
                                ControlToValidate="txtUsername" ForeColor="Red" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Enter Username"></asp:TextBox>
                        </div>
                        <div>

                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="Password  is required"
                                ControlToValidate="txtPassword" ForeColor="Red" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" placeholder="Enter Password" TextMode="Password"></asp:TextBox>
                        </div>
                        <div class="btn_box">
                            <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn btn-success rounded-pill pl-4 txt-white"
                                OnClick="btnLogin_Click" />
                            <span class="pl-3 text-info">New user ? <a href="register.aspx" class="badge badge-info">Register Here ..</a>
                            </span>

                        </div>
                       
                    </div>
                </div>
            </div>
        </div>
    </section>

</asp:Content>
