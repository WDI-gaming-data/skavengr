var watchId = null;

function startWatching() {
  watchId = navigator.geolocation.watchPosition(fx, showError, {enableHighAccuracy: true});
}

function stopWatching() {
  navigator.geolocation.clearWatch(watchId);
  console.log('Stopped watching location.');
}

function showError(error) {
  console.log(error);
}

function checkDistance(lat_a, lng_a, lat_b, lng_b, distanceThreshold) {
  var a = new google.maps.LatLng(lat_a, lng_a);
  var b = new google.maps.LatLng(lat_b, lng_b);
  var distance = google.maps.geometry.spherical.computeDistanceBetween(a, b);
  return distance <= distanceThreshold ? true : distance;
}

function monitorPosition(pos) {
  gon.remaining_locations.forEach(function(location) {
    var completed = checkDistance(
      pos.coords.latitude,
      pos.coords.longitude,
      location.lat,
      location.lng,
      50
    );
    if(completed === true) {
      $.post('/quests/location', {location_id: location.id}, null, 'json');
    }
  });
}

if(gon.track) {
  startWatching();
} else {
  console.log('Error: User not recognized as a member of this quest');
}
