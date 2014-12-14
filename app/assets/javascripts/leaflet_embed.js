var map;
var ajaxRequest;
var plotlist;
var plotlayers=[];
var meeting_point_ids = new Array();



function askForPlots() {
    var bounds=map.getBounds();
    var minll=bounds.getSouthWest();
    var maxll=bounds.getNorthEast();
    $("#descriptions").empty();
    var checkboxes='<div id="input_container"><ul>';
    L.Icon.Default.imagePath = "/assets"
    $.ajax({
        type: 'GET',
        dataType: 'json',
        url: '/meeting_points/map_points',
        data:{latmax: maxll.lat, lngmax: maxll.lng, latmin: minll.lat, lngmin: minll.lng},
        success: function (plotlist) {
            removeMarkers();
            var markers = new L.MarkerClusterGroup({maxClusterRadius: 80});
            meeting_point_ids = [];
            $.each(plotlist, function (intIndex, objValue) {
                var title = objValue[2];
                meeting_point_ids[intIndex] = objValue[3];
                checkboxes+='<li><input type="checkbox" name="meeting_point['+objValue[3]+']" id="meeting_point['+objValue[3]+']" value="'+objValue[3]+'"></input>';
                checkboxes+='<label for="meeting_point['+objValue[3]+']">'+objValue[2]+' /<br /> '+objValue[5]+'</label></li>';
                var marker = new L.Marker(new L.LatLng(objValue[1], objValue[0]), { title: title });
                marker.bindPopup(title);
                markers.addLayer(marker);
            });
            $("#descriptions").append (checkboxes+'</ul></div>');
            map.addLayer(markers);

        }
    });

}
function removeMarkers() {
	for (i=0;i<plotlayers.length;i++) {
		map.removeLayer(plotlayers[i]);
	}
	plotlayers=[];
}
function initmap(lat, lng) {
    L.Icon.Default.imagePath = "/assets"

    var cloudmadeUrl = 'http://{s}.tile.osm.org/{z}/{x}/{y}.png',
    cloudmadeAttribution = 'Map data &copy; 2011 OpenStreetMap contributors, Imagery &copy; 2011 CloudMade, Points &copy 2012 LINZ',
    cloudmade = new L.TileLayer(cloudmadeUrl, {maxZoom: 17, attribution: cloudmadeAttribution}),
    latlng = new L.LatLng(lat, lng);
	// set up the map
    map = new L.Map('map', {center: latlng, zoom: 13, layers: [cloudmade]});

	// create the tile layer with correct attribution
//	var osmUrl='http://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png';
//	var osmAttrib='Map data © OpenStreetMap contributors';
//	var osm = new L.TileLayer(osmUrl, {minZoom: 8, maxZoom: 12, attribution: osmAttrib});

	// start the map in South-East England
//	map.setView(new L.LatLng(lat, lng),9);
    map.attributionControl.setPrefix('');
//	map.addLayer(osm);
    askForPlots();
    map.on('moveend', onMapMove);
}

    // then add this as a new function...
function onMapMove(e) { askForPlots(); }
