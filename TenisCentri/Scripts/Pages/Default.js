let map;
let currentInfoWindow = null;

function initMap() {
    const defaultLocation = { lat: 45.815399, lng: 15.966568 }; // Default map center (Zagreb)
    map = new google.maps.Map(document.getElementById('map'), {
        zoom: 8,
        center: defaultLocation,
    });

    const customIcon = {
        url: "Assets/Images/tennisPointer32White.png",
        scaledSize: new google.maps.Size(32, 32),
    };


    allRecords.forEach(record => {
        const lat = record.Lat;
        const lng = record.Lng;
        const name = record.Naziv;

        const marker = new google.maps.Marker({
            position: { lat: parseFloat(lat), lng: parseFloat(lng) },
            map: map,
            icon: customIcon,
            title: name,
        });
        const web = record.Web ? `<a href="${record.Web}" target="_blank">${record.Web}</a>` : '-';
        const telefon = record.Telefon ? record.Telefon : '-';

        const infoWindowContent = `
                <div>
                    <h3>${name}</h3>
                    <div>
                        <div style="padding:5px 0px">
                        Web: ${web}<br style="margin-bottom: 10px;">
                        </div>
                        <div style="padding:5px 0px;">
                        Telefon: ${telefon}<br style="margin-bottom: 10px;">
                        </div>
                        <div style="padding:5px 0px;">
                        <a href="https://www.google.com/maps/dir/?api=1&destination=${lat},${lng}" target="_blank">Get Directions - Google maps</a>
                        </div>
                    </div>
                </div>
            `;

        const infoWindow = new google.maps.InfoWindow({
            content: infoWindowContent
        });

        marker.addListener("click", function () {
            if (currentInfoWindow) {
                currentInfoWindow.close();
            }

            infoWindow.open(map, marker);

            currentInfoWindow = infoWindow;
        });
    });
}

window.onload = initMap;