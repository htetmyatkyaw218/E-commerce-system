<%@ Page Title="" Language="C#" MasterPageFile="~/Customer/Customer.Master" AutoEventWireup="true" CodeBehind="Home.aspx.cs" Inherits="SecondHand.Customer.Home" %>

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


    <!-- Hero Section Begin -->
    <section class="hero">
        <div class="container">
            <div class="row">
                <!-- Removed the col-lg-3 column -->
                <div class="col-lg-12">
                    <%-- <div class="hero__search" style="border-bottom: 2px solid whitesmoke;">

                        <div class="hero__search__phone">
                            <div class="hero__search__phone__icon">
                                <i class="fa fa-phone"></i>
                            </div>
                            <div class="hero__search__phone__text">
                                <h5>+95 451 112 34</h5>
                                <span>support 24/7 time</span>
                            </div>
                        </div>
                    </div>--%>

                    <div id="carouselExampleInterval" class="carousel slide" data-bs-ride="carousel">
                        <div class="carousel-inner">
                            <div class="carousel-item active" data-bs-interval="1000">
                                <img src="../File/banner-5.jpg" class="d-block w-100" alt="..." loading="eager">
                            </div>
                            <div class="carousel-item" data-bs-interval="2000">
                                <img src="../File/banner-5.jpg" class="d-block w-100" alt="..." loading="eager">
                            </div>
                            <div class="carousel-item">
                                <img src="../File/banner-5.jpg" class="d-block w-100" alt="..." loading="eager">
                            </div>
                        </div>
                        <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleInterval" data-bs-slide="prev">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            <span class="visually-hidden">Previous</span>
                        </button>
                        <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleInterval" data-bs-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            <span class="visually-hidden">Next</span>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </section>


    <!-- Hero Section End -->

    <!-- Categories Section Begin -->
    <section class="categories">
        <div class="container">
            <div class="row">
                <div class="categories__slider owl-carousel">

                    <asp:Repeater ID="rSliderCategory" runat="server">

                        <ItemTemplate>

                            <div class="col-lg-3" >
                                <div class="categories__item set-bg" data-setbg='<%# Utils.GetImageUrl(Eval("ImageUrl")) %>'>
                                    <h5><a href="#" style="border:2px solid whitesmoke; background-color:whitesmoke;"><%# Eval("Name") %></a></h5>
                                </div>

                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                    <div class="col-lg-3">
                        <div class="categories__item set-bg" data-setbg="../File/img/categories/z.gif">
                            <h5><a href="#">Smartphone</a></h5>
                        </div>
                    </div>



                </div>
        </div>
        </div>
    </section>
    <!-- Categories Section End -->
    <!-- Featured Section Begin -->
    <section class="featured spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-12">
                    <div class=" text-right ">
                        <asp:Label ID="lblmsg" runat="server" Visible="false"></asp:Label>
                    </div>

                    <div class="section-title">
                        <h2>Featured Product</h2>
                    </div>
                    <div class="featured__controls">
                        <ul>

                            <li class="active" data-filter="*">All</li>
                            <asp:Repeater ID="rCategory" runat="server">
                                <ItemTemplate>

                                    <li data-filter=".<%# Regex.Replace( Eval("Name").ToString().ToLower(),@"\s+" ,"") %> "><%# Eval("Name") %></li>

                                </ItemTemplate>
                            </asp:Repeater>


                        </ul>
                    </div>
                </div>
            </div>
            <div class="row featured__filter">

                <asp:Repeater ID="rProducts" runat="server" OnItemCommand="rProducts_ItemCommand">
                    <ItemTemplate>

                        <div class="col-lg-3 col-md-4 col-sm-6 mix <%# Regex.Replace( Eval("Categoryname").ToString().ToLower(),@"\s+" ,"") %>">
                            <div class="featured__item">
                                <div class="featured__item__pic set-bg" style="background-color: whitesmoke;">

                                    <div class="grow">
                                        <image src="<%# Utils.GetImageUrl(Eval("ImageUrl")) %>"></image>
                                    </div>
                                    <ul class="featured__item__pic__hover">
                                        <li><a href="#"><i class="fa fa-heart"></i></a></li>
                                        <li><a href="#"><i class="fa fa-retweet"></i></a></li>
                                        <li>
                                            <asp:LinkButton ID="lbAddToCart" runat="server" CommandName="addToCart"
                                                CommandArgument='<%# Eval("ProductId") %>'>
                                                 <i class="fa fa-shopping-cart"></i></a>
                                            </asp:LinkButton>
                                        </li>
                                    </ul>
                                </div>
                                <div class="featured__item__text">

                                    <%-- <asp:LinkButton ID="lblProductDetail" runat="server" CommandName="productDetail"
                                        CommandArgument='<%# Eval("ProductId") %>'>--%>
                                    <asp:LinkButton ID="lblProductDetail" runat="server" CommandName="productDetail"
                                        CommandArgument=' <%# Eval("ProductID") + "," + Eval("CategoryID") %>'>
                                     <h6>
                                                    <%# Eval("Name") %>
                                       
                                    </h6>
                                    <h5><%# Eval("Price") %> KS</h5>
                                    </asp:LinkButton>
                                </div>
                            </div>
                        </div>

                    </ItemTemplate>
                </asp:Repeater>



            </div>
        </div>
    </section>
    <!-- Featured Section End -->

    <!-- Banner Begin -->
    <div class="banner">
        <div class="container">
            <div class="row">
                <div class="col-lg-6 col-md-6 col-sm-6">
                    <div class="banner__pic">
                        <img src="./File/img/banner/banner-4.jpg" alt="">
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-6">
                    <div class="banner__pic">
                        <img src="./File/img/hero/Kyawnyar.jpg" alt="">
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- Banner End -->

    <!-- Latest Product Section Begin -->
    <section class="latest-product spad">
        <div class="container">
            <div class="row">
                <div class="col-lg-4 col-md-6">
                    <div class="latest-product__text">
                        <h4>Latest Products</h4>
                        <div class="latest-product__slider owl-carousel">


                            <asp:Repeater ID="rLastProduct" runat="server" OnItemCommand="rLastProduct_ItemCommand">
                                <ItemTemplate>
                                    <div class="latest-prdouct__slider__item">
                                        <asp:LinkButton ID="lblProductDetail" runat="server" CssClass="latest-product__item" CommandName="productDetail"
                                            CommandArgument='<%# Eval("ProductId") %>'> 
 
                                                <div class="latest-product__item__pic grow ">
                                                <img src="<%# Utils.GetImageUrl(Eval("ImageUrl")) %>" alt=""  style="width:110px; height:110px; ">
                                                </div>
   
                                                <div class="latest-product__item__text">
                                                 <h6><%# Eval("Name") %></h6>
                                                 <span><%# Eval("Price") %></span>
                                                 </div>
 
                                        </asp:LinkButton>

                                        <a href="#" class="latest-product__item">
                                            <div class="latest-product__item__pic grow">
                                                <img src="../File/img/latest-product/JBL-Harman-Boomboox-3-Bluetooth-Speaker-Black-Image-1.png" alt="">
                                            </div>
                                            <div class="latest-product__item__text">
                                                <h6>JBL Harman Boomboox 3 Bluetooth Speaker</h6>
                                                <span>2090000.00 KS</span>
                                            </div>
                                        </a>
                                        <a href="#" class="latest-product__item">
                                            <div class="latest-product__item__pic grow">
                                                <img src="../File/img/latest-product/Airpods-3-Magsafe-Charging-white-image.png" alt="">
                                            </div>
                                            <div class="latest-product__item__text">
                                                <h6>Airpods 3 (Lightning Charging)</h6>
                                                <span>820000.00 KS</span>
                                            </div>
                                        </a>

                                    </div>
                                </ItemTemplate>

                            </asp:Repeater>

                        </div>
                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="latest-product__text">
                        <h4>Top Rated Products</h4>
                        <div class="latest-product__slider owl-carousel">

                            <asp:Repeater ID="rTopProduct" runat="server" OnItemCommand="rLastProduct_ItemCommand">
                                <ItemTemplate>
                                    <div class="latest-prdouct__slider__item">
                                        <asp:LinkButton ID="lblProductDetail" runat="server" CssClass="latest-product__item" CommandName="productDetail"
                                            CommandArgument='<%# Eval("ProductId") %>'> 
 
                                 <div class="latest-product__item__pic grow ">
                                 <img src="<%# Utils.GetImageUrl(Eval("ImageUrl")) %>" alt=""  style="width:110px; height:110px; ">
                                 </div>
   
                                     <div class="latest-product__item__text">
                                      <h6><%# Eval("Name") %></h6>
                                     <span><%# Eval("Price") %></span>
                                         </div>
 
                                        </asp:LinkButton>
                                        <a href="#" class="latest-product__item">
                                            <div class="latest-product__item__pic grow">
                                                <img src="../File/img/latest-product/Redmi-Note-13-4G-Mist-Green-Image-10-1.png" alt="">
                                            </div>
                                            <div class="latest-product__item__text">
                                                <h6>Redmi Note 13 (4G) (Official)</h6>
                                                <span>839000.00 KS</span>
                                            </div>
                                        </a>
                                        <a href="#" class="latest-product__item">
                                            <div class="latest-product__item__pic grow">
                                                <img src="../File/img/latest-product/Gadget-Max-GB-11-Pro-Yellow.png" alt="">
                                            </div>
                                            <div class="latest-product__item__text">
                                                <h6>Gadget Max GB-11Pro (My Container 60000mAh Power Bank)</h6>
                                                <span>185000.00 KS</span>
                                            </div>
                                        </a>

                                    </div>
                                </ItemTemplate>

                            </asp:Repeater>
                        </div>

                    </div>
                </div>
                <div class="col-lg-4 col-md-6">
                    <div class="latest-product__text">
                        <h4>Review Products</h4>
                        <div class="latest-product__slider owl-carousel">


                            <asp:Repeater ID="rAllProduct" runat="server" OnItemCommand="rLastProduct_ItemCommand">
                                <ItemTemplate>
                                    <div class="latest-prdouct__slider__item">
                                        <asp:LinkButton ID="lblProductDetail" runat="server" CssClass="latest-product__item" CommandName="productDetail"
                                            CommandArgument='<%# Eval("ProductId") %>'> 
 
                                             <div class="latest-product__item__pic grow ">
                                               <img src="<%# Utils.GetImageUrl(Eval("ImageUrl")) %>" alt=""  style="width:110px; height:110px; ">
                                              </div>
   
                                                   <div class="latest-product__item__text">
                                                <h6><%# Eval("Name") %></h6>
                                                    <span><%# Eval("Price") %></span>
                                                      </div>
 
                                        </asp:LinkButton>
                                        <a href="#" class="latest-product__item">
                                            <div class="latest-product__item__pic grow">
                                                <img src="../File/img/latest-product/Samsung-Galaxy-Fit-3-Pink-Image.png" alt="">
                                            </div>
                                            <div class="latest-product__item__text">
                                                <h6>Samsung Galaxy Fit 3</h6>
                                                <span>305000.00 KS</span>
                                            </div>
                                        </a>
                                        <a href="#" class="latest-product__item">
                                            <div class="latest-product__item__pic grow">
                                                <img src="../File/img/latest-product/Remax-F27-Fonzyr-Series-Circulation-Fan-Grey-Purple-Image.png" alt="">
                                            </div>
                                            <div class="latest-product__item__text">
                                                <h6>Remax F27 (Fonzyr Series) Circulation Fan</h6>
                                                <span>120000.00 KS</span>
                                            </div>
                                        </a>

                                    </div>
                                </ItemTemplate>

                            </asp:Repeater>


                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- Latest Product Section End -->


</asp:Content>
