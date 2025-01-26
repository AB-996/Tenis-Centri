let map, marker;

toastr.options = {
    "closeButton": true,             // Dodaj gumb za zatvaranje
    "debug": false,                  // Debug mod
    "newestOnTop": true,             // Prikaži najnovije obavijesti na vrhu
    "progressBar": true,             // Prikaži progress bar
    "positionClass": "toast-top-right", // Lokacija toastra (npr. gore desno)
    "preventDuplicates": true,       // Spriječi dupliranje obavijesti
    "onclick": null,
    "showDuration": "300",           // Trajanje prikaza u milisekundama
    "hideDuration": "1000",
    "timeOut": "5000",               // Vrijeme prikaza
    "extendedTimeOut": "1000",
    "showEasing": "swing",
    "hideEasing": "linear",
    "showMethod": "fadeIn",          // Efekt pri prikazu
    "hideMethod": "fadeOut"          // Efekt pri zatvaranju
};

// Funkcija za prikaz toastra
function showSuccessToast() {
    toastr.success('Podaci su uspješno spremljeni!', 'Uspjeh');
}

function initMap() {
    const defaultLocation = { lat: 45.815399, lng: 15.966568 }; // Zagreb
    map = new google.maps.Map(document.getElementById('map'), {
        zoom: 8,
        center: defaultLocation,
        mapId: "customMap2025",
        mapTypeId: google.maps.MapTypeId.HYBRID,
        disableDefaultUI: true
    });

    const customIconElement = document.createElement('img');
    customIconElement.src = "Assets/Images/tennisPointer32White.png";
    customIconElement.style = "width:32px;height:32px;";


    map.addListener("click", (event) => {
        const lat = event.latLng.lat();
        const lng = event.latLng.lng();

        document.getElementById('txtLat').value = lat;
        document.getElementById('txtLng').value = lng;

        document.getElementById('hfLat').value = lat;
        document.getElementById('hfLng').value = lng;

        document.getElementById('drawerLat').value = lat;
        document.getElementById('drawerLng').value = lng;

        if (marker) {
            marker.setMap(null);
        }

        marker = new google.maps.marker.AdvancedMarkerElement({
            position: event.latLng,
            map: map,
            content: customIconElement
        });

        if (window.innerWidth < 768) {
            setTimeout(() => {
                var locationDrawer = new bootstrap.Offcanvas(document.getElementById('locationDrawer'));
                locationDrawer.show();
            }, 100);
        }
    });
}

function copyAndValidateForm() {
    // Copy values from drawer to main form
    document.getElementById('txtNaziv').value = document.getElementById('drawerNaziv').value;
    document.getElementById('txtWeb').value = document.getElementById('drawerWeb').value;
    document.getElementById('txtTelefon').value = document.getElementById('drawerTelefon').value;
    document.getElementById('txtLat').value = document.getElementById('drawerLat').value;
    document.getElementById('txtLng').value = document.getElementById('drawerLng').value;
    document.getElementById('hfLat').value = document.getElementById('drawerLat').value;
    document.getElementById('hfLng').value = document.getElementById('drawerLng').value;


    // Close the drawer
    var locationDrawer = bootstrap.Offcanvas.getInstance(document.getElementById('locationDrawer'));
    locationDrawer.hide();

    validateForm();
}

function validateForm() {
    let isValid = true;

    // Provjera Naziva
    const naziv = document.getElementById('txtNaziv');
    if (naziv.value.trim() === "") {
        naziv.classList.add("input-error");
        isValid = false;
    } else {
        naziv.classList.remove("input-error");
    }

    // Provjera Koordinata (Latitude)
    const lat = document.getElementById('txtLat');
    if (lat.value.trim() === "") {
        lat.classList.add("input-error");
        isValid = false;
    } else {
        lat.classList.remove("input-error");
    }

    // Provjera Koordinata (Longitude)
    const lng = document.getElementById('txtLng');
    if (lng.value.trim() === "") {
        lng.classList.add("input-error");
        isValid = false;
    } else {
        lng.classList.remove("input-error");
    }

    return isValid;
}

window.onload = initMap;