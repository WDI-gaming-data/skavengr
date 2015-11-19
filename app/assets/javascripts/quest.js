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
function createMarker(name, map) {
  var marker = new google.maps.Marker({
    position: map.getCenter(),
    map: map,
    label: name,
    draggable:true,
    animation: google.maps.Animation.DROP
  });
  marker.addListener('dragend', function() {
    var pos = marker.getPosition();
    console.log(pos.lat(), pos.lng());
  });
  google.maps.event.addListener(marker, 'click', function() {
    infowindow.setContent(this.label);
    infowindow.open(map, this);
  });
  return marker;
}

function addFormRow() {
  var row = $('<li></li>').append($('<input>').attr('type', 'text').addClass('loc'));
  row.attr('idx', markers.length);
  $('#loc-list').append(row);
}

$(function() {
  $('button').click(function(e) {
    e.preventDefault();
    markers.push(createMarker('test', map));
    addFormRow();
  });
  $('.loc').keyup(function() {
    markers[parseInt(this.idx)]['label'] = this.val();
  });
});

