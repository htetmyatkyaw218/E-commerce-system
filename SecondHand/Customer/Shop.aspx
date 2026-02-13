<%@ Page Title="" Language="C#" MasterPageFile="~/Customer/Customer.Master" AutoEventWireup="true" CodeBehind="Shop.aspx.cs" Inherits="SecondHand.Customer.Shop" %>

<%@ Import Namespace="SecondHand" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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



    <!-- Hero Section End -->
    <!-- Breadcrumb Section Begin -->
    <section class="breadcrumb-section set-bg" data-setbg="../File/img/breadcrumb.jpg">
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <div class="breadcrumb__text">
                        <h2>Shop</h2>
                        <div class="breadcrumb__option">
                            <a href="Home.aspx">Home</a>
                            <span>Shop</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Breadcrumb Section End -->

    <!-- Product Section Begin -->
    <section class="product spad">
        <div class="container">
            <div class="row">
               
                <div class="col-lg-12 col-md-7">
                    <div class="product__discount">
                        <div class="section-title product__discount__title">
                            <h2>Sale Off</h2>
                        </div>
                        <div class="row">
                            <div class="product__discount__slider owl-carousel">
                                <asp:Repeater ID="rSaleOff" runat="server" OnItemCommand="rSaleOff_ItemCommand">
                                    <ItemTemplate>
                                        <div class="col-lg-4 ">
                                            <div class="product__discount__item" style="border: 2px solid whitesmoke;">
                                                <div class="product__discount__item__pic set-bg" style="background-color: whitesmoke;">
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
                                                <div class="product__discount__item__text">
                                                    <span><%# Eval("CategoryName") %></span>
                                                    <h5><%# Eval("Name") %></h5>
                                                    <div class="product__item__price"><%# Eval("SaleOff") %> Ks<span> <%# Eval("Price") %>Ks</span></div>
                                                </div>
                                                </asp:LinkButton>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </div>
                        </div>

                    </div>
                    <div class="filter__item">
                        <div class="row">
                            <div class="col-lg-4 col-md-5">
                                <div class="filter__sort">
                                    <span>Sort By</span>
                                    <select>
                                        <option value="0">Default</option>
                                        <option value="0">Default</option>
                                    </select>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-4">
                                <div class="filter__found">
                                    <h6><span><% Response.Write(Session["pCount"]); %></span> Products found</h6>
                                </div>
                            </div>
                            <div class="col-lg-4 col-md-3">
                                <div class="filter__option">
                                    <span class="icon_grid-2x2"></span>
                                    <span class="icon_ul"></span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="row">
                       <asp:Repeater ID="rAllProduct" runat="server" OnItemCommand="rSaleOff_ItemCommand">
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
                    <div class="product__pagination">
                        <a href="#">1</a>
                        <a href="#">2</a>
                        <a href="#">3</a>
                        <a href="#"><i class="fa fa-long-arrow-right"></i></a>
                    </div>
                </div>

            </div>
        </div>
    </section>
    <!-- Product Section End -->

</asp:Content>
