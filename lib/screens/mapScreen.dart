import 'package:gupit/Provider/map_data_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Mappage extends StatefulWidget {
  @override
  _MappageState createState() => _MappageState();
}

class _MappageState extends State<Mappage> {
  bool loading = true;
  late MapDataProvider mapDataProvider;

  @override
  void initState() {
    super.initState();
    // Load data when the widget is initialized
    getData();
  }

  void getData() async {
    mapDataProvider = Provider.of<MapDataProvider>(context, listen: false);
    await mapDataProvider.loadData(); // Ensure this method does not return anything
    setState(() {
      loading = false; // Set loading to false after the data loading completes
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: loading
            ? Center(child: CupertinoActivityIndicator())
            : MappageBody(mapDataProvider), // Updated reference here
      ),
    );
  }
}

// ignore: must_be_immutable
class MappageBody extends StatefulWidget { // Updated class name here
  final MapDataProvider mapDataProvider;

  MappageBody(this.mapDataProvider); // Updated constructor name

  @override
  _MappageBodyState createState() => _MappageBodyState(mapDataProvider); // Updated state class name
}

class _MappageBodyState extends State<MappageBody> { // Updated state class name here
  final MapDataProvider mapDataProvider;
  PanelController panelController = PanelController();
  MapType mapType = MapType.normal;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  // Default camera position
  CameraPosition initialCameraPosition = const CameraPosition(
    target: LatLng(12.922270, 77.584290),
    zoom: 16.0,
  );

  BorderRadiusGeometry radius = BorderRadius.only(
    topLeft: Radius.circular(24.0),
    topRight: Radius.circular(24.0),
  );

  _MappageBodyState(this.mapDataProvider); // Updated constructor name

  @override
  Widget build(BuildContext context) {
    return SlidingUpPanel(
      controller: panelController,
      color: Colors.blueGrey,
      backdropEnabled: true,
      backdropColor: Colors.transparent,
      backdropOpacity: 0,
      maxHeight: MediaQuery.of(context).devicePixelRatio * 150,
      borderRadius: radius,
      collapsed: _buildCollapsedPanel(),
      panel: _buildExpandedPanel(),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            mapToolbarEnabled: false,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: false,
            mapType: mapType,
            markers: Set<Marker>.of(markers.values),
            initialCameraPosition: initialCameraPosition,
            onMapCreated: _onMapCreated,
          ),
          _buildFloatingActionButtons(),
          _buildMenuButton(),
        ],
      ),
    );
  }

  Widget _buildCollapsedPanel() {
    return InkWell(
      onTap: () {
        panelController.open();
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(40.0),
            topLeft: Radius.circular(40.0),
          ),
          color: Colors.blueGrey[900],
        ),
        child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40.0),
                  topLeft: Radius.circular(40.0),
                ),
                color: Colors.purple,
              ),
              height: 10,
            ),
            _buildCollapsedHeader(),
          ],
        ),
      ),
    );
  }

  Widget _buildCollapsedHeader() {
    return Container(
      color: Colors.blueGrey[900],
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20),
            child: Icon(
              Icons.keyboard_arrow_up,
              color: Colors.white70,
              size: 30,
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "Explore Nearby",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              Text(
                "Barbers",
                style: TextStyle(color: Colors.white70),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildExpandedPanel() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(40.0),
              topLeft: Radius.circular(40.0),
            ),
            color: Colors.purple,
          ),
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: _buildPanelHeader(),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: _buildBarberList(),
          ),
        ),
      ],
    );
  }

  Widget _buildPanelHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          "Nearby Barbers",
          style: TextStyle(fontSize: 22, color: Colors.white),
        ),
        SizedBox(height: 10),
        Container(
          width: 120,
          color: Colors.white38,
          height: 4,
        ),
        SizedBox(height: 10),
        Container(
          width: 80,
          color: Colors.white38,
          height: 4,
        ),
      ],
    );
  }

  Widget _buildBarberList() {
    return ListView.builder(
      itemCount: mapDataProvider.mapDataList?.length ?? 0, // Conditional check for null
      itemBuilder: (BuildContext context, int index) {
        return _buildBarberCard(index);
      },
    );
  }

  Widget _buildBarberCard(int index) {
    return Card(
      margin: EdgeInsets.only(bottom: 20),
      shadowColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      color: Colors.black,
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            CircleAvatar(
              radius: 25,
              backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1506794778202-cad84cf45f1d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1868&q=80'),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    mapDataProvider.mapDataList![index].name,
                    style: TextStyle(
                      fontSize: 23.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Thane', // Replace with actual location
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.normal,
                      color: Colors.white54,
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.white,
              size: 30,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingActionButtons() {
    return Positioned(
      bottom: 0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          _buildMapTypeButton(),
          SizedBox(height: 16),
          _buildCurrentLocationButton(),
        ],
      ),
    );
  }

  Widget _buildMapTypeButton() {
    return FloatingActionButton(
      onPressed: () {
        setState(() {
          mapType = mapType == MapType.normal ? MapType.satellite : MapType.normal;
        });
      },
      backgroundColor: Colors.purple,
      child: Icon(Icons.map),
    );
  }

  Widget _buildCurrentLocationButton() {
    return FloatingActionButton(
      onPressed: () {
        // Functionality to get user's current location
      },
      backgroundColor: Colors.purple,
      child: Icon(Icons.my_location),
    );
  }

  Widget _buildMenuButton() {
    return Positioned(
      top: 10,
      left: 10,
      child: IconButton(
        icon: Icon(Icons.menu, color: Colors.white),
        onPressed: () {
          // Menu functionality
        },
      ),
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    // Handle map creation logic here
  }
}
