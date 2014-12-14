var index = 0;
var html;
var marker = [];

text = {
    statusSelectIcon:'Icon für den Marker auswählen.',
    statusSetMarker:'Auf die Karte klicken um Marker zu setzen oder ',
    statusChangeMarker:'Auf die Karte klicken um Markerposition neu zu setzen oder ',
    withoutMarker:'ohne Marker',
    delete:'löschen',
    onlyMarker:'nur Marker',
    setMarker:'Marker setzen',
    editMarker:'Marker bearbeiten',
    removeMarker:'Marker entfernen',
    markerLinkEditbox:'Marker-Link (zum Beispiel für E-Mail, Chat):',
    help:'Hilfe',
    closeMarkerMenu:'Markerwahl beenden',
    width:'Breite',
    height:'Höhe',
    includeInWebsite:'In Webseite einbinden'
}

function removeMeetingPoint(id, key) {
    $.ajax({
        type:'GET',
        url:'/profiles/kill_off_photo/' + key,
        success:function (xml) {
            map.removeLayer(marker[id]);
            unloadAddress(id);
        }
    });
}

function removeMarker(id) {
    unloadAddress(id);
}

function unloadAddress(id) {
    $('#profile_meeting_points_attributes_' + id + '_lng').remove();
    $('#profile_meeting_points_attributes_' + id + '_lat').remove();
    $('#profile_meeting_points_attributes_' + id + '_description').remove();
    $('#profile_meeting_points_attributes_' + id + '_id').remove();
}

function loadAddress(lon, lat, id) {

    $('<input>').attr({
        type:'hidden',
        value:lon,
        id:'profile_meeting_points_attributes_' + id + '_lng',
        name:'profile[meeting_points_attributes][' + id + '][lng]'
    }).appendTo('form');

    $('<input>').attr({
        type:'hidden',
        value:lat,
        id:'profile_meeting_points_attributes_' + id + '_lat',
        name:'profile[meeting_points_attributes][' + id + '][lat]'
    }).appendTo('form');

    $('<input>').attr({
        type:'text',
        size:'30',
        id:'profile_meeting_points_attributes_' + id + '_description',
        name:'profile[meeting_points_attributes][' + id + '][description]'
    }).appendTo('#meeting_points');

}

function my_meeting_points(arg) {

    var htmlMarker;
    var id = 0;
//    L.tileLayer('http://{s}.tile.cloudmade.com/BC9A493B41014CAABB98F0471D759707/997/256/{z}/{x}/{y}.png', {
//        maxZoom:18
//    }).addTo(map);
    L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
        maxZoom:18,
        attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
    }).addTo(map);

    L.Icon.Default.imagePath = "/assets"
    jQuery.each(arg, function (intIndex, objValue) {
        marker[intIndex] = L.marker([objValue[1], objValue[0]], {draggable:true});
        map.addLayer(marker[intIndex]);
        id++;
        html = objValue[2] + '<br /><a onclick="removeMeetingPoint(' + intIndex + ',' + objValue[3] + ');">' + text.delete + '</a>';
        marker[intIndex].bindPopup(html);
        marker[intIndex].on('dragend', function (e) {
            var coords = e.target._latlng;
            var lng = coords.lng;
            var lat = coords.lat;
            index = intIndex;
            jQuery.ajax({
                type:"GET",
                url:"http://nominatim.openstreetmap.org/reverse?format=xml&zoom=18&addressdetails=1&lat=" + lat + "&lon=" + lng,
                dataType:"xml",
                success:function (xml) {

                    jQuery(xml).find("addressparts").each(function () {
                        res = jQuery(this).find("road").text() + ", " + $(this).find("city").text();

                    });
                    jQuery("#profile_meeting_points_attributes_" + intIndex + "_lat").val(lat);
                    jQuery("#profile_meeting_points_attributes_" + intIndex + "_lng").val(lng);
                    jQuery("#profile_meeting_points_attributes_" + intIndex + "_description").val(res);
                    htmlMarker = marker[intIndex];

                    id = intIndex;
                    html = res + '<br /><a onclick="removeMeetingPoint(' + intIndex + ',' + objValue[3] + ');">' + text.delete + '</a>';
                    marker[intIndex].bindPopup(html).openPopup();
                },
                error:function (e) {
                    console.log(e);
                }
            });
        });
        index++;
    });
}

