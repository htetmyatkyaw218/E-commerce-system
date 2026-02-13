<%@ Page Title="" Language="C#" MasterPageFile="~/Customer/Customer.Master" AutoEventWireup="true" CodeBehind="Payment.aspx.cs" Inherits="SecondHand.Customer.Payment" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

    <style>
        .rounded {
            border-radius: 1rem
        }

        .nav-pills .nav-link {
            color: #555
        }

            .nav-pills .nav-link.active {
                color: white
            }

        input[type="radio"] {
            margin-right: 5px
        }

        .bold {
            font-weight: bold
        }

        .card {
            padding: 40px 50px;
            border-radius: 20px;
            border: none;
            box-shadow: 1px 5px 1px rgba(0,0,0,0.2)
        }
    </style>
    <script>
        $(function () {
            $('[data-toggle="tooltip"]').tooltip()
        })

        window.onload = function () {
            var seconds = 5;
            setTimeout(function () {
                document.getElementById("<%= lblMsg.ClientID %>").style.display = "none";
            }, seconds * 1000);
        };
    </script>
    <script type="text/javascript">
        function DisableBackButton() {
            window.history.forward()
        } DisableBackButton();
        window.onload = DisplayBackButton;
        window.onpageshow = function (evt) {
            if (evt.persisted) DisableBackButton()
        }
        window.onunload = function () {
            void (0)
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- <section class="book_section" style="background-image: url('../template/images/f6.png'); width: 100%; height: 100vh; background-repeat: no-repeat; background-size: cover; background-attachment: fixed; background-position: left;"> -->
    <section>
        <div class="container py-5">
            <div class=" text-right ">
                <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
            </div>
            <!-- For demo purpose -->
            <div class="row mb-4">
                <div class="col-lg-8 mx-auto text-center">
                    <h2 class="display-6">Payment</h2>

                </div>
            </div>
            <!-- End -->
            <div class="row">
                <div class="col-lg-6 mx-auto">
                    <div class="card ">
                        <div class="card-header">
                            <div class="bg-white shadow-sm pt-4 pl-2 pr-2 pb-2">
                                <!-- Credit card form tabs -->
                                <ul role="tablist" class="nav bg-light nav-pills rounded nav-fill mb-3">
                                    <li class="nav-item"><a data-toggle="pill" href="#credit-card" class="nav-link active "><i class="fa fa-credit-card mr-2"></i>Credit Card </a></li>
                                    <li class="nav-item"><a data-toggle="pill" href="#paypal" class="nav-link "><i class="fa fa-paypal mr-2"></i>Paypal </a></li>
                                    <li class="nav-item"><a data-toggle="pill" href="#net-banking" class="nav-link "><i class="fa fa-mobile-alt mr-2"></i>Net Banking </a></li>
                                </ul>
                            </div>
                            <!-- End -->
                            <!-- Credit card form content -->
                            <div class="tab-content">
                                <!-- credit card info-->
                                <div id="credit-card" class="tab-pane fade show active pt-3">
                                    <form role="form" onsubmit="event.preventDefault()">
                                        <div class="form-group">
                                            <label for="txtName">
                                                <h6>Card Owner</h6>
                                            </label>
                                            <asp:RequiredFieldValidator ID="rfvName" runat="server" ErrorMessage="Name is require" ControlToValidate="txtName" ForeColor="Red" Display="Dynamic"
                                                SetFocusOnError="true" ValidationGroup="card">*</asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ErrorMessage="Name must be a Character"
                                                ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ValidationGroup="card"
                                                ControlToValidate="txtName" ValidationExpression="^[a-zA-Z\s]+$"></asp:RegularExpressionValidator>
                                            <asp:TextBox ID="txtName" runat="server" CssClass="form-control " placeholder="Card Owner Name"></asp:TextBox>

                                        </div>
                                        <div class="form-group">
                                            <label for="txtCardNo">
                                                <h6>Card number</h6>
                                            </label>

                                            <asp:RequiredFieldValidator ID="rfvNumber" runat="server" ErrorMessage="Card number is require" ControlToValidate="txtCardNo" ForeColor="Red" Display="Dynamic"
                                                SetFocusOnError="true" ValidationGroup="card">*</asp:RequiredFieldValidator>
                                            <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ErrorMessage="Card number must be of 16 digits"
                                                ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ValidationGroup="card"
                                                ControlToValidate="txtCardNo" ValidationExpression="[0-9]{16}">*</asp:RegularExpressionValidator>

                                            <div class="input-group">

                                                <asp:TextBox ID="txtCardNo" runat="server" CssClass="form-control " placeholder="Valid card number" TextMode="Number"></asp:TextBox>
                                                <div class="input-group-append"><span class="input-group-text text-muted"><i class="fa fa-cc-visa mx-1"></i><i class="fa fa-cc-mastercard mx-1"></i><i class="fa fa-cc-amex mx-1"></i></span></div>
                                            </div>

                                        </div>
                                        <div class="row">
                                            <div class="col-sm-8">
                                                <div class="form-group">
                                                    <label>
                                                        <span class="hidden-xs">
                                                            <h6>Expiration Date</h6>
                                                        </span>
                                                    </label>
                                                    <asp:RequiredFieldValidator ID="rfvExpMonth" runat="server" ErrorMessage="Expiry month is require" ControlToValidate="txtExpMonth" ForeColor="Red" Display="Dynamic"
                                                        SetFocusOnError="true" ValidationGroup="card">*</asp:RequiredFieldValidator>
                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ErrorMessage="Expiry month must be of 2 digits"
                                                        ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ValidationGroup="card"
                                                        ControlToValidate="txtExpMonth" ValidationExpression="[0-9]{2}">*</asp:RegularExpressionValidator>

                                                    <asp:RequiredFieldValidator ID="rfvExpYear" runat="server" ErrorMessage="Expiry Year is require" ControlToValidate="txtExpYear" ForeColor="Red" Display="Dynamic"
                                                        SetFocusOnError="true" ValidationGroup="card">*</asp:RequiredFieldValidator>
                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" ErrorMessage="Expiry Year must be of 4 digits"
                                                        ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ValidationGroup="card"
                                                        ControlToValidate="txtExpYear" ValidationExpression="[0-9]{4}">*</asp:RegularExpressionValidator>
                                                    <div class="input-group">
                                                        <asp:TextBox ID="txtExpMonth" runat="server" CssClass="form-control " placeholder="MM" TextMode="Number"></asp:TextBox>
                                                        <asp:TextBox ID="txtExpYear" runat="server" CssClass="form-control " placeholder="YY" TextMode="Number"></asp:TextBox>

                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-sm-4">
                                                <div class="form-group mb-4">
                                                    <label data-toggle="tooltip" title="Three digit CV code on the back of your card">
                                                        <h6>CVV <i class="fa fa-question-circle d-inline"></i></h6>
                                                    </label>
                                                    <asp:RequiredFieldValidator ID="rfvCvv" runat="server" ErrorMessage="Cvv No. is require" ControlToValidate="txtCvv" ForeColor="Red" Display="Dynamic"
                                                        SetFocusOnError="true" ValidationGroup="card">*</asp:RequiredFieldValidator>
                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" ErrorMessage="Expiry month must be of 3 digits"
                                                        ForeColor="Red" Display="Dynamic" SetFocusOnError="true" ValidationGroup="card"
                                                        ControlToValidate="txtCvv" ValidationExpression="[0-9]{3}">*</asp:RegularExpressionValidator>
                                                    <asp:TextBox ID="txtCvv" runat="server" CssClass="form-control " placeholder="Cvv No." TextMode="Number"></asp:TextBox>

                                                </div>
                                            </div>
                                        </div>
                                        <div class="form-group">
                                            <label for="txtAddress">
                                                <h6>Delivery Address</h6>
                                            </label>
                                            <asp:RequiredFieldValidator ID="rfvAddress" runat="server" ErrorMessage="Address is require" ControlToValidate="txtAddress" ForeColor="Red" Display="Dynamic"
                                                SetFocusOnError="true" ValidationGroup="card">*</asp:RequiredFieldValidator>

                                            <asp:TextBox ID="txtAddress" runat="server" CssClass="form-control " placeholder="Delivery Address" TextMode="MultiLine"></asp:TextBox>

                                        </div>
                                        <div class="card-footer">
                                            <asp:LinkButton ID="lbCardSubmit" runat="server" CssClass="subscribe btn btn-primary btn-block shadow-sm"
                                                ValidationGroup="card" OnClick="lbCardSubmit_Click">Confirm Payment</asp:LinkButton>
                                          <%-- <a href='Invoice.aspx?id=2'>Confirm Payment</a>--%>

                                  
                                </div>
                                </form>
                            </div>
                            <!-- End -->
                            <!-- Paypal info -->
                            <div id="paypal" class="tab-pane fade pt-3">
                                <h6 class="pb-2">Select your paypal account type</h6>
                                <div class="form-group ">
                                    <label for="txtCODAddress">
                                        <h6>Delivery Address</h6>
                                    </label>
                                     <asp:TextBox ID="txtCODAddress" runat="server" CssClass="form-control " placeholder="Delivery Address" TextMode="MultiLine"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="rfvCODAddress" runat="server" ErrorMessage="Delivery Address is require" ControlToValidate="txtCODAddress" ForeColor="Red" Display="Dynamic"
                                        SetFocusOnError="true" ValidationGroup="cod" Font-Names="Segoe Script">*</asp:RequiredFieldValidator>

                                   
                                </div>
                                <p>
                                   <%-- <asp:LinkButton ID="lbCodSubmit" runat="server" CssClass="btn btn-info" ValidationGroup="cod" OnClick="lbCodSubmit_Click" ><i class="fa fa-cart-arrow-down mr-2"></i>Confirm Order</asp:LinkButton>
                                   --%>
                                </p>
                                <p class="text-muted">Note: At the of recieving your order, you need to do full payment.
                                    After completing the payment process, you can check your updated order status.
                                </p>
                            </div>
                            <!-- End -->
                            <!-- bank transfer info 
                            <div id="net-banking" class="tab-pane fade pt-3">
                                <div class="form-group ">
                                    <label for="Select Your Bank">
                                        <h6>Select your Bank</h6>
                                    </label>
                                    <select class="form-control" id="ccmonth">
                                        <option value="" selected disabled>--Please select your Bank--</option>
                                        <option>Bank 1</option>
                                        <option>Bank 2</option>
                                        <option>Bank 3</option>
                                        <option>Bank 4</option>
                                        <option>Bank 5</option>
                                        <option>Bank 6</option>
                                        <option>Bank 7</option>
                                        <option>Bank 8</option>
                                        <option>Bank 9</option>
                                        <option>Bank 10</option>
                                    </select>
                                </div>
                                <div class="form-group">
                                    <p>
                                        <button type="button" class="btn btn-primary "><i class="fa fa-mobile-alt mr-2"></i>Proceed Payment</button>
                                    </p>
                                </div>
                                <p class="text-muted">Note: After clicking on the button, you will be directed to a secure gateway for payment. After completing the payment process, you will be redirected back to the website to view details of your order. </p>
                            </div>
                           End -->
                            <!-- End -->
                            <div class="card-footer">
                                <b class="badge badge-success badge-pill shadow-sm">Order Total: <%Response.Write(Session["grandTotalPrice"]);%></b>                  
                                <div class="pt-1">
                                    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ForeColor="Red"  ValidationGroup="card" HeaderText="Fix the Following errors"
                                      font-Names="Segoe Script"  />
                                </div>
                            </div>
                              

                        </div>
                    </div>
                </div>
            </div>
    </section>


</asp:Content>
