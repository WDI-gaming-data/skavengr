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
    var infoWindow = new google.maps.InfoWindow();
    infoWindow.setContent(this.label);
    infoWindow.open(map, this);
  });
  return marker;
}

function addFormRow() {
  var row = $('<li></li>').append($('<input>').attr('type', 'text').attr('idx', markers.length).addClass('loc'));
  $('#loc-list').append(row);
  $('.loc').keyup(function(e) {
    console.log('in keyup');
    markers[parseInt(this.attr('idx'))].setLabel(this.val());
  });
}

$(function() {
  $('button').click(function(e) {
    e.preventDefault();
    markers.push(createMarker('test', map));
    addFormRow();
  });
  $('.loc').keyup(function(e) {
    console.log('in keyup');
    markers[parseInt(this.attr('idx'))].setLabel(this.val());
  });
});

