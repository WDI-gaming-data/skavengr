var watchId = null;
var questLocations = ['locations from gon'];

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
  questLocations.forEach(function(location) {
    var completed = checkDistance(
      pos.coords.latitude,
      pos.coords.longitude,
      location.lat,
      location.lng,
      50
    );
    if(completed === true) {
      //ajax post to complete this location
    }
  });
}


//&callback=initNewQuestMap

// function listPosition(position) {
//   console.log('in the list function');
//   console.log(position);
//   var el = $('<h1></h1>').text('Lat: ' + position.coords.latitude + ' Long: ' + position.coords.longitude);
//   $('#loc').prepend(el);
// }
