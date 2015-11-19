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
    var pos = marker.getPosition();
    console.log(pos.lat(), pos.lng());
  });
  return {
    name: name,
    marker: marker
  };
}

function addFormRow() {
  var row = $('li').append($('<input>').attr('type', 'text').addClass('loc');
  // row.attr()markers.length));
  $('#form').append(row);
}

$(function() {
  $('button').click(function(e) {
    e.preventDefault();
    markers.push(createMarkerObj('test', map));
  });
});

