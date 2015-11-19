//Create a marker at the specified latLng
function createMarker(latLng, map) {
  var marker = new google.maps.Marker({
    position: latLng,
    map: map
  });
}
