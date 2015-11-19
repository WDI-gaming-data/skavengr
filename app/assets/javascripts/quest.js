var map = null;
//Check if the gon object exists
if(typeof gon === "undefined") {
  gon = {};
}

function initMap() {
  navigator.geolocation.getCurrentPosition(function(position) {
    map = new google.maps.Map(document.getElementById('map'), {
      center: {
        lat: position.coords.latitude,
        lng: position.coords.longitude
      },
      zoom: 14
    });
    map.addListener('click', function(e) {
      createMarker(e.latLng, map);
    });
  });
}
