import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void defaultclick() {
  print("defaulrt Clicked");
}

void Function() markercallback = defaultclick;

class mapviewPage extends StatelessWidget {
  static final Marker _scanner1 = Marker(
      markerId: MarkerId("Scanner ABC"),
      //infoWindow: InfoWindow(title: "Brother Doc Scanner"),
      icon: BitmapDescriptor.defaultMarker,
      onTap: markercallback,
      position: LatLng(37.43244206476937, -122.08794244139939));

  @override
  Widget build(BuildContext context) {
    void clickMarker() {
      print("marker Clicked");
      Navigator.of(context).pushNamed('/scannerinfo');
    }

    markercallback = clickMarker;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text('Near By Document Scanners'),
      ),
      body: GoogleMap(
        mapType: MapType.normal,
        markers: {_scanner1},
        initialCameraPosition: CameraPosition(
          target: LatLng(37.42796133580664, -122.085749655962),
          zoom: 14.4746,
        ),
      ),
    );
  }

  Center Centercontent(BuildContext context) {
    return Center(
      child: ElevatedButton(
        //color: Colors.blue,
        child: const Text('Scanner Info'),
        onPressed: () {
          Navigator.of(context).pushNamed('/scannerinfo');
        },
      ),
    );
  }
}
