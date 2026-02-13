<%@ Page Title="" Language="C#" MasterPageFile="~/Customer/Customer.Master" AutoEventWireup="true" CodeBehind="ProductDetails.aspx.cs" Inherits="SecondHand.Customer.ProductDetails" %>

<%@ Import Namespace="SecondHand" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        .availability-in-stock {
            color: blue;
        }

        .availability-sold-out {
            color: red;
        }
    </style>
    <style>
        .grow img {
            transition: 1s ease;
        }

            .grow img:hover {
                -webkit-transform: scale(1.2);
                -ms-transform: scale(1.2);
                transform: scale(1.2);
                transition: 1s ease;
            }

   
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">


    <!-- Breadcrumb Section Begin -->
    <section class="breadcrumb-section set-bg" data-setbg="../file/img/breadcrumb.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="breadcrumb__text">
                        <h2>Shopping Details</h2>
                        <div class="breadcrumb__option">
                            <a href="Home.aspx">Home</a>
                            <span>Shopping Details</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcrumb Section End -->

    <section class="product-details spad">
        <div class="container">
            <div class=" text-right ">
                <asp:Label ID="lblmsg" runat="server" Visible="false"></asp:Label>
            </div>
            <asp:Repeater ID="rProductDetails" runat="server" OnItemCommand="rProductDetails_ItemCommand">
                <ItemTemplate>

                    <div class="row">

                        <div class="col-lg-6 col-md-6">
                            <div class="product__details__pic">
                                <div class="product__details__pic__item " style="border: 1px solid gray;">
                                    <img src="<%# Utils.GetImageUrl(Eval("ImageUrl")) %>" width="350" height="450" />
                                </div>

                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6">
                            <div class="product__details__text">
                                <h3><%# Eval("Name") %></h3>
                                  
                                 <div class="product__details__price " style="text-decoration:line-through"><%# Eval("Price") %> KS</div>
                                <div class="product__details__price "><%# Eval("SaleOff") %> KS</div> 
                                <p><%# Eval("Description") %> </p>
                                <div class="product__details__quantity">
                                    <div class="quantity">
                                        <div class="pro-qty">
                                            <input type="text" value="1">
                                        </div>
                                    </div>
                                </div>

                                <asp:LinkButton ID="lbAddToCart" runat="server" CommandName="addToCart"
                                    CommandArgument='<%# Eval("ProductId") %>' CssClass="primary-btn" Enabled="true">          
                                  ADD TO CART
                                </asp:LinkButton>

                                <a href="#" class="heart-icon"><span class="icon_heart_alt"></span></a>
                                <ul>
                                    <li><b>Availability</b>
                                        <span class='<%# Convert.ToInt32(Eval("Quantity")) > 0 ? "availability-in-stock" : "availability-sold-out" %>'>
                                            <%# Convert.ToInt32(Eval("Quantity")) > 0 ? "In Stock: " + Eval("Quantity") + " items" : "Sold Out" %>
                                    </span>

                                    </li>
                                    <li><b>Shipping</b> <span>01 day shipping.
                                        <samp>Free pickup today</samp></span></li>

                                  
                                </ul>
                            </div>
                        </div>
                        <div class="col-lg-12">
                            <div class="product__details__tab">
                                <ul class="nav nav-tabs" role="tablist">
                                    <li class="nav-item">
                                        <a class="nav-link active" data-toggle="tab" href="#tabs-1" role="tab"
                                            aria-selected="true">Description</a>
                                    </li>

                                </ul>
                                <div class="tab-content">
                                    <div class="tab-pane active" id="tabs-1" role="tabpanel">
                                        <div class="product__details__tab__desc">
                                            <h6>Products Infomation</h6>
                                            <p>
                                                <%# Eval("Description") %>
                                            </p>
                                            <%-- <p>
                                                Praesent sapien massa, convallis a pellentesque nec, egestas non nisi. Lorem
                                        ipsum dolor sit amet, consectetur adipiscing elit. Mauris blandit aliquet
                                        elit, eget tincidunt nibh pulvinar a. Cras ultricies ligula sed magna dictum
                                        porta. Cras ultricies ligula sed magna dictum porta. Sed porttitor lectus
                                        nibh. Mauris blandit aliquet elit, eget tincidunt nibh pulvinar a.
                                        Vestibulum ac diam sit amet quam vehicula elementum sed sit amet dui. Sed
                                        porttitor lectus nibh. Vestibulum ac diam sit amet quam vehicula elementum
                                        sed sit amet dui. Proin eget tortor risus.
                                            </p>--%>
                                        </div>
                                    </div>

                                </div>
                            </div>
                        </div>



                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </section>
    <!-- Product Details Section End -->

    <!-- Related Product Section Begin -->
    <section class="related-product">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class="section-title related__product__title">
                        <h2>Related Product</h2>
                    </div>
                </div>
            </div>
            <div class="row">


                <asp:Repeater ID="rRelateProduct" runat="server" OnItemCommand="rProductDetails_ItemCommand">
                    <ItemTemplate>
                        <div class="col-lg-3 col-md-4 col-sm-6">

                            <div class="product__item" style="border: 2px solid whitesmoke;">
                                <div class="product__item__pic set-bg" style="background-color: whitesmoke;">
                                    <div class="grow">
                                        <image src="<%# Utils.GetImageUrl(Eval("ImageUrl")) %>"></image>
                                    </div>
                                    <ul class="product__item__pic__hover">
                                        <li><a href="#"><i class="fa fa-heart"></i></a></li>
                                        <li><a href="#"><i class="fa fa-retweet"></i></a></li>
                                        <li>
                                            <asp:LinkButton ID="lbAddToCart" runat="server" CommandName="addToCart"
                                                CommandArgument='<%# Eval("ProductId") %>'>
                            <i class="fa fa-shopping-cart"></i>
                                            </asp:LinkButton>
                                        </li>
                                    </ul>
                                </div>
                                <asp:LinkButton ID="lblProductDetail" runat="server" CommandName="productDetail"
                                    CommandArgument=' <%# Eval("ProductID") + "," + Eval("CategoryID") %>'>
                                     <div class="product__item__text">
                                         <h6><%# Eval("Name") %></h6>
                                     <h5><%# Eval("Price") %> Ks</h5>
                                      </div>
                                </asp:LinkButton>
                            </div>
                        </div>



                    </ItemTemplate>
                </asp:Repeater>



            </div>
        </div>
    </section>
    <!-- Related Product Section End -->

</asp:Content>
