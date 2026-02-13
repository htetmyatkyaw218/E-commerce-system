using System;
using System.Data.SqlClient;
using System.Data;
using System.Web.UI;

namespace SecondHand.Customer
{
    public partial class login : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;

        protected void Page_Load(object sender, EventArgs e)
        {
            // If the user is already logged in, redirect them to the home page
            if (Session["userId"] != null)
            {
                Response.Redirect("Home.aspx");
            }
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            // Admin login check (hardcoded credentials)
            if (username == "Admin" && password == "123")
            {
                Session["admin"] = username;
                Response.Redirect("../Main/Dashboard.aspx"); // Redirect to admin dashboard
                return; // Exit the method after redirecting
            }

            // Open SQL connection to check for seller or user login
            using (con = new SqlConnection(Connection.GetConnectionString()))
            {
                // First, check if the user is a seller
                cmd = new SqlCommand("Seler_Crud", con);
                cmd.Parameters.AddWithValue("@Action", "SELECT4LOGIN");
                cmd.Parameters.AddWithValue("@Sellername", username);
                cmd.Parameters.AddWithValue("@Password", password);
                cmd.CommandType = CommandType.StoredProcedure;

                sda = new SqlDataAdapter(cmd);
                dt = new DataTable();
                sda.Fill(dt);

                if (dt.Rows.Count == 1 && dt.Rows[0]["IsActive"].ToString() == "Active" ) // Seller found
                {
                    Session["admin"] = username;
                    Session["username"] = username; // Store seller's username
                    Session["SellerId"] = dt.Rows[0]["SellerId"]; // Store seller's user ID
                    Response.Redirect("../Admin/Dashboard.aspx"); // Redirect to seller's dashboard
                }
                else
                {
                    // Check if the user is a regular user (not a seller)
                    cmd = new SqlCommand("User_Crud", con);
                    cmd.Parameters.AddWithValue("@Action", "SELECT4LOGIN");
                    cmd.Parameters.AddWithValue("@Username", username);
                    cmd.Parameters.AddWithValue("@Password", password);
                    cmd.CommandType = CommandType.StoredProcedure;

                    sda = new SqlDataAdapter(cmd);
                    dt = new DataTable();
                    sda.Fill(dt);

                    if (dt.Rows.Count == 1) // User found
                    {
                        Session["username"] = username; // Store user's username
                        Session["userId"] = dt.Rows[0]["UserId"]; // Store user's user ID
                        Response.Redirect("Home.aspx"); // Redirect to user's home page
                    }
                    else
                    {
                        // Show error message if login fails
                        lblMsg.Visible = true;
                        lblMsg.Text = "Invalid username or password!";
                        lblMsg.CssClass = "alert alert-danger";
                    }
                }
            }
        }
    }
}
