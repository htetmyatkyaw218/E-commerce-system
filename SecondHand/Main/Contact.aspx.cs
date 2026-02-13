
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using SecondHand.User;

namespace SecondHand.Main
{
    public partial class Contact : System.Web.UI.Page
    {
        SqlConnection con;
        SqlCommand cmd;
        SqlDataAdapter sda;
        DataTable dt;
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["breakCrum"] = "Contact User";
                if (Session["admin"] == null)
                {
                    Response.Redirect("../Customer/login.aspx");
                }
                else
                {
                    getContacts();
                }

            }
        }

        private void getContacts()
        {
            con = new SqlConnection(Connection.GetConnectionString());
            cmd = new SqlCommand("ContatSp", con);
            cmd.Parameters.AddWithValue("@Action", "SELECT");
            cmd.CommandType = CommandType.StoredProcedure;
            sda = new SqlDataAdapter(cmd);
            dt = new DataTable();
            sda.Fill(dt);
            rContact.DataSource = dt;
            rContact.DataBind();
        }

        protected void rContact_ItemCommand(object source, RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "delete")
            {
                con = new SqlConnection(Connection.GetConnectionString());
                cmd = new SqlCommand("ContatSp", con);
                cmd.Parameters.AddWithValue("@Action", "DELETE");
                cmd.Parameters.AddWithValue("@ContactId", e.CommandArgument);
                cmd.CommandType = CommandType.StoredProcedure;
            }
            try
            {
                con.Open();
                cmd.ExecuteNonQuery();
                lblMsg.Visible = true;
                lblMsg.Text = "Delete Record successfully";
                lblMsg.CssClass = "alert alert-success";
                getContacts();

            }
            catch (Exception ex)
            {
                lblMsg.Visible = true;
                lblMsg.Text = "error " + ex.Message;
                lblMsg.CssClass = "alert alert-warning";

            }
            finally
            {
                con.Close();
            }
        }
    }
}