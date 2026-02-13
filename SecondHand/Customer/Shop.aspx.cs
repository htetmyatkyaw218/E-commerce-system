using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SecondHand.Admin;

namespace SecondHand.Customer
{
    public partial class Shop : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            SaleOff();
            getProducts();
            Utils utils = new Utils();
            Session["pCount"] = utils.ProductCount().ToString();
        }
        private void getProducts()
        {
            con = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("Product_Crud", con);
            cmd.Parameters.AddWithValue("@Action", "ACTIVEPROD");
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
           
            rAllProduct.DataSource = dt;
            rAllProduct.DataBind();
           
        }
      

          private void SaleOff()
        {
            con = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("Product_Crud", con);
            cmd.Parameters.AddWithValue("@Action", "SaleOff");
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            rSaleOff.DataSource = dt;
            rSaleOff.DataBind();
           
        }
        protected void rSaleOff_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "productDetail")
            {
                string[] args = e.CommandArgument.ToString().Split(',');
                string productId = args[0];  // ProductID
                string categoryId = args[1]; // CategoryID

                // Redirect to ProductDetails.aspx with both ProductId and CategoryId as query string parameters
                Response.Redirect("ProductDetails.aspx?ProductId=" + productId + "&CategoryId=" + categoryId);
            }

            if (Session["userId"] != null)
            {

                bool isCartItemUpdate = false;
                int i = isItemExistInCart(Convert.ToInt32(e.CommandArgument));
                if (i == 0)
                {
                    // adding cart
                    con = new SqlConnection(Connection.GetConnectionString());
                    cmd = new SqlCommand("Cart_Crud", con);
                    cmd.Parameters.AddWithValue("@Action", "INSERT");
                    cmd.Parameters.AddWithValue("@ProductId", e.CommandArgument);
                    cmd.Parameters.AddWithValue("@Quantity", 1);
                    cmd.Parameters.AddWithValue("@UserId", Session["userId"]);
                    cmd.CommandType = CommandType.StoredProcedure;
                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
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
                else
                {

                    // adding existing item
                    Utils utils = new Utils();
                    isCartItemUpdate = utils.updateCartQuantity(i + 1, Convert.ToInt32(e.CommandArgument),
                        Convert.ToInt32(Session["userId"]));


                }
               
                Response.AddHeader("REFRESH", "1;URL=Shop.aspx");

            }
            else
            {
                Response.Redirect("login.aspx");
            }
        }
        int isItemExistInCart(int productId)
        {
            con = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("Cart_Crud", con);
            cmd.Parameters.AddWithValue("@Action", "GETBYID");
            cmd.Parameters.AddWithValue("@ProductId", productId);
            cmd.Parameters.AddWithValue("@UserId", Session["userId"]);
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            int quantity = 0;
            if (dt.Rows.Count > 0)
            {
                quantity = Convert.ToInt32(dt.Rows[0]["Quantity"]);
            }
            return quantity;
        }

        

        protected void rlastProduct_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "productDetail")
            {
                // Redirect to productDetail.aspx with the ProductId as a query string parameter
                string[] args = e.CommandArgument.ToString().Split(',');
                string productId = args[0];  // ProductID
                string categoryId = args[1]; // CategoryID

                // Redirect to ProductDetails.aspx with both ProductId and CategoryId as query string parameters
                Response.Redirect("ProductDetails.aspx?ProductId=" + productId + "&CategoryId=" + categoryId);
            }
            else
            {
                Response.Redirect("login.aspx");
            }
        }
    }
}