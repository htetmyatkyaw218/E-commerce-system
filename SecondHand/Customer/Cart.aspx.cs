using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Security.Cryptography.X509Certificates;
using System.Drawing;
using SecondHand.Admin;

namespace SecondHand.Customer
{
    public partial class Cart : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;
        decimal grandTotal = 0;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["userId"] == null)
                {
                    Response.Redirect("login.aspx");
                }
                else
                {
                    getCartItem();
                }
            }
        }

        void getCartItem()
        {
            con = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("Cart_Crud", con);
            cmd.Parameters.AddWithValue("@Action", "SELECT");
            cmd.Parameters.AddWithValue("@UserId", Session["userId"]);
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            rCartItem.DataSource = dt;

            if (dt.Rows.Count == 0)
            {
                rCartItem.FooterTemplate = null;
                rCartItem.FooterTemplate = new CustomTemplate(ListItemType.Footer);
            }
            rCartItem.DataBind();
        }

        protected void rCartItem_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            Utils utils = new Utils();
            if (e.CommandName == "remove")
            {
                con = new SqlConnection(Connection.GetConnectionString());
                cmd = new SqlCommand("Cart_Crud", con);
                cmd.Parameters.AddWithValue("@Action", "DELETE");
                cmd.Parameters.AddWithValue("@ProductId", e.CommandArgument);
                cmd.Parameters.AddWithValue("@UserId", Session["userId"]);
                cmd.CommandType = CommandType.StoredProcedure;
                try
                {
                    con.Open();
                    cmd.ExecuteNonQuery();
                    getCartItem();
                    // Cart count
                    Session["cartCount"] = utils.cartCount(Convert.ToInt32(Session["userId"]));

                }
                catch (Exception ex)
                {

                    Response.Write("<script>alert('Error -" + ex.Message + "') </script>");
                }
                finally
                {
                    con.Close();
                }

            }


        }
        protected void rCartItem_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                Label totalPrice = e.Item.FindControl("lblTotalPrice") as Label;
                Label productPrice = e.Item.FindControl("lblPrice") as Label;
                TextBox quantity = e.Item.FindControl("txtQuantity") as TextBox;
                decimal calTotalPrice = Convert.ToDecimal(productPrice.Text) * Convert.ToDecimal(quantity.Text);
                // decimal calTotalPrice= decimal.Parse(productPrice.Text ) * decimal.Parse(quantity.Text);
                totalPrice.Text = calTotalPrice.ToString();
                grandTotal += calTotalPrice;
            }
            Session["grandTotalPrice"] = grandTotal;
        }




        private sealed class CustomTemplate : ITemplate
        {
            private ListItemType ListItemType { get; set; }

            public CustomTemplate(ListItemType type)
            {
                ListItemType = type;
            }

            public void InstantiateIn(Control container)
            {
                if (ListItemType == ListItemType.Footer)
                {
                    var footer = new LiteralControl("<tr><td colspan='5'><b>Your Cart is Empty.</b> <a href='Home.aspx' class='badge badge-info ml-2'>Continue shopping</a></td></tr></tbody></table>");
                    container.Controls.Add(footer);
                }
            }
        }

        protected void lbCheckout_Click(object sender, EventArgs e)
        {
            // Check if the user is logged in
            if (Session["userId"] == null)
            {
                Response.Redirect("login.aspx");
                return;
            }

            // Get the user ID
            int userId = (int)Session["userId"];

            // Get the cart items for the user
            DataTable cartItems = GetCartItems(userId);

            // Check if there are items in the cart
            if (cartItems.Rows.Count == 0)
            {
                lblmsg.Visible = true;
                lblmsg.Text = "Your cart is empty.";
                lblmsg.CssClass = "alert alert-warning";
                return;
            }

            // Pass cart details to the payment page
            // You can use session variables to pass the cart data
            Session["CartItems"] = cartItems;

            // Redirect to the payment page
            Response.Redirect("Payment.aspx");
        }

        private DataTable GetCartItems(int userId)
        {
            DataTable dt = new DataTable();

            // Set up the SQL connection and command
            using (SqlConnection con = new SqlConnection(Connection.GetConnectionString()))
            {
                using (SqlCommand cmd = new SqlCommand("Cart_Crud", con))
                {
                    cmd.CommandType = CommandType.StoredProcedure;
                    cmd.Parameters.AddWithValue("@Action", "SELECT");
                    cmd.Parameters.AddWithValue("@UserId", userId);

                    SqlDataAdapter sda = new SqlDataAdapter(cmd);
                    sda.Fill(dt);
                }
            }

            return dt;
        }

    }
}