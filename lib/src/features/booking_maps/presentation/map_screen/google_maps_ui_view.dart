import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MyGoogleMapUIView extends StatefulWidget {
  const MyGoogleMapUIView({Key? key}) : super(key: key);

  @override
  State<MyGoogleMapUIView> createState() => _MyGoogleMapUIViewState();
}

class _MyGoogleMapUIViewState extends State<MyGoogleMapUIView> {
  Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(27.049302, 33.900214),
    zoom: 14,
  );

  List<Marker> _marker = [];
  final List<Marker> _list = const [
    Marker(
      markerId: MarkerId('1'),
      position: LatLng(27.049302, 33.900214),
      infoWindow: InfoWindow(title: "Hotel Name"),
    ),
    Marker(
      markerId: MarkerId('2'),
      position: LatLng(27.049302, 33.900214),
      infoWindow: InfoWindow(title: "Hotel Name"),
    ),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _marker.addAll(_list);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        Size(constraints.maxWidth, constraints.maxHeight);
        return GoogleMap(
          initialCameraPosition: _kGooglePlex,
          markers: Set<Marker>.of(_marker),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        );
      },
    );
  }
}
