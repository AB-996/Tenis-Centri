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
    </style>
</head>
<body>
    <form id="form1" runat="server">
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
</body>
</html>
