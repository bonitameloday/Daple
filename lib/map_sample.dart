import 'dart:async';
import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_map/models/auto_complete_result.dart';
import 'package:google_map/providers/search_places.dart';
import 'package:google_map/services/map_services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'dart:ui' as ui;

import 'dart:async';
import 'dart:ffi';
import 'dart:typed_data';

import 'package:flutter/services.dart';

class MapSample extends ConsumerStatefulWidget {
  const MapSample({Key? key}) : super(key: key);

  @override
  _MapSampleState createState() => _MapSampleState();
}

class _MapSampleState extends ConsumerState<MapSample> {
  Completer<GoogleMapController> _controller = Completer();

  //Debounce throttle async calls during search
  Timer? _debounce;

  //Toggling UI as we need;
  bool searchToggle = false;
  bool radiusSlider = false;
  bool pressedNear = false;
  bool cardTapped = false;
  bool getDirections = false;

  //Markers set
  Set<Marker> _markers = Set<Marker>();

  //Text Editing Controllers
  TextEditingController searchController = TextEditingController();

  //Initial map position on load

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(36.5, 127.5),
    zoom: 7,
  );

  int markerIdCounter = 0; // 이 부분 추가
  void _setMarker(point) {
    var counter = markerIdCounter++;

    final Marker marker = Marker(markerId: MarkerId('marker_$counter'),
        position: point,
        onTap: () {},
        icon: BitmapDescriptor.defaultMarker
    );

    setState(() {
      _markers.add(marker);
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery
        .of(context)
        .size
        .height;
    final screenWidth = MediaQuery
        .of(context)
        .size
        .width;

    //Providers
    final allSearchResults = ref.watch(placeResultsProvider);
    final searchFlag = ref.watch(searchToggleProvider);

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: screenHeight,
                  width: screenWidth,
                  child: GoogleMap(
                    mapType: MapType.normal,
                    markers: _markers,
                    initialCameraPosition: _kGooglePlex,
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);
                    },
                  ),
                ),
                searchToggle ?
                Padding(padding: EdgeInsets.fromLTRB(15.0, 40.0, 15.0, 5.0),
                  child: Column(
                      children: [
                        Container(
                          height: 50.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white,
                          ),
                          child: TextFormField(
                            controller: searchController,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 15.0
                                ),
                                border: InputBorder.none,
                                hintText: 'Search',
                                suffixIcon: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        searchToggle = false;
                                        searchController.text = '';
                                        _markers = {};
                                        searchFlag.toggleSearch();
                                      });
                                    },
                                    icon: Icon(Icons.close))),
                            onChanged: (value) {
                              if (_debounce?.isActive ?? false)
                                _debounce?.cancel();
                              _debounce = Timer(
                                  Duration(milliseconds: 700), () async {
                                if (value.length > 2) {
                                  if (!searchFlag.searchToggle) {
                                    searchFlag.toggleSearch();
                                    _markers = {};
                                  }

                                  List<AutoCompleteResult> searchResults =
                                  await MapServices().searchPlaces(value);


                                  allSearchResults.setResults(searchResults);
                                } else {
                                  List<AutoCompleteResult> emptyList = [];
                                  allSearchResults.setResults(emptyList);
                                }
                              });
                            },
                          ),
                        )
                      ]),
                )
                    : Container(),
                searchFlag.searchToggle ?
                allSearchResults.allReturnResults.length != 0 ?
                Positioned(
                    top: 100.0,
                    left: 15.0,
                    child: Container(
                      height: 200.0,
                      width: screenWidth - 30.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white.withOpacity(0.7),
                      ),
                      child: ListView(
                        children: [
                          ...allSearchResults.allReturnResults.map((e) =>
                              buildListItem(e, searchFlag))
                        ],
                      ),
                    )) :
                Positioned(
                    top: 100.0,
                    left: 15.0,
                    child: Container(
                      height: 200.0,
                      width: screenWidth - 30.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.white.withOpacity(0.7),
                      ),
                      child: Center(
                        child: Column(
                            children: [
                              Text('No results to show', style: TextStyle(
                                  fontFamily: 'WorkSans',
                                  fontWeight: FontWeight.w400)),
                              SizedBox(height: 5.0),
                              Container(
                                width: 125.0,
                                child: ElevatedButton(
                                  onPressed: () {
                                    searchFlag.toggleSearch();
                                  },
                                  child: Center(
                                    child: Text(
                                      'Close this',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'WorkSans',
                                          fontWeight: FontWeight.w300),
                                    ),
                                  ),
                                ),
                              )
                            ]
                        ),
                      ),
                    )) : Container()
              ],
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.search),
        backgroundColor: Colors.lightGreen,
        foregroundColor: Colors.white,
        onPressed: () {
          setState(() {
            searchToggle = true;
            radiusSlider = false;
            pressedNear = false;
            cardTapped = false;
            getDirections = false;
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat, // 원하는 위치로 설정
    );
  }

  Future<void> gotoSearchedPlace(double lat, double lng) async{
    final GoogleMapController controller = await _controller.future;

    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 12)));

    _setMarker(LatLng(lat, lng));
  }

  Widget buildListItem(AutoCompleteResult placeItem, searchFlag) {
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: GestureDetector(
          onTapDown: (_) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          onTap: () async{
            var place = await MapServices().getPlace(placeItem.placeId);
            gotoSearchedPlace(place['geometry']['location']['lat'],
                place['geometry']['location']['lng']);
            searchFlag.toggleSearch(); //taggleSearch() ->toggleSearch()로 수정
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.location_on, color: Colors.green, size: 25.0),
              SizedBox(width: 4.0),
              Container(
                height: 40.0,
                width: MediaQuery.of(context).size.width - 75.0,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(placeItem.description ?? ''),
                ),
              )
            ],
          )
      ),
    );
  }
}
