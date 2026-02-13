using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace SecondHand.Customer
{
    public partial class Payment : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;
        SqlDataReader dr, dr1;
        SqlTransaction transaction = null;
        string _name = string.Empty;
        string _cardNo = string.Empty;
        string _expiryDate = string.Empty;
        string _cvv = string.Empty;
        string _address = string.Empty;
        string _paymentMode = string.Empty;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (Session["userId"] == null)
                {
                    Response.Redirect("login.aspx");
                }
            }
        }

        protected void lbCardSubmit_Click(object sender, EventArgs e)
        {
            _name = txtName.Text.Trim();

            if (txtCardNo.Text.Trim().Length >= 16)
            {
                _cardNo = String.Format("************{0}", txtCardNo.Text.Trim().Substring(12, 4));
            }
            else
            {
                lblMsg.Visible = true;
                lblMsg.Text = "Invalid card number.";
                lblMsg.CssClass = "alert alert-danger";
                return;
            }

            _expiryDate = txtExpMonth.Text.Trim() + "/" + txtExpYear.Text.Trim();
            _cvv = txtCvv.Text.Trim();
            _address = txtAddress.Text.Trim();
            _paymentMode = "card";

            if (Session["userId"] != null)
            {
                OrderPayment(_name, _cardNo, _expiryDate, _cvv, _address, _paymentMode);
            }
            else
            {
                Response.Redirect("login.aspx");
            }
        }

        void OrderPayment(string name, string cardNo, string expiryDate, string cvv, string address, string paymentMode)
        {
            int paymentId;
            int productId;
            int quantity;

            dt = new DataTable();
            dt.Columns.AddRange(new DataColumn[7]
            {
                new DataColumn("OrderNo", typeof(string)),
                new DataColumn("ProductId", typeof(int)),
                new DataColumn("Quantity", typeof(int)),
                new DataColumn("UserId", typeof(int)),
                new DataColumn("Status", typeof(string)),
                new DataColumn("PaymentId", typeof(int)),
                new DataColumn("OrderDate", typeof(DateTime))
            });

            using (con = new SqlConnection(Connection.GetConnectionString()))
            {
                con.Open();

                #region Sql Transaction
                using (transaction = con.BeginTransaction())
                {
                    using (cmd = new SqlCommand("Save_Payment", con, transaction))
                    {
                        cmd.CommandType = CommandType.StoredProcedure;
                        cmd.Parameters.AddWithValue("@Name", name);
                        cmd.Parameters.AddWithValue("@CardNo", cardNo ?? (object)DBNull.Value);
                        cmd.Parameters.AddWithValue("@ExpiryDate", expiryDate ?? (object)DBNull.Value);
                        cmd.Parameters.AddWithValue("@Cvv", cvv ?? (object)DBNull.Value);
                        cmd.Parameters.AddWithValue("@Address", address);
                        cmd.Parameters.AddWithValue("@PaymentMode", paymentMode);
                        cmd.Parameters.Add("@InsertedId", SqlDbType.Int).Direction = ParameterDirection.Output;

                        try
                        {
                            cmd.ExecuteNonQuery();
                            paymentId = Convert.ToInt32(cmd.Parameters["@InsertedId"].Value);

                            #region Getting Cart Items
                            using (cmd = new SqlCommand("Cart_Crud", con, transaction))
                            {
                                cmd.CommandType = CommandType.StoredProcedure;
                                cmd.Parameters.AddWithValue("@Action", "SELECT");
                                cmd.Parameters.AddWithValue("@UserId", Session["userId"]);

                                using (dr = cmd.ExecuteReader())
                                {
                                    while (dr.Read())
                                    {
                                        productId = (int)dr["ProductId"];
                                        quantity = (int)dr["Quantity"];

                                        dt.Rows.Add(Utils.GetUniqueId(), productId, quantity, (int)Session["userId"], "Pending", paymentId, DateTime.Now);

                                        // Close reader before executing other commands
                                        dr.Close();

                                        // Update quantity and delete cart item
                                        UpdateQuantity(productId, quantity, con, transaction);
                                        DeleteCartItem(productId, con, transaction);

                                        // Get updated cart items
                                        using (cmd = new SqlCommand("Cart_Crud", con, transaction))
                                        {
                                            cmd.CommandType = CommandType.StoredProcedure;
                                            cmd.Parameters.AddWithValue("@Action", "SELECT");
                                            cmd.Parameters.AddWithValue("@UserId", Session["userId"]);

                                            dr = cmd.ExecuteReader();
                                        }
                                    }
                                    dr.Close(); //
                                }
                            }
                            #endregion

                            #region Save Order Details
                            if (dt.Rows.Count > 0)
                            {
                                using (cmd = new SqlCommand("Save_Orders", con, transaction))
                                {
                                    cmd.CommandType = CommandType.StoredProcedure;
                                    cmd.Parameters.AddWithValue("@tblOrders", dt);
                                    cmd.ExecuteNonQuery();
                                }
                            }
                            #endregion

                            transaction.Commit();
                            lblMsg.Visible = true;
                            lblMsg.Text = "Your Order was Successful";
                            lblMsg.CssClass = "alert alert-success";
                            Response.Redirect("Invoice.aspx?id=" + paymentId, false);
                        }
                        catch (Exception ex)
                        {
                            try
                            {
                                transaction.Rollback();
                            }
                            catch (Exception rollbackEx)
                            {
                                // Log rollback error
                                Response.Write("<script>alert('Rollback Error: " + rollbackEx.Message + "');</script>");
                            }

                            // Log original error
                            Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
                        }
                    }
                }
                #endregion
            }
        }

        void UpdateQuantity(int productId, int quantity, SqlConnection sqlConnection, SqlTransaction sqlTransaction)
        {
            using (SqlCommand cmd = new SqlCommand("Product_Crud", sqlConnection, sqlTransaction))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Action", "GETBID");
                cmd.Parameters.AddWithValue("@ProductId", productId);

                try
                {
                    using (SqlDataReader dr = cmd.ExecuteReader())
                    {
                        if (dr.Read())
                        {
                            int dbQuantity = (int)dr["Quantity"];

                            // Ensure we have enough quantity to update and it's not below the minimum threshold
                            if (dbQuantity >= quantity && dbQuantity > 2)
                            {
                                dbQuantity -= quantity;

                                // Close the reader before executing the update command
                                dr.Close();

                                using (SqlCommand updateCmd = new SqlCommand("Product_Crud", sqlConnection, sqlTransaction))
                                {
                                    updateCmd.CommandType = CommandType.StoredProcedure;
                                    updateCmd.Parameters.AddWithValue("@Action", "QTYUPDATE");
                                    updateCmd.Parameters.AddWithValue("@Quantity", dbQuantity);
                                    updateCmd.Parameters.AddWithValue("@ProductId", productId);

                                    updateCmd.ExecuteNonQuery();
                                }
                            }
                            else
                            {
                                // Handle cases where quantity is insufficient or invalid
                                // Depending on your application, you might want to throw an exception or log a warning
                                throw new Exception("Insufficient stock or invalid quantity.");
                            }
                        }
                        else
                        {
                            // Handle cases where no product was found
                            throw new Exception("Product not found.");
                        }
                    }
                }
                catch (Exception ex)
                {
                    // Log the exception and rethrow or handle as needed
                    Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
                }
            }
        }


        void DeleteCartItem(int productId, SqlConnection sqlConnection, SqlTransaction sqlTransaction)
        {
            using (cmd = new SqlCommand("Cart_Crud", sqlConnection, sqlTransaction))
            {
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Action", "DELETE");
                cmd.Parameters.AddWithValue("@ProductId", productId);
                cmd.Parameters.AddWithValue("@UserId", Session["userId"]);

                try
                {
                    cmd.ExecuteNonQuery();
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('Error: " + ex.Message + "');</script>");
                }
            }
        }
    }
}



