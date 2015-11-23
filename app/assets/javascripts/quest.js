var map = null;
var mapReady = false;

var markers = [];
var clues = [];
var infoWindows = [];
var heroes = [];
var packagedMarkers = null;
var packagedHeroes = null;

function initNewQuestMap() {
  navigator.geolocation.getCurrentPosition(function(position) {
    map = new google.maps.Map(document.getElementById('map'), {
      center: {
        lat: position.coords.latitude,
        lng: position.coords.longitude
      },
      zoom: 14
    });
    google.maps.event.addListenerOnce(map, 'idle', function() {
      mapReady = true;
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
  var infoWindow = new google.maps.InfoWindow();
  infoWindows.push(infoWindow);
  google.maps.event.addListener(marker, 'click', function() {
    // var infoWindow = new google.maps.InfoWindow();
    infoWindow.setContent(this.label);
    infoWindow.open(map, this);
    // infoWindows.push(infoWindow);
  });
  clues.push('');
  return marker;
}

function addFormRow() {
  var idStr = 'loc-' + markers.length;
  var nameInput = $('<input>').attr('type', 'text')
    .attr('idx', markers.length)
    .addClass('loc')
    .addClass('form-control')
    .attr('name', 'user[name]')
    .attr('id', idStr);
  var nameGroup = $('<div></div>').addClass('form-group');
  nameGroup.append('<label>Name</label>')
    .attr('for', idStr);
  nameGroup.append(nameInput);
  $('#loc-list').append(nameGroup);
  var clueIdStr = 'clue-' + markers.length;
  var clueInput = $('<textarea>')
    .attr('id', clueIdStr)
    .attr('idx', clues.length)
    .addClass('clue')
    .addClass('form-control');
  var clueGroup = $('<div></div>').addClass('form-group');
  clueGroup.append('<label>Clue</label>')
    .attr('for', clueIdStr);
  clueGroup.append(clueInput);
  $('#loc-list').append(clueGroup).append($('<hr/>'));
  $('.loc').keyup(function(e) {
    var idx = parseInt(this.getAttribute('idx'), 10);
    markers[idx].setLabel(this.value);
    infoWindows[idx].setContent(this.value);
  });
  $('.clue').keyup(function(e) {
    var idx = parseInt(this.getAttribute('idx'), 10);
    clues[idx] = this.value;
  });
}

function addHeroFormRow() {
  var idStr = 'hero-' + heroes.length;
  var nameInput = $('<input>').attr('type', 'text')
    .attr('idx', heroes.length)
    .addClass('hero')
    .addClass('form-control')
    .attr('name', 'user[name]')
    .attr('id', idStr);
  heroes.push('');
  var nameGroup = $('<div></div>').addClass('form-group');
  nameGroup.append('<label>Hero\'s email!</label>')
    .attr('for', idStr);
  nameGroup.append(nameInput);
  $('#hero-list').append(nameGroup);
  $('.hero').keyup(function(e) {
    var idx = parseInt(this.getAttribute('idx'), 10);
    heroes[idx] = this.value;
    console.log(heroes, idx);
  });
}

//Function to package the locations into an array without the extra Google Maps marker data
//Should be stringified and passed to the server
function packageMarkers(arr) {
  var locations = arr.map(function(marker, idx) {
    var rObj = {};
    rObj.lat = marker.getPosition().lat();
    rObj.lng = marker.getPosition().lng();
    rObj.name = marker.label;
    rObj.clue = clues[idx];
    return rObj;
  });
  return locations;
}

$(function() {
  $('#new-location').click(function(e) {
    e.preventDefault();
    if(mapReady) {
      addFormRow();
      markers.push(createMarker('test', map));
    }
  });
  $('#new-hero').click(function(e){
    e.preventDefault();
    addHeroFormRow();
  });
  $('.trigger-time').click(function() {
    packagedMarkers = packageMarkers(markers);
    packagedMarkersString = JSON.stringify(packagedMarkers);
    packagedHeroes = JSON.stringify(heroes);
    $('#quest_locations').val(packagedMarkersString);
    $('#quest_heroes').val(packagedHeroes);
  });
  $('#modal-locations').on('show.bs.modal', function () {
    console.log('in the resize listener');
    try {
      google.maps.event.trigger(map, "resize");
    } catch(e) {
      console.log(e);
    }
  });
});

