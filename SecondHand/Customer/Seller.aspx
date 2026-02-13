<%@ Page Title="" Language="C#" MasterPageFile="~/Customer/Customer.Master" AutoEventWireup="true" CodeBehind="Seller.aspx.cs" Inherits="SecondHand.Customer.Seller" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <!-- Custom styles for this template -->
    <link href="../template/css/style.css" rel="stylesheet" />
    <!-- responsive style-->
    <link href="../template/css/responsive.css" rel="stylesheet" />

    <script>
        window.onload = function () {
            var seconds = 5;
            setTimeout(function () {
                document.getElementById("<%=lblMsg.ClientID %>").style.display = "none";
            }, seconds * 1000);
        };
    </script>

    <script>
        function ImagePreview(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#<%=imageUser.ClientID %>').prop('src', e.target.result)
                        .width(200)
                        .height(200);
                };
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <section class="book_section layout_padding">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="contact__form__title right-align">
                        <asp:Label ID="lblHeaderMsg" runat="server" Text="Seller Registration " Style="font-weight: bold; font-size: 32px; font-family: serif;"></asp:Label>
                    </div>
                </div>
            </div>
            <div class="heading_container">

                <div class="align-self-end">

                    <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
                </div>

            </div>
            <div class="row">
                <div class="col-md-6">
                    <div class="form_container">
                        <div>
                        </div>

                        <asp:RequiredFieldValidator ID="frvName" runat="server" ErrorMessage="Full Name  is requried" ControlToValidate="txtName"
                            ForeColor="Red" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Full Name must be character"
                            ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ValidationExpression="^[a-zA-z\s]+$"
                            ControlToValidate="txtName"></asp:RegularExpressionValidator>
                        <asp:TextBox ID="txtName" runat="server" CssClass="form-control" placeholder="Enter full Name" ToolTip="full Name"></asp:TextBox>
                        <div>

                            <asp:RequiredFieldValidator ID="rfvUsername" runat="server" ErrorMessage="Seller name is requried" ControlToValidate="txtUsername"
                                ForeColor="Red" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Enter SellerName" ToolTip=" Username"></asp:TextBox>

                        </div>
                        <div>

                            <asp:RequiredFieldValidator ID="rfvEmail" runat="server" ErrorMessage="Email is requried" ControlToValidate="txtEmail"
                                ForeColor="Red" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="Enter Email" ToolTip=" Email" TextMode="Email"></asp:TextBox>

                        </div>
                        <div>

                            <asp:RequiredFieldValidator ID="rfvMobile" runat="server" ErrorMessage="Mobile number is requried" ControlToValidate="txtMobile"
                                ForeColor="Red" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revMobile" runat="server" ErrorMessage="Mobile Number must be have 11 digits"
                                ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ValidationExpression="^[0-9]{11}$"
                                ControlToValidate="txtMobile"></asp:RegularExpressionValidator>
                            <asp:TextBox ID="txtMobile" runat="server" CssClass="form-control" placeholder="Enter Mobile number" ToolTip="Mobile number" TextMode="Number"></asp:TextBox>
                        </div>
                    </div>
                </div>
                <div class="col-md-6">
                    <div class="form_container">
                        <div>

                            <asp:RequiredFieldValidator ID="rfvAddress" runat="server" ErrorMessage="Address is requried" ControlToValidate="txtAddress"
                                ForeColor="Red" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control" placeholder="Enter Address" ToolTip="Address" TextMode="MultiLine"></asp:TextBox>

                        </div>


                        <div>


                            <asp:FileUpload ID="fuUserImage" runat="server" CssClass="form-control" ToolTip="User Image " onchange="ImagePreview(this);" />
                        </div>
                        <div>

                            <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ErrorMessage="Password is requried" ControlToValidate="txtPassword"
                                ForeColor="Red" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>

                            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" placeholder="Enter your Password" ToolTip="Password " TextMode="Password"></asp:TextBox>
                        </div>
                        <div>

                            <asp:RequiredFieldValidator ID="rfvPostCode" runat="server" ErrorMessage="Confirm Password is requried" ControlToValidate="txtPostCode"
                                ForeColor="Red" Display="Dynamic" SetFocusOnError="true"></asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtPostCode" runat="server" CssClass="form-control" placeholder="Enter Confirm Password" ToolTip="Confirm Password" TextMode="Password"></asp:TextBox>

                        </div>
                        <div>
                            <!-- Compare Validator to ensure both passwords match -->
                            <asp:CompareValidator ID="cvPasswords" runat="server"
                                ControlToCompare="txtPassword"
                                ControlToValidate="txtPostCode"
                                ErrorMessage="Passwords do not match"
                                ForeColor="Red"
                                Display="Dynamic"
                                SetFocusOnError="true"
                                Operator="Equal" />
                        </div>
                    </div>

                </div>

                <div class="row pl-4">
                    <div class="btn_box">
                        <asp:Button ID="btnRegister" runat="server" Text="Register" CssClass="btn btn-success rounded-pill pl-4 pr-4  tex-white"
                            OnClick="btnRegister_Click" />

                        <asp:Label ID="lblAlreadyUser" runat="server" CssClass="pl-3 text-black-100" Text="Already registered <a href='login.aspx' >Login here.."></asp:Label>

                    </div>
                    <div class="btn-box pt-3">
                        <div>
                            <asp:Label ID="Label1" runat="server" CssClass="pl-3 text-black-100"
                                Text="Are You User ? <a href='register.aspx' style='color: inherit;'> Register here..</a>"></asp:Label>
                        </div>


                    </div>
                </div>
                <div class="row p-5">
                    <div style="align-items: center">
                        <asp:Image ID="imageUser" runat="server" CssClass="img-thumbnail" />
                    </div>

                </div>

            </div>

        </div>


    </section>

</asp:Content>
