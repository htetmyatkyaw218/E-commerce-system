using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml.Linq;

namespace SecondHand.Customer
{
    public partial class Profile : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;

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
                    getUserDetails();
                    getPurchaseHistory();
                }
            }
        }

        void getUserDetails()
        {
            try
            {
                con = new SqlConnection(Connection.GetConnectionString());
                cmd = new SqlCommand("User_Crud", con);
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.AddWithValue("@Action", "SELECT4PROFILE");
                cmd.Parameters.AddWithValue("@UserId", Session["userId"]);

                sda = new SqlDataAdapter(cmd);
                dt = new DataTable();
                sda.Fill(dt);

                rUserProfile.DataSource = dt;
                rUserProfile.DataBind();
                
                if (dt.Rows.Count == 1)
                {
                    Session["name"] = dt.Rows[0]["Name"].ToString();
                    Session["username"] = dt.Rows[0]["Username"].ToString();
                    Session["email"] = dt.Rows[0]["Email"].ToString();
                    Session["imageUrl"] = dt.Rows[0]["ImageUrl"].ToString();
                    Session["createdDate"] = dt.Rows[0]["CreateDate"].ToString();
                }
            }
            catch (Exception ex)
            {
                // Handle exceptions (e.g., log errors)
                Response.Write($"<script>alert('Error: {ex.Message}');</script>");
            }
        }
        void getPurchaseHistory()
        {
            int sr = 1;
            con = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("Invoice", con);
            cmd.Parameters.AddWithValue("@Action", "ODRHISTORY");
            cmd.Parameters.AddWithValue("@UserId", Session["userId"]);
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            dt.Columns.Add("SrNo", typeof(Int32));
            if (dt.Rows.Count > 0)
            {
                foreach (DataRow dataRow in dt.Rows)
                {
                    dataRow["SrNO"] = sr;
                    sr++;
                }
            }
            if (dt.Rows.Count == 0)
            {
              
                rPurchaseHistory.FooterTemplate = null;
                rPurchaseHistory.FooterTemplate = new CustomTemplate(ListItemType.Footer);
            }
            rPurchaseHistory.DataSource = dt;
            rPurchaseHistory.DataBind();
        }
        protected void rPurchaseHistory_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            double grandTotal = 0;
            HiddenField paymentId=e.Item.FindControl("hdnPaymentId") as HiddenField;
            Repeater repOrders = e.Item.FindControl("rOrders") as Repeater;

            con = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("Invoice", con);
            cmd.Parameters.AddWithValue("@Action", "INVOIBYID");
            cmd.Parameters.AddWithValue("@PaymentId",Convert.ToInt32(paymentId.Value));
            cmd.Parameters.AddWithValue("@UserId", Session["userId"]);
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
         
            if (dt.Rows.Count > 0)
            {
                foreach (DataRow dataRow in dt.Rows)
                {
                    grandTotal += Convert.ToDouble(dataRow["TotalPrice"]);
                }
            }
           DataRow dr=dt.NewRow();
            dr["TotalPrice"] = grandTotal;
            dt.Rows.Add(dr);

            repOrders.DataSource = dt;
            repOrders.DataBind();
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


    }
}