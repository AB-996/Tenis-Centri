<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="~/Default.aspx.cs" Inherits="TenisCentri._Default" %>

<!DOCTYPE html>
<html lang="hr">
<head runat="server">
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Unos Lokacija</title>
    <link href="Content/bootstrap.min.css" rel="stylesheet" />
    <style>
        .map-container {
            height: 500px;
            margin-top: 20px;
        }

        html, body {
            height: 100%;
            margin: 0;
            padding: 0;
        }

        .wrapper {
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        .main-content {
            flex: 1;
        }

        .footer {
            background-color: #dff6ff; /* Lagana plava nijansa */
            color: black;
            text-align: center;
            padding: 10px 0;
            width: 100%;
            position: relative; /* Osigurava da footer ne bude ispod sadržaja */
        }

        .footer img {
                max-height: 80px;
        }
    </style>
</head>
<body>
    <div class="wrapper">
        <form id="form1" runat="server" class="main-content">
            <div class="container mt-4 d-flex flex-column" style="height: 98vh">
                <div>
                    <div class="alert alert-info">
                        <asp:Repeater ID="rptCentri" runat="server">
                            <HeaderTemplate>
                                <span class="fw-bold">Zadnje dodani centri: </span>
                            </HeaderTemplate>
                            <ItemTemplate>
                                <p class="d-inline-block mr-3 mb-0">
                                    <span><%# Eval("Naziv") %></span>
                                    <span><%# (Container.ItemIndex < (5 - 1) ? ", " : "") %></span>
                                </p>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>

                    <!-- Google map -->
                    <div id="map" class="map-container shadow-sm rounded mb-4"></div>
                    <a href="TenisCentriNovi.aspx" class="btn btn-success w-100 mt-3">Dodaj novi tenis centar</a>
                </div>
                <p class="mt-auto text-center">Za sve informacije obratite se na: <a href="mailto:info@tenisliga.com">info@tenisliga.com</a></p>
            </div>

            <script src="Scripts/bootstrap.min.js"></script>
            <!-- Google Maps API -->
            <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBZBtNvxEB3Tagx8LdzBsEF2jQ67iIU21k&callback=initMap" async defer></script>
            <script>
                const allRecords = <%= Newtonsoft.Json.JsonConvert.SerializeObject(ViewState["AllRecords"]) %>;
            </script>
            <script src="Scripts/Pages/Default.js"></script>
        </form>
        <footer class="footer">
            <div class="container text-center">
                <p class="mb-0">
                    Powered by <a href="https://tenisliga.com" class="text-dark fw-bold" target="_blank">tenisliga.com</a>
                    <img src="Assets/Images/Logo.png" alt="Tenis Liga Logo" class="img-fluid ml-2" style="max-height: 80px;">
                </p>
            </div>
        </footer>
    </div>
</body>
</html>
