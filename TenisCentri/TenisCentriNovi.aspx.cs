using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Diagnostics;
using System.Web.UI;

namespace TenisCentri
{
    public partial class _TenisCentriNovi : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnSpremi_Click(object sender, EventArgs e)
        {
            string naziv = txtNaziv.Text.Trim().Replace(",", "."); ;
            string web = txtWeb.Text.Trim().Replace(",", "."); ;
            string telefon = txtTelefon.Text.Trim();
            string lat = hfLat.Value.Trim();
            string lng = hfLng.Value.Trim();

            if (string.IsNullOrEmpty(naziv) || string.IsNullOrEmpty(lat) || string.IsNullOrEmpty(lng))
            {
                ClientScript.RegisterStartupScript(this.GetType(), "alert", "alert('Naziv i koordinate su obavezni!');", true);
                return;
            }

            if (!decimal.TryParse(lat, System.Globalization.NumberStyles.Any, System.Globalization.CultureInfo.InvariantCulture, out decimal latitude) ||
        !decimal.TryParse(lng, System.Globalization.NumberStyles.Any, System.Globalization.CultureInfo.InvariantCulture, out decimal longitude))
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "errorToast",
                    "toastr.error('Koordinate moraju biti numeričke vrijednosti!', 'Greška');", true);
                return;
            }
            latitude = Math.Round(latitude, 6);
            longitude = Math.Round(longitude, 6);

            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            try
            {
                using (SqlConnection conn = new SqlConnection(connectionString))
                {
                    conn.Open();

                    string checkQuery = "SELECT COUNT(*) FROM TenisCentar WHERE Naziv = @Naziv AND Lat = @Lat AND Lng = @Lng";
                    using (SqlCommand checkCmd = new SqlCommand(checkQuery, conn))
                    {
                        checkCmd.Parameters.AddWithValue("@Naziv", naziv);
                        checkCmd.Parameters.AddWithValue("@Lat", latitude);
                        checkCmd.Parameters.AddWithValue("@Lng", longitude);

                        int count = (int)checkCmd.ExecuteScalar();
                        Debug.WriteLine(count);
                        if (count > 0)
                        {
                            ScriptManager.RegisterStartupScript(this, this.GetType(), "duplicateToast",
                                "toastr.warning('Centar već postoji u bazi podataka!', 'Upozorenje');", true);
                            return;
                        }
                    }

                    string query = "INSERT INTO TenisCentar (Naziv, Web, Telefon, Lat, Lng, Aktivan) VALUES (@Naziv, @Web, @Telefon, @Lat, @Lng, @Aktivan)";
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.Add(new SqlParameter("@Naziv", SqlDbType.NVarChar) { Value = naziv });
                        cmd.Parameters.Add(new SqlParameter("@Web", SqlDbType.NVarChar) { Value = string.IsNullOrEmpty(web) ? DBNull.Value : (object)web });
                        cmd.Parameters.Add(new SqlParameter("@Telefon", SqlDbType.NVarChar) { Value = string.IsNullOrEmpty(telefon) ? DBNull.Value : (object)telefon });
                        cmd.Parameters.Add(new SqlParameter("@Lat", SqlDbType.Float) { Value = latitude });
                        cmd.Parameters.Add(new SqlParameter("@Lng", SqlDbType.Float) { Value = longitude });
                        cmd.Parameters.Add(new SqlParameter("@Aktivan", SqlDbType.Int) { Value = 1 });
                        cmd.ExecuteNonQuery();
                    }
                }

                ClientScript.RegisterStartupScript(this.GetType(), "showSuccessToast", "showSuccessToast();", true);

                ClearForm();
                ClearDrawerForm();

            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "errorToast",
           $"toastr.error('Došlo je do greške: {ex.Message}', 'Greška');", true);
            }



        }

        private void ClearForm()
        {
            if (!string.IsNullOrEmpty(txtNaziv.Text))
            {
                txtNaziv.Text = "";
            }

            if (!string.IsNullOrEmpty(txtWeb.Text))
            {
                txtWeb.Text = "";
            }

            if (!string.IsNullOrEmpty(txtTelefon.Text))
            {
                txtTelefon.Text = "";
            }

            if (!string.IsNullOrEmpty(txtLat.Text))
            {
                txtLat.Text = "";
            }

            if (!string.IsNullOrEmpty(txtLng.Text))
            {
                txtLng.Text = "";
            }
        }

        private void ClearDrawerForm()
        {
            if (!string.IsNullOrEmpty(drawerNaziv.Text))
            {
                drawerNaziv.Text = "";
            }

            if (!string.IsNullOrEmpty(drawerWeb.Text))
            {
                drawerWeb.Text = "";
            }

            if (!string.IsNullOrEmpty(drawerTelefon.Text))
            {
                drawerTelefon.Text = "";
            }

            if (!string.IsNullOrEmpty(drawerLat.Text))
            {
                drawerLat.Text = "";
            }

            if (!string.IsNullOrEmpty(drawerLng.Text))
            {
                drawerLng.Text = "";
            }
        }
    }
}