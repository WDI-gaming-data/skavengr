var map = null;
//Check if the gon object exists
if(typeof gon === "undefined") {
  gon = {};
}

var markers = [];

function initMap() {
  navigator.geolocation.getCurrentPosition(function(position) {
    map = new google.maps.Map(document.getElementById('map'), {
      center: {
        lat: position.coords.latitude,
        lng: position.coords.longitude
      },
      zoom: 14
    });
  });
}

//Returns an object with a name and the associated marker
function createMarkerObj(name, map) {
  var marker = new google.maps.Marker({
    position: map.getCenter(),
    map: map,
    draggable:true,
    animation: google.maps.Animation.DROP
  });
  marker.addListener('dragend', function() {
    console.log(marker.getPosition());
  });
  return {
    name: name,
    marker: marker
  };
}

$(function() {
  $('button').click(function(e) {
    e.preventDefault();
    createMarkerObj('test', map);
  });
});

