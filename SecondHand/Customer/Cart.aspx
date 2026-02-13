<%@ Page Title="" Language="C#" MasterPageFile="~/Customer/Customer.Master" AutoEventWireup="true" CodeBehind="Cart.aspx.cs" Inherits="SecondHand.Customer.Cart" %>

<%@ Import Namespace="SecondHand" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- Hero Section Begin -->
   <%-- <section class="hero hero-normal">
        <div class="container">
            <div class="row">
                <div class="col-lg-3">
                    <div class="hero__categories">
                        <div class="hero__categories__all">
                            <i class="fa fa-bars"></i>
                            <span>All departments</span>
                        </div>
                        <ul>
                            <li><a href="#">Fresh Meat</a></li>
                            <li><a href="#">Vegetables</a></li>
                            <li><a href="#">Fruit & Nut Gifts</a></li>
                            <li><a href="#">Fresh Berries</a></li>
                            <li><a href="#">Ocean Foods</a></li>
                            <li><a href="#">Butter & Eggs</a></li>
                            <li><a href="#">Fastfood</a></li>
                            <li><a href="#">Fresh Onion</a></li>
                            <li><a href="#">Papayaya & Crisps</a></li>
                            <li><a href="#">Oatmeal</a></li>
                            <li><a href="#">Fresh Bananas</a></li>
                        </ul>
                    </div>
                </div>
                <div class="col-lg-9">
                    <div class="hero__search">
                        <div class="hero__search__form">
                            <form action="#">
                            </form>
                        </div>
                        <div class="hero__search__phone">
                            <div class="hero__search__phone__icon">
                                <i class="fa fa-phone"></i>
                            </div>
                            <div class="hero__search__phone__text">
                                <h5>+65 11.188.888</h5>
                                <span>support 24/7 time</span>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>--%>
    <!-- Hero Section End -->

    <!-- Breadcrumb Section Begin -->
    <section class="breadcrumb-section set-bg" data-setbg="../file/img/breadcrumb.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="breadcrumb__text">
                        <h2>Shopping Cart</h2>
                        <div class="breadcrumb__option">
                            <a href="Home.aspx">Home</a>
                            <span>Shopping Cart</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcrumb Section End -->

    <!-- Shoping Cart Section Begin -->
    <section class="shoping-cart spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="shoping__cart__table">
                        <div style="text-align: right; margin-bottom: 5px; font-weight: bold;">

                            <asp:Label ID="lblmsg" runat="server" Visible="false"></asp:Label>
                        </div>
                        <asp:Repeater ID="rCartItem" runat="server" OnItemCommand="rCartItem_ItemCommand" OnItemDataBound="rCartItem_ItemDataBound" >
                            <HeaderTemplate>


                                <table>

                                    <thead>

                                        <tr>
                                            <th class="shoping__product">Products</th>
                                            <!--image -->
                                            <th>Price</th>
                                            <th>Quantity</th>
                                            <th>Total Price</th>
                                            <th></th>
                                        </tr>
                                    </thead>
                                    <tbody>
                            </HeaderTemplate>
                            <ItemTemplate>

                                <tr>
                                    <td class="shoping__cart__item">

                                        <img src="<%# Utils.GetImageUrl(Eval("ImageUrl")) %>" alt="" style="width: 100px; height: 100px;" />

                                        <h5>
                                            <asp:Label ID="lblName" runat="server" Text='<%# Eval("Name") %>'></asp:Label>

                                        </h5>


                                    </td>
                                    <td class="shoping__cart__price">
                                        <asp:Label ID="lblPrice" runat="server" Text='<%# Eval("Price")%>'></asp:Label>Ks                                        
                                        
                                        <asp:HiddenField ID="hdnProductId" runat="server" Value='<%# Eval("ProductId") %>' />
                                        <asp:HiddenField ID="hdnQuantity" runat="server" Value='<%# Eval("Qty") %>' />
                                        <asp:HiddenField ID="hdnPrdQuantity" runat="server" Value='<%# Eval("PrdQty") %>' />


                                    </td>
                                    <td class="shoping__cart__quantity">
                                        <div class="quantity">
                                            <div class="pro-qty">

                                                <asp:TextBox ID="txtQuantity" runat="server" TextMode="Number" Text='<%# Eval("Quantity")%>'></asp:TextBox>
                                                <asp:RegularExpressionValidator ID="revQuantity" runat="server" ErrorMessage="*" ForeColor="Red"
                                                    ValidationExpression="[1-9]*" ControlToValidate="txtQuantity" Display="Dynamic" SetFocusOnError="true"
                                                    EnableClientScript="true"></asp:RegularExpressionValidator>
                                            </div>
                                        </div>
                                    </td>
                                    <td class="shoping__cart__total">

                                        <asp:Label ID="lblTotalPrice" runat="server"></asp:Label>Ks

                                    </td>
                                    <td class="shoping__cart__item__close">

                                        <asp:LinkButton ID="lbDelete" runat="server" Text="Remove" CommandName="remove"
                                            CommandArgument='<%# Eval("ProductId") %>'
                                            OnClientClick="return confirm('Do you want to remove this Item from Cart?');">
                                            <span class="icon_close"></span>
                                        </asp:LinkButton>
                                        <!-- <span class="icon_close"></span> -->
                                    </td>
                                </tr>
                            </ItemTemplate>
                            <FooterTemplate>
                                </tbody>
                                </table>
                          
                           
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-lg-12">
                    <div class="shoping__cart__btns">

                        <a href="Home.aspx" class="primary-btn cart-btn">CONTINUE SHOPPING</a>

                        <asp:LinkButton ID="lbUpdateCart" runat="server" CssClass="primary-btn cart-btn cart-btn-right"
                            CommandName="updateCart">UPDATE CART </asp:LinkButton>

                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="shoping__continue">
                        <div class="shoping__discount">
                            <h5>Discount Codes</h5>
                            <form action="#">
                                <input type="text" placeholder="Enter your coupon code">
                                <button type="submit" class="site-btn">APPLY COUPON</button>
                            </form>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6">
                    <div class="shoping__checkout">
                        <h5>Cart Total</h5>
                        <ul>

                            <li>Total <span><% Response.Write(Session["grandTotalPrice"]); %> Ks</span></li>
                        </ul>
                        <asp:LinkButton ID="lbCheckout" runat="server" CssClass="primary-btn"
                         OnClick="lbCheckout_Click" >PROCEED TO CHECKOUT</asp:LinkButton>
                       
                        <!--<a href="Payment.aspx" class="primary-btn">PROCEED TO CHECKOUT</a>  -->
                    </div>
                </div>
                            </FooterTemplate>
                        </asp:Repeater>
                        </div>
                        </div>
                    </div>
                </div>
    </section>
    <!-- Shoping Cart Section End -->



   