function zoomToLonLat(lon, lat, zoom) {
    map.setView(new L.LatLng(parseFloat(lat), parseFloat(lon)), zoom);
}

function addMarker(e) {

    var lng = e.latlng.lng;
    var lat = e.latlng.lat;
    var marker = new L.Marker(new L.LatLng(parseFloat(lat), parseFloat(lng)), {draggable:true});
//    L.Icon.Default.imagePath = 'assets/images';
    L.Icon.Default.imagePath = "/assets"
    map.addLayer(marker);
    zoomToLonLat(lng, lat, 13);
//            var htmlMarker = marker[index];
    $.ajax({
        type:"GET",
        url:"http://nominatim.openstreetmap.org/reverse?format=xml&zoom=18&addressdetails=1&lat=" + lat + "&lon=" + lng,
        dataType:"xml",
        success:function (xml) {

            $(xml).find("addressparts").each(function () {
                res = $(this).find("road").text() + ", " + $(this).find("city").text();

            });
            loadAddress(lng, lat, index);
            $("#profile_meeting_points_attributes_" + index + "_description").val(res);
            $("#profile_meeting_points_attributes_" + index + "_lat").val(lat);
            $("#profile_meeting_points_attributes_" + index + "_lng").val(lng);
            id = index;
            html = res + '<br /><a >' + text.delete + '</a>';
            var domelem = document.createElement('p');
            domelem.href = "#";
            domelem.innerHTML = html;
            domelem.onclick = function (e) {
                removeMarker(id);
                map.removeLayer(marker);
            };
            marker.bindPopup(domelem).openPopup();
        },
        error:function (e) {
            console.log(e);
        }
    });
    marker.on('dragend', function (e) {
        var coords = e.target._latlng;
        var lng = coords.lng;
        var lat = coords.lat;

        $.ajax({
            type:"GET",
            url:"http://nominatim.openstreetmap.org/reverse?format=xml&zoom=18&addressdetails=1&lat=" + lat + "&lon=" + lng,
            dataType:"xml",
            success:function (xml) {
                $(xml).find("addressparts").each(function () {
                    res = $(this).find("road").text() + ", " + $(this).find("city").text();
                });
                $("#profile_meeting_points_attributes_" + index + "_description").val(res);
                $("#profile_meeting_points_attributes_" + index + "_lat").val(lat);
                $("#profile_meeting_points_attributes_" + index + "_lng").val(lng);
                html = res + '<br /><a >' + text.delete + '</a>';
                var domelem = document.createElement('p');
                domelem.href = "#";
                domelem.innerHTML = html;
                domelem.onclick = function (e) {
                    removeMarker(id);
                    map.removeLayer(marker);
                };
                marker.bindPopup(domelem).openPopup();
            },
            error:function (e) {
                console.log(e);
            }
        });
    });
    index++;
}

function show_meeting_points(arg) {

    var htmlMarker;
    var id = 0;
//    L.tileLayer('http://{s}.tile.cloudmade.com/BC9A493B41014CAABB98F0471D759707/997/256/{z}/{x}/{y}.png', {
//        maxZoom:18,
//        attribution:'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery <a href="http://cloudmade.com">CloudMade</a>'
//    }).addTo(map);
    L.tileLayer('http://{s}.tile.osm.org/{z}/{x}/{y}.png', {
        attribution: '&copy; <a href="http://osm.org/copyright">OpenStreetMap</a> contributors'
    }).addTo(map);

    $.each(arg, function (intIndex, objValue) {
        marker[intIndex] = L.marker([objValue[1], objValue[0]], {draggable:false});
        map.addLayer(marker[intIndex]);
        marker[intIndex].bindPopup(objValue[2]);
    });
}