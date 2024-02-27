import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:runn_app/screens/add_post_screen.dart';
import 'package:runn_app/utils/colors.dart';

import '../utils/utils.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  String displayedTime = '00:00:00';
  String displayedDistance = '0.00 meters';
  Timer? timer;
  DateTime? startTime;
  DateTime? endTime;
  double distance = 0;
  double? startLat;
  double? startLong;
  double? endLat;
  double? endLong;

  Future<Position> getuserlocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {});

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  loadStartData() {
    getuserlocation().then((value) async {
      _list.add(Marker(
        markerId: const MarkerId('1'),
        position: LatLng(value.latitude, value.longitude),
        infoWindow: const InfoWindow(title: 'Your start Position'),
      ));
      CameraPosition cameraPosition = CameraPosition(
        target: LatLng(value.latitude, value.longitude),
        zoom: 20,
        tilt: 60,
      );
      startLat = value.latitude;
      startLong = value.longitude;
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

      setState(() {});
      timer = Timer.periodic(const Duration(seconds: 1), (Timer t) {
        startTime ??= DateTime.now();
        updateTimer();
      });
    });
  }

  averagespeed(int distance, int time) {
    var speed = distance / time;
    return speed;
  }

  updateTimer() {
    if (startTime != null) {
      var duration = DateTime.now().difference(startTime!);
      var hours = duration.inHours;
      var minutes = duration.inMinutes.remainder(60);
      var seconds = duration.inSeconds.remainder(60);
      getuserlocation().then((value) async {
        CameraPosition cameraPosition = CameraPosition(
          target: LatLng(value.latitude, value.longitude),
          zoom: 20,
          tilt: 60,
        );
        final GoogleMapController controller = await _controller.future;
        controller
            .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
        setState(() {
          if (startLat != null && startLong != null) {
            var deltaDistance = Geolocator.distanceBetween(
                startLat!, startLong!, value.latitude, value.longitude);
            distance += deltaDistance;
          }
          startLat = value.latitude;
          startLong = value.longitude;
          displayedDistance = '${distance.toStringAsFixed(2)} meters';
          displayedTime = '$hours:$minutes:$seconds';
        });
      });
    }
  }

  loadEndData() {
    if (timer != null) {
      timer!.cancel();
    }
    endTime = DateTime.now();

    if (startTime != null) {
      var duration = endTime!.difference(startTime!);
      var hours = duration.inHours;
      var minutes = duration.inMinutes.remainder(60);
      var seconds = duration.inSeconds.remainder(60);

      getuserlocation().then((value) async {
        _list.add(Marker(
          markerId: const MarkerId('2'),
          position: LatLng(value.latitude, value.longitude),
          infoWindow: const InfoWindow(title: 'Your current Position'),
        ));
        CameraPosition cameraPosition = CameraPosition(
          target: LatLng(value.latitude, value.longitude),
          zoom: 20,
          tilt: 60,
        );
        endLat = value.latitude;
        endLong = value.longitude;
        final GoogleMapController controller = await _controller.future;
        controller
            .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

        setState(() {
          var deltaDistance = Geolocator.distanceBetween(
              startLat!, startLong!, endLat!, endLong!);
          distance += deltaDistance;
          displayedTime = '$hours:$minutes:$seconds';
          displayedDistance = '${distance.toStringAsFixed(2)} meters';
        });

        timer = null;
        startTime = null;
        distance = 0;
      });
    }
  }

  final List<Marker> _list = <Marker>[];

  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(33.658715, 73.157643),
    zoom: 5,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Material(
          elevation: 5,
          child: Container(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Home Screen',
                    style: TextStyle(
                      color: Color.fromARGB(255, 0, 0, 0),
                      fontSize: 22,
                    )),
              ),
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: appbarcolor),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.25,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.all(
                      MediaQuery.of(context).size.height * 0.02,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              displayedTime,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              "Duration",
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              displayedDistance,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              "Distance",
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  timer != null
                      ? Container()
                      : ElevatedButton(
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4),
                                side: const BorderSide(color: Colors.green),
                              ),
                            ),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.green),
                          ),
                          onPressed: () {
                            loadStartData();
                            timer == null;
                          },
                          child: const Text(
                            "Start Running",
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                ],
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: _kGooglePlex,
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                markers: Set<Marker>.of(_list),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            ),
            timer == null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                              side: const BorderSide(color: Colors.grey),
                            ),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.grey),
                        ),
                        onPressed: () {
                          setState(() {
                            _list.clear();
                            displayedTime = '00:00:00';
                            displayedDistance = '0.00 meters';
                          });
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Clear  ",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            Icon(Icons.cancel, color: Colors.white),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                              side: const BorderSide(color: Colors.blue),
                            ),
                          ),
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                        ),
                        onPressed: () {
                          if (displayedDistance == '0.00 meters' ||
                              displayedTime == '00:00:00') {
                            return showSnackBar(context, 'no data to share!');
                          }
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddPostScreen(
                                distnace: displayedDistance,
                                timetaken: displayedTime,
                              ),
                            ),
                          );
                        },
                        child: const Row(
                          children: [
                            Text(
                              "Share  ",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.white),
                            ),
                            Icon(Icons.share, color: Colors.white),
                          ],
                        ),
                      ),
                    ],
                  )
                : ElevatedButton(
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4),
                          side: const BorderSide(color: Colors.redAccent),
                        ),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.redAccent),
                    ),
                    onPressed: () {
                      loadEndData();
                    },
                    child: const Text(
                      "Stop Running",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
