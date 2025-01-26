using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web.UI;

namespace TenisCentri
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            LoadRecords();
        }

        private void LoadRecords()
        {
            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT TenisCentarId, Naziv, Telefon, Web, Lat, Lng, Aktivan
                    FROM TenisCentar
                    ORDER BY TenisCentarId DESC";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    conn.Open();
                    SqlDataAdapter adapter = new SqlDataAdapter(cmd);
                    DataTable dt = new DataTable();
                    adapter.Fill(dt);

                    // Store the records in ViewState as a JSON string
                    ViewState["AllRecords"] = dt;

                    // Bind the Repeater with the last 5 records
                    rptCentri.DataSource = dt.AsEnumerable().Take(5).CopyToDataTable();
                    rptCentri.DataBind();
                }
            }
        }
    }
}
