<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="~/TenisCentarNovi.aspx.cs" Inherits="TenisCentri._TenisCentriNovi" %>

<!DOCTYPE html>
<html lang="hr">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Unos Lokacija</title>
    <script src="Scripts/jquery-3.7.1.min.js"></script>
    <script src="Scripts/toastr.min.js"></script>
    <script src="Scripts/bootstrap.min.js"></script>
    <script src="Scripts/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" />
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <link href="Content/toastr.min.css" rel="stylesheet" />
    <style>
        .map-container {
            height: 500px;
            margin-top: 20px;
            position: relative;
        }

        .offcanvas {
            z-index: 1050; /* Ensure the drawer is above the map */
        }

        .instructions {
            margin-bottom: 20px;
        }

        .required-label {
            color: red;
            font-size: 0.875rem; /* Manji font za zvjezdicu */
        }

        /* Crveni border za grešku */
        .input-error {
            border: 1px solid red;
        }

        /* Hide the drawer on larger screens */
        @media (min-width: 768px) {
            #locationDrawer {
                display: none !important;
            }

            .main-instructions {
                display: none !important;
            }
        }

        /* Hide the custom location form on mobile devices */
        @media (max-width: 767px) {
            .custom-location-form {
                display: none !important;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container mt-4">
            <a href="Default.aspx" class="btn btn-outline-secondary mb-3"><i class="fas fa-arrow-left pe-2"></i>Povratak</a>

            <div class="alert alert-info main-instructions">
                <strong>Upute:</strong>
                <ul>
                    <li>Odaberite lokaciju centra</li>
                    <li>Unesite potrebne informacije</li>
                    <li>Potvrdite unos gumbom "Spremi"</li>
                </ul>
            </div>

            <div class="card p-4 shadow-sm custom-location-form">
                <h2 class="card-title text-center mb-4">Unos Lokacija</h2>

                <!-- Upute -->
                <div class="alert alert-info instructions">
                    <strong>Upute:</strong>
                    <ul>
                        <li>Upišite naziv lokacije.</li>
                        <li>Upišite web adresu (ako postoji).</li>
                        <li>Kliknite na kartu za odabir koordinata.</li>
                        <li>Potvrdite unos klikom na "Spremi".</li>
                    </ul>
                </div>

                <!-- Forma -->
                <div class="row">
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label for="Naziv" class="form-label">Naziv <span class="required-label">* Obavezno</span></label>
                            <asp:TextBox ID="txtNaziv" runat="server" CssClass="form-control" placeholder="Unesite naziv"></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label for="Web" class="form-label">Web</label>
                            <asp:TextBox ID="txtWeb" runat="server" CssClass="form-control" placeholder="Unesite web adresu"></asp:TextBox>
                        </div>
                        <div class="mb-3">
                            <label for="Telefon" class="form-label">Telefon</label>
                            <asp:TextBox ID="txtTelefon" runat="server" CssClass="form-control" placeholder="Unesite broj telefona"></asp:TextBox>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="mb-3">
                            <label for="Koordinate" class="form-label">Koordinate <span class="required-label">* Odaberi na karti</span></label>
                            <asp:TextBox ID="txtLat" runat="server" CssClass="form-control mb-2" placeholder="Latitude" ReadOnly="true"></asp:TextBox>
                            <asp:TextBox ID="txtLng" runat="server" CssClass="form-control" placeholder="Longitude" ReadOnly="true"></asp:TextBox>
                            <asp:HiddenField ID="hfLng" runat="server" />
                            <asp:HiddenField ID="hfLat" runat="server" />
                        </div>
                    </div>
                </div>
                <asp:Button ID="btnSpremi" runat="server" CssClass="btn btn-success w-100" Text="Spremi" OnClientClick="return validateForm();" OnClick="btnSpremi_Click" />
            </div>

            <!-- Drawer -->
            <div class="offcanvas offcanvas-end" tabindex="-1" id="locationDrawer" aria-labelledby="locationDrawerLabel">
                <div class="offcanvas-header">
                    <h5 class="offcanvas-title" id="locationDrawerLabel">Unos Lokacije</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                </div>

                <!-- Upute -->
                <div class="alert alert-info instructions">
                    <strong>Upute:</strong>
                    <ul>
                        <li>Upišite naziv lokacije.</li>
                        <li>Upišite web adresu (ako postoji).</li>
                        <li>Potvrdite unos klikom na "Spremi".</li>
                    </ul>
                </div>
                <div class="offcanvas-body">
                    <div class="mb-3">
                        <label for="drawerNaziv" class="form-label">Naziv <span class="required-label">* Obavezno</span></label>
                        <asp:TextBox ID="drawerNaziv" runat="server" CssClass="form-control" placeholder="Unesite naziv"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label for="drawerWeb" class="form-label">Web</label>
                        <asp:TextBox ID="drawerWeb" runat="server" CssClass="form-control" placeholder="Unesite web adresu"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label for="drawerTelefon" class="form-label">Telefon</label>
                        <asp:TextBox ID="drawerTelefon" runat="server" CssClass="form-control" placeholder="Unesite broj telefona"></asp:TextBox>
                    </div>
                    <div class="mb-3">
                        <label for="Koordinate" class="form-label">Koordinate <span class="required-label">* Odaberi na karti</span></label>
                        <asp:TextBox ID="drawerLat" runat="server" CssClass="form-control mb-2" placeholder="Latitude" ReadOnly="true"></asp:TextBox>
                        <asp:TextBox ID="drawerLng" runat="server" CssClass="form-control" placeholder="Longitude" ReadOnly="true"></asp:TextBox>
                    </div>
                    <asp:Button ID="btnSpremi2" runat="server" CssClass="btn btn-primary w-100" Text="Spremi" OnClientClick="return copyAndValidateForm();" OnClick="btnSpremi_Click" />
                </div>
            </div>


            <!-- Google mapa -->
            <div id="map" class="map-container shadow-sm rounded mb-4"></div>
        </div>
        <!-- Google Maps API -->
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBZBtNvxEB3Tagx8LdzBsEF2jQ67iIU21k&callback=initMap&libraries=marker" async defer></script>
        <script src="Scripts/Pages/TenisCentriNovi.js"></script>
    </form>
</body>
</html>
