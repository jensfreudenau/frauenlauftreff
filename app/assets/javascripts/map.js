


text = {
    statusSelectIcon:'Icon für den Marker auswählen.',
    statusSetMarker:'Auf die Karte klicken um Marker zu setzen oder ',
    statusChangeMarker:'Auf die Karte klicken um Markerposition neu zu setzen oder ',
    withoutMarker:'ohne Marker',
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
var inputId = 0;
function openWin(i, lon, lat) {
    var res;
    var dataString;
//    $("#profile_meeting_points_attributes_"+i+"_description").val($('#entry'+i).val());
//    var parameters = "{'lat':'" + lat + "','lon':'" + lon + "','format':'xml'}";
//    http://nominatim.openstreetmap.org/reverse?format=xml&lat=52.5487429714954&lon=-1.81602098644987&zoom=18&addressdetails=1
    $.ajax({
      type: "GET",
      url: "http://nominatim.openstreetmap.org/reverse?format=xml&zoom=18&addressdetails=1&lat="+lat+"&lon="+lon,
      dataType: "xml",
        success: function(xml) {
            $(xml).find("addressparts").each(function () {
                res = $(this).find("road").text() + ", "+ $(this).find("city").text();
                $("#profile_meeting_points_attributes_"+i+"_description").val(res);
             });
            $('form').submit();
            location.reload();

        },
        error: function(e){
            console.log(e) ;
        }
    });
    var pt = new OpenLayers.LonLat(lon, lat).transform(new OpenLayers.Projection("EPSG:4326"), map.getProjectionObject());
    $.each(map.popups, function (intIndex, objValue) {

        if (objValue.lonlat.lon == pt.lon ) {
            objValue.hide();
        }
    });
    return false;
}

function loadAddress(lon,lat, id) {
    $('<input>').attr({
        type:'hidden',
        value:lon,
        id:'profile_meeting_points_attributes_' + id + '_long',
        name:'profile[meeting_points_attributes][' + id + '][long]'
    }).appendTo('form');
    $('<input>').attr({
        type:'hidden',
        value:lat,
        id:'profile_meeting_points_attributes_' + id + '_lat',
        name:'profile[meeting_points_attributes][' + id + '][lat]'
    }).appendTo('form');
    $('<input>').attr({
        type:'text',
        value:id,
        id:'profile_meeting_points_attributes_' + id + '_description',
        name:'profile[meeting_points_attributes][' + id + '][description]'
    }).appendTo('#meeting_points');

}

var iconSize = new OpenLayers.Size(21, 25);
var iconOffset = new OpenLayers.Pixel(-(iconSize.w / 2), -iconSize.h);
var icon = new OpenLayers.Icon("http://www.openstreetmap.org/openlayers/img/marker.png",
    iconSize, iconOffset);
var zoom=12, center, currentPopup, map, lyrMarkers, popup;
var popupClass = OpenLayers.Class(OpenLayers.Popup.Anchored, {
    "autoSize":true,
    "minSize":new OpenLayers.Size(200, 100),
    "maxSize":new OpenLayers.Size(500, 100),
    "backgroundColor":"#ffffff",
    "keepInMap":true
//
});
var bounds = new OpenLayers.Bounds();


function addMarker(lng, lat, htmlForm) {

    var pt = new OpenLayers.LonLat(lng, lat).transform(new OpenLayers.Projection("EPSG:4326"), map.getProjectionObject());
    bounds.extend(pt);
    var feature = new OpenLayers.Feature(lyrMarkers, pt);

    feature.closeBox = true;
    feature.popupClass = popupClass;
    feature.data.popupContentHTML = htmlForm;
    feature.data.overflow = "false";

    var marker = new OpenLayers.Marker(pt, icon.clone());

    var markerClick = function (evt) {

        if (currentPopup != null && currentPopup.visible()) {
            currentPopup.hide();
            if (this.popup == null) {
            }
            else {
                this.popup.toggle();
            }
        }
        if (this.popup == null) {
            this.popup = this.createPopup(this.closeBox);
            map.addPopup(this.popup);
            this.popup.show();
        } else {
            this.popup.toggle();
        }

        currentPopup = this.popup;
        OpenLayers.Event.stop(evt);
    };
    marker.events.register("click", feature, markerClick);
//                marker.events.register( "click", marker, function (e) { currentPopup.toggle() } );
    lyrMarkers.addMarker(marker);

}



function create_map(w) {
    var inputId = 0;
    var fromProjection = new OpenLayers.Projection("EPSG:4326");   // Transform from WGS 1984
    var toProjection = new OpenLayers.Projection("EPSG:900913"); // to Spherical Mercator Projection
    var options = {
        projection:new OpenLayers.Projection("EPSG:900913"),
        displayProjection:new OpenLayers.Projection("EPSG:4326"),
        units:"m",
        numZoomLevels:19,
        maxResolution:156543.0339,
        maxExtent:new OpenLayers.Bounds(-20037508.34, -20037508.34, 20037508.34, 20037508.34)
    };
    map = new OpenLayers.Map("map", options);
    map.addControl(new OpenLayers.Control.DragPan());
    var lyrOsm = new OpenLayers.Layer.OSM();
    map.addLayer(lyrOsm);
    lyrMarkers = new OpenLayers.Layer.Markers("Markers");
    map.addLayer(lyrMarkers);
    //add marker on given coordinates

    $.each(w, function (intIndex, objValue) {
        inputId++;
        var html = ' <input type="text" value="' + objValue[2] + '" name="description" id="entry' + intIndex + '"></input>' +
            '<br /><input type="checkbox" class="delete" name="delete">löschen</input> ' +
            '<br /><button class="button gform_button" onclick="openWin(' + intIndex + ',' + objValue[0] + ',' + objValue[1] + ');">ändern</button> ';
        addMarker(objValue[0], objValue[1], html);
    });

    map.events.register("click", map, function (e) {
        var pos_new         = map.getLonLatFromPixel(e.xy);
        var position_new    = new OpenLayers.LonLat(pos_new.lon, pos_new.lat).transform(toProjection, fromProjection);
        var latitude        = position_new.lat;
        var longitude       = position_new.lon;
        var size            = new OpenLayers.Size(21, 25);
        var offset          = new OpenLayers.Pixel(-(size.w / 2), -size.h);
        var icon            = new OpenLayers.Icon('/assets/marker.png', size, offset);
        lyrMarkers.addMarker(new OpenLayers.Marker(pos_new, icon));
        inputId++;
        var html =  '<br /><input type="checkbox" name="delete">löschen</input> ' +
                    '<br /><button class="button gform_button" onclick="openWin(' + inputId + ',' + longitude + ',' + latitude + ');">ändern</button> ';

        addMarker(longitude, latitude, html);
        loadAddress(longitude, latitude, inputId);


    });
    map.addControl(new OpenLayers.Control.MousePosition());
    center = bounds.getCenterLonLat();
    map.setCenter(center, map.getZoomForExtent(bounds) - 1);
    zoom = map.getZoom();
}

function create_mapw(para) {
    var id;
    map = new OpenLayers.Map("map");
    var mapnik = new OpenLayers.Layer.OSM();
    map.addLayer(mapnik);
    var markers = new OpenLayers.Layer.Markers("Markers");
    map.addLayer(markers);
    var center = new OpenLayers.LonLat(13.530152427741, 52.574271736597).transform(new OpenLayers.Projection("EPSG:4326"), new OpenLayers.Projection("EPSG:900913"));
    map.setCenter(center, 10);
    $.each(para, function (intIndex, objValue) {
        id = intIndex;
        var loc = new OpenLayers.LonLat(objValue[0], objValue[1]).transform(new OpenLayers.Projection("EPSG:4326"), new OpenLayers.Projection("EPSG:900913"));

        popup = new OpenLayers.Popup("chicken"+id,
                            loc,
                           new OpenLayers.Size(200,200),
                           "example popup"+id,
                           true);

        map.addPopup(popup);
        popup.hide();
        console.log(popup);
//        popup.updatePosition();
//        popup.addCloseBox();
        var marker = new OpenLayers.Marker(loc);
        marker.events.register( "click", marker, function (e) { popup.toggle() } );
        markers.addMarker(marker);
    });








}
function create_mapq(markerCoord) {

    // Popup und Popuptext mit evtl. Grafik
    OpenLayers.Lang.setCode('de');

    // Position und Zoomstufe der Karte
    var lon = 13.530152427741;
    var lat = 52.574271736597;
    var zoom = 12;

    map = new OpenLayers.Map("map");
    var mapnik = new OpenLayers.Layer.OSM();
    map.addLayer(mapnik);
    var fromProjection = new OpenLayers.Projection("EPSG:4326");   // Transform from WGS 1984
    var toProjection = new OpenLayers.Projection("EPSG:900913"); // to Spherical Mercator Projection
    var position = new OpenLayers.LonLat(lon, lat).transform(fromProjection, toProjection);
    var markers = new OpenLayers.Layer.Markers("Markers");
    map.setCenter(position, zoom);

    $.each(markerCoord, function (intIndex, objValue) {

        var addposition = new OpenLayers.LonLat(objValue[0], objValue[1]).transform(fromProjection, toProjection);
        var addmarkers = new OpenLayers.Layer.Markers("Markers");
        map.addLayer(addmarkers);
        addmarkers.addMarker(new OpenLayers.Marker(addposition));


    });

    markers.id = "Markers";
    map.addLayer(markers);



    map.events.register("click", map, function (e) {

        inputId++;
        //var position = this.events.getMousePosition(e);
        var pos_new = map.getLonLatFromPixel(e.xy);


        var position_new = new OpenLayers.LonLat(pos_new.lon, pos_new.lat).transform(toProjection, fromProjection);
        var latitude = position_new.lat;
        var longitude = position_new.lon;
        var size = new OpenLayers.Size(21, 25);
        var offset = new OpenLayers.Pixel(-(size.w / 2), -size.h);
        var icon = new OpenLayers.Icon('/assets/marker.png', size, offset);
        var markerslayer = map.getLayer('Markers');
        var marker = new OpenLayers.Marker(pos_new, icon);
        markerslayer.addMarker(new OpenLayers.Marker(pos_new, icon));
        id_create = longitude.toString().replace('.', '') + latitude.toString().replace('.', '');


        $('<input>').attr({
            type:'hidden',
            value:longitude,
            id:'profile_meeting_points_attributes_' + inputId + '_long',
            name:'profile[meeting_points_attributes][' + inputId + '][long]'
        }).appendTo('form');
        $('<input>').attr({
            type:'hidden',
            value:latitude,
            id:'profile_meeting_points_attributes_' + inputId + '_lat',
            name:'profile[meeting_points_attributes][' + inputId + '][lat]'
        }).appendTo('form');

        marker.events.register('click', { overlay:markerslayer, marker:marker }, function (e) {
                                        console.log('hi hu');
//                    var opx = map.getLonLatFromPixel(e.xy);
////                    var markerx = new OpenLayers.Marker(opx);
//                    popup = new OpenLayers.Popup("chicken",
//                        marker.lonlat,
//                        new OpenLayers.Size(500,500),
//                           "example popup",
//                           true);
//
//            map.addPopup(popup);

//            this.overlay.removeMarker(this.marker);
//            id = '#' + this.marker.lonlat.lon.toString().replace('.', '') + this.marker.lonlat.lat.toString().replace('.', '');
//
//            $(id).remove();
//            this.marker.destroy();
        });


    });
    map.addControl(new OpenLayers.Control.MousePosition());

    map.addLayer(mapnik);
//    map.setCenter(position, zoom);

}


function createMapWithRoute1(zoomControl) {

    zoomControl = typeof(zoomControl) != 'undefined' ? zoomControl : false;
    var minLat = 100000;
    var maxLat = 0;
    var minLong = 100000;
    var maxLong = 0;
    var map;

    //set up projections
    // World Geodetic System 1984 projection
    var WGS84 = new OpenLayers.Projection("EPSG:4326");


    map = new OpenLayers.Map('minimap', {
        controls:[
            new OpenLayers.Control.Navigation(),
            new OpenLayers.Control.LayerSwitcher(),
            new OpenLayers.Control.PanZoomBar({zoomStopHeight:0}),
            new OpenLayers.Control.Attribution(),
            new OpenLayers.Control.MousePosition(),
            new OpenLayers.Control.KeyboardDefaults(),
            new OpenLayers.Control.ScaleLine({geodesic:true})
        ],
        theme:null,
        projection:new OpenLayers.Projection("EPSG:900913"),
        displayProjection:new OpenLayers.Projection("EPSG:4326"),
        units:"m",
        numZoomLevels:18,
        maxResolution:156543.0339,
        //maxResolution: "auto",
        maxExtent:new OpenLayers.Bounds(-20037508, -20037508,
            20037508, 20037508.34)
    });


    //base layers
    var hikebike = new OpenLayers.Layer.TMS(
        "Hike & Bike Map",
        "http://toolserver.org/tiles/hikebike/",
        {
            type:'png', getURL:osm_getTileURL,
            displayOutsideMaxExtent:true, isBaseLayer:true,
            attribution:'Map Data from <a href="http://www.openstreetmap.org/">OpenStreetMap</a> (<a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-by-SA 2.0</a>)'
        }
    );
    var osm = new OpenLayers.Layer.OSM.Mapnik("Mapnik");
    var cycle = new OpenLayers.Layer.OSM.CycleMap("CycleMap");
    var osma = new OpenLayers.Layer.OSM.Osmarender("Osmarender");


    var contours = new OpenLayers.Layer.TMS(
        "Contours (RGBA)",
        "tiles_contours/",
        {
            type:'png', getURL:osm_getTileURL,
            displayOutsideMaxExtent:true, isBaseLayer:false,
            transparent:true, opacity:0.8, "visibility":false
        }
    );
    var contours_8 = new OpenLayers.Layer.TMS(
        "Contours (limited area only)",
        "http://toolserver.org/~cmarqu/opentiles.com/cmarqu/tiles_contours_8/",
        {
            type:'png', getURL:osm_getTileURL,
            displayOutsideMaxExtent:true, isBaseLayer:false,
            transparent:true, opacity:0.8, "visibility":false
        }
    );

    var hill = new OpenLayers.Layer.TMS(
        "Hillshading (NASA SRTM3 v2)",
        "http://toolserver.org/~cmarqu/hill/",
        {
            type:'png', getURL:osm_getTileURL,
            displayOutsideMaxExtent:true, isBaseLayer:false,
            transparent:true, "visibility":true
        }
    );

    var hill2 = new OpenLayers.Layer.TMS(
        "Hillshading (exaggerate)",
        "http://toolserver.org/~cmarqu/hill/",
        {
            type:'png', getURL:osm_getTileURL,
            displayOutsideMaxExtent:true, isBaseLayer:false,
            transparent:true, "visibility":false
        }
    );

    var lighting_8 = new OpenLayers.Layer.TMS(
        "By Night (lit=yes/no)",
        "http://toolserver.org/tiles/lighting/",
        {
            type:'png', getURL:osm_getTileURL,
            displayOutsideMaxExtent:true, isBaseLayer:false,
            transparent:true, opacity:0.72, "visibility":false
        }
    );

    var lighting_residential = new OpenLayers.Layer.TMS(
        "By Night (lit+residential, Thuringia+Saxony)",
        "http://toolserver.org/~cmarqu/opentiles.com/cmarqu/tiles_lighting_residential/",
        {
            type:'png', getURL:osm_getTileURL,
            displayOutsideMaxExtent:true, isBaseLayer:false,
            transparent:true, opacity:0.72, "visibility":false
        }
    );

    var lonvia = new OpenLayers.Layer.TMS(
        "Lonvia's Hiking Symbols",
        "http://tile.lonvia.de/hiking/",
        {
            type:'png', getURL:osm_getTileURL,
            displayOutsideMaxExtent:true, isBaseLayer:false,
            transparent:true, "visibility":false
        }
    );


    map.addLayers([ hikebike, osm, cycle, osma ]);

    map.addLayer(hill);
    map.addLayer(hill2);
    map.addLayer(lighting_8);
    map.addLayer(lonvia);
// hide contour lines from IE since they look very ugly in it
    if (navigator.appName.indexOf("Explorer") != -1) {
    }
    else {
        map.addLayer(contours_8);
    }


    style = {
        strokeColor:'#2B2B2B',
        strokeOpacity:1,
        strokeWidth:2
    };
    var mapextent = new OpenLayers.Bounds(minLong, maxLat, maxLong, minLat).transform(WGS84, map.getProjectionObject());
    map.zoomToExtent(mapextent);
    lineLayer = new OpenLayers.Layer.Vector("Line Layer");
    lineFeature = new OpenLayers.Feature.Vector(new OpenLayers.Geometry.LineString(points), null, style);
    lineLayer.addFeatures([lineFeature]);
    map.addLayer(lineLayer);
    controls = map.getControlsByClass('OpenLayers.Control.Navigation');

    if (zoomControl != true) {
        for (var i = 0; i < controls.length; ++i) {
            controls[i].disableZoomWheel();
        }
    }

}