var watchId = null;
var playerCircle = null;

function initPlayerMap() {
  navigator.geolocation.getCurrentPosition(function(position) {
    map = new google.maps.Map(document.getElementById('map'), {
      center: {
        lat: position.coords.latitude,
        lng: position.coords.longitude
      },
      zoom: 18
    });
    google.maps.event.addListenerOnce(map, 'idle', function() {
      mapReady = true;
    });
    playerCircle = new google.maps.Circle({
      strokeColor: '#ffffff',
      strokeOpacity: 1,
      strokeWeight: 2,
      fillColor: '#0066ff',
      fillOpacity: 1,
      map: map,
      center: map.center,
      radius: 5
    });
  });
}

function startWatching() {
  watchId = navigator.geolocation.watchPosition(monitorPosition, showError, {enableHighAccuracy: true});
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
  playerCircle.center = new google.maps.LatLng(pos.coords.latitude, pos.coords.longitude);
  gon.remaining_locations.forEach(function(location, idx) {
    var completed = checkDistance(
      pos.coords.latitude,
      pos.coords.longitude,
      location.lat,
      location.lng,
      50
    );
    if(completed === true) {
      console.log('In the completed objective if statement');
      $.post('/quests/location', { location_id: location.id }, function(data) {
        gon.completed_locations.push(location);
        gon.remaining_locations.splice(idx, 1);
        renderObjectives();
      }, 'json');
      sweetAlert('Objective Completed: ' + location.name, gon.remaining_locations.length + 'objectives remaining', 'success');
    }
  });
}

function renderObjectives() {
  var locationsDiv = $('.locations');
  locationsDiv.html('').append('<h2>Current Objectives</h2>');
  gon.remaining_locations.forEach(function(item) {
    locationsDiv.append(
      $('<div></div>').addClass('well')
      .append($('<h3></h3>').text(item.name))
      .append($('<p></p>').text(item.clue))
    );
  });
  locationsDiv.html('').append('<h2>Completed Objectives</h2>');
  gon.completed_locations.forEach(function(item) {
    locationsDiv.append(
      $('<div></div>').addClass('well')
      .append($('<h3></h3>').text(item.name))
      .append($('<p></p>').text(item.clue))
    );
  });
}

if(gon.track) {
  console.log('Tracking user position');
  startWatching();
} else {
  console.log('Not currently tracking user position.');
}
