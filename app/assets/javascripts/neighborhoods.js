// Ajaxify the favorites button!
'use strict;'

$(function(){
	$('.favorite-button-wrapper').on("submit", "form", function(event){
		event.preventDefault();
    event.stopPropagation();
		var action = $(this).attr("action");
		var method = $(this).attr("method");

		$.ajax(action, {
			type: method,
			data: $(this).serialize(),
			dataType: "script"
		});
	});
});


function GMap(){
  this.$map = $('#map_canvas');
  this.address = $('.neighborhood-name').text();
};

GMap.prototype.insertMap = function(latitude, longitude){
   var canvas = this.$map[0];
   var myLatlng = new google.maps.LatLng(latitude, longitude);
   var mapOptions = {
     center: myLatlng,
     zoom: 13,
     mapTypeId: google.maps.MapTypeId.ROADMAP
   }
   var map = new google.maps.Map(canvas, mapOptions);
   var marker = new google.maps.Marker({
     position: myLatlng,
     map: map
   });
};

GMap.prototype.codeAddress = function(neighborhood){
   var geocoder = new google.maps.Geocoder();
   var address = neighborhood + " New York, NY";
   geocoder.geocode( {'address': address}, function(results, status) {
           var lat = results[0].geometry.location.lat();
           var lon = results[0].geometry.location.lng();
           this.insertMap(lat, lon);
       }.bind(this));
};