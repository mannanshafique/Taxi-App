import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Taxi App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomepage(),
    );
  }
}

class MyHomepage extends StatefulWidget {
  @override
  _MyHomepageState createState() => _MyHomepageState();
}

class _MyHomepageState extends State<MyHomepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Maps());
  }
}

class Maps extends StatefulWidget {
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  GoogleMapController mapController; //mutli uses where re you
  static const _initalPostion = LatLng(37.3774, -122.0730);
  LatLng _lastPosition = _initalPostion;

  //set bound us to not repeat object means here use for bound location repeating
  final Set<Marker> _markers = {};

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GoogleMap(
          initialCameraPosition:
              CameraPosition(target: _initalPostion, zoom: 10),
          mapType: MapType.normal, // map kis taran ka dekay
          onMapCreated: onCreated,
          myLocationEnabled: true,
          compassEnabled: true,
          markers: _markers,
          onCameraMove: _onCameraMove,
        ),
        // Positioned(
        //     top: 40,
        //     right: 10,
        //     child: FloatingActionButton(
        //       onPressed: _onAddMarkerPressed,
        //       tooltip: "Add Marker",
        //       backgroundColor: black,
        //       child: Icon(
        //         Icons.add_location,
        //         color: white,
        //       ),
        //     )
        //     )
      ],
    );
  }

  void onCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  void _onCameraMove(CameraPosition position) {
    _lastPosition = position.target;
  }

  void _onAddMarkerPressed() {
    setState(() {
      _markers.add(Marker(
          markerId: MarkerId(_lastPosition.toString()),
          position: _lastPosition,
          infoWindow:
              InfoWindow(title: "Current Location", snippet: "good place"),
          icon: BitmapDescriptor.defaultMarker));
    });
  }
}
