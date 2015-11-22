//Check if the gon object exists
if(typeof gon === "undefined") {
  gon = {};
}

//Check for geolocation support
if(!navigator.geolocation) {
  alert('Geolocation not enabled!');
}
