<%@ Page Title="" Language="C#" MasterPageFile="~/Main/Main.Master" AutoEventWireup="true" CodeBehind="Seller.aspx.cs" Inherits="SecondHand.Main.Seller" %>

<%@ Import Namespace="SecondHand" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        window.onload = function () {
            var seconds = 15;
            setTimeout(function () {
                document.getElementById("<%=lblMsg.ClientID%>").style.display = "none";
            }, seconds * 1000);
        };
    </script>
    <%--<script>
        function ImagePreview(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#<%=imgProduct.ClientID%>').prop('src', e.target.result)
                        .width(200)
                        .height(200);
                };
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>--%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <div class="pcoded-inner-content pt-0">
        <div class="align-align-self-end">
            <asp:Label ID="lblMsg" runat="server" Visible="false"></asp:Label>
        </div>

        <div class="main-body">
            <div class="page-wrapper">

                <div class="page-body">
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="card">
                                <div class="card-header">
                                </div>
                                <div class="card-block">
                                    <div class="row">

                                        <div class="col-sm-6 col-md-8 col-lg-8 ">
                                            <h4 class="sub-title">Seller Lists</h4>
                                            <div class="card-block table-border-style">
                                                <div class="table-responsive">

                                                    <asp:Repeater ID="rProduct" runat="server" OnItemCommand="rProduct_ItemCommand"
                                                       >

                                                        <HeaderTemplate>
                                                            <table class="table data-table-export table-hover nowrap">
                                                                <thead>
                                                                    <tr>
                                                                        <th class="table-plus">SrNo</th>
                                                                        <th>Name</th>
                                                                        <th>Image</th>
                                                                        <th>Seller Name</th>
                                                                        <th>Active</th>
                                                                        <th>Mobile</th>
                                                                        <th>Email</th>
                                                                        <th>Address</th>
                                                                        <th>Password</th>
                                                                        <th>Confirm Password</th>
                                                                        <th>CreateDate</th>
                                                                        <th class="datatable-nosort">Action</th>
                                                                    </tr>
                                                                </thead>
                                                                <tbody>
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <tr>
                                                                <td class="table-plus"><%# Eval("SrNo") %></td>
                                                                <td><%# Eval("Name") %></td>
                                                                <td>
                                                                    <img alt="" width="40" src="<%# Utils.GetImageUrl(Eval("imageUrl")) %>" />
                                                                </td>

                                                                <td><%# Eval("Sellername") %></td>
                                                                <td>
                                                                <asp:Label ID="lblStatus" runat="server" Text='<%# Eval("IsActive") %>'
                                                                    CssClass='<%# Eval("IsActive").ToString() == "Active" ? "badge badge-success" :
                                                                      "badge badge-warning" %>'></asp:Label>
                                                                <td>

                                                                    <%# Eval("Mobile") %>
                                                                </td>

                                                                <td><%# Eval("Email") %></td>
                                                                <td><%# Eval("Address") %></td>
                                                                <td><%# Eval("Password") %></td>
                                                                <td><%# Eval("CPassword") %> </td>



                                                                <td><%# Eval("CreateDate") %></td>

                                                                <td>

                                                                    <asp:LinkButton ID="lnkEdit" runat="server"
                                                                        CssClass="badge badge-primary" CausesValidation="false"
                                                                        CommandArgument='<%# Eval("SellerId") %>' CommandName="update">
                                                                     <i class="ti-pencil"></i>

                                                                    </asp:LinkButton>
                                                                    <asp:LinkButton ID="lnkDelete" Text="Delete" runat="server" CommandName="delete"
                                                                        CssClass="badge bg-danger" CommandArgument='<%# Eval("SellerId") %>'
                                                                        OnClient="return confirm('Do you want to delete this product?');"
                                                                        CausesValidation="false">
                                                                     
                                                                     <i class="ti-trash"></i>
                                                                    </asp:LinkButton>
                                                                </td>
                                                            </tr>
                                                        </ItemTemplate>
                                                        <FooterTemplate>
                                                            </tbody>
                                                        </table>
                                                        </FooterTemplate>
                                                    </asp:Repeater>

                                                </div>
                                            </div>
                                        </div>

                                        <div class="col-sm-6 col-md-4 col-lg-4 mobile-inputs">

                                            <asp:Panel ID="pUpdateOrderStatus" runat="server">
                                                <h4 class="sub-title">Update Status</h4>
                                                <div>
                                                    <div class="form-group">
                                                        <label>Seller Status </label>
                                                        <div>
                                                            <asp:DropDownList ID="ddlOrderStatus" runat="server" CssClass="form-control">
                                                                <asp:ListItem Value="0">Select Status</asp:ListItem>
                                                                <asp:ListItem>Active</asp:ListItem>
                                                                <asp:ListItem>In-Active</asp:ListItem>
                                                               

                                                            </asp:DropDownList>
                                                            <asp:RequiredFieldValidator ID="rfvDdlOrderStatus" runat="server" ForeColor="Red" ControlToValidate="ddlOrderStatus"
                                                                ErrorMessage="Order status is required " SetFocusOnError="true" Display="Dynamic" InitialValue="0">

                                                            </asp:RequiredFieldValidator>
                                                            <asp:HiddenField ID="hdnId" runat="server" Value="0" />

                                                        </div>
                                                    </div>

                                                    <div class="pb-5">
                                                        <asp:Button ID="btnUpdate" runat="server" Text="Update" CssClass="btn btn-primary"
                                                            OnClick="btnUpdate_Click" />
                                                        &nbsp;
                                                            <asp:Button ID="btnCancel" runat="server" Text="Cancel" CssClass="btn btn-primary" OnClick="btnCancel_Click" />

                                                    </div>
                                                </div>
                                            </asp:Panel>

                                        </div>

                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>