<%--        <div class="container">
            <h2>Your Shopping Cart</h2>
             <asp:Label ID="lblmsg" runat="server" CssClass=""  Text="hello"></asp:Label>
            <asp:Repeater ID="rCartItem" runat="server" OnItemCommand="rCartItem_ItemCommand" OnItemDataBound="rCartItem_ItemDataBound">
                <HeaderTemplate>

                    <table class="table table-bordered">
                        <thead>
                            <tr>
                                <th>Product</th>
                                <th>Price</th>
                                <th>Quantity</th>
                                <th>Total</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                </HeaderTemplate>
                <ItemTemplate>
                    <tr>
                        <td>
                            <asp:Label ID="lblName" runat="server" Text='<%# Eval("Name") %>'></asp:Label>
                        </td>
                        <td>
                            <asp:Label ID="lblPrice" runat="server" Text='<%# Eval("Price") %>'></asp:Label>
                        </td>
                        <td>
                            <asp:TextBox ID="txtQuantity" runat="server" CssClass="form-control" Text='<%# Eval("Quantity") %>'></asp:TextBox>
                            <asp:HiddenField ID="hdnProductId" runat="server" Value='<%# Eval("ProductId") %>' />
                            <asp:HiddenField ID="hdnQuantity" runat="server" Value='<%# Eval("Qty") %>' />
                            <asp:HiddenField ID="hdnPrdQuantity" runat="server" Value='<%# Eval("PrdQty") %>' />
                        </td>
                        <td>
                            <asp:Label ID="lblTotalPrice" runat="server"></asp:Label>
                        </td>
                        <td>
                            <asp:LinkButton ID="lbRemove" runat="server" CommandName="remove" CommandArgument='<%# Eval("ProductId") %>' CssClass="btn btn-danger">Remove</asp:LinkButton>
                        </td>
                    </tr>
                </ItemTemplate>
                <FooterTemplate>
                    <tr>
                        <td colspan="5">
                            <b>Grand Total:</b>
                            <asp:Label ID="lblGrandTotal" runat="server" Text='<%# Session["grandTotalPrice"] %>'></asp:Label>
                        </td>
                    </tr>
                    </tbody>
                    </table>
                </FooterTemplate>
            </asp:Repeater>

            <div class="cart-buttons">
                <asp:LinkButton ID="lbUpdateCart" runat="server" CssClass="btn btn-primary" CommandName="updateCart">UPDATE CART</asp:LinkButton>
                <asp:LinkButton ID="lbCheckout" runat="server" CssClass="btn btn-success" CommandName="checkout">PROCEED TO CHECKOUT</asp:LinkButton>
            </div>

           
        </div>--%>
   


</asp:Content>
