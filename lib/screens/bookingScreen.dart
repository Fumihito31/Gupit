import '../Views/gallerbody.dart';
import 'package:flutter/material.dart';
import '../Views/serviceBody.dart';

class BookingScreen extends StatefulWidget {
  @override
  _BookingScreenState createState() => _BookingScreenState();
}

class _BookingScreenState extends State<BookingScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 3);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          // Load the image from the assets instead of network
          Image.asset(
            'lib/assets/gelo.jpg',
            fit: BoxFit.cover,
          ),
          Scaffold(
            appBar: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  SizedBox(width: 50),
                  Text("Booking", style: Theme.of(context).textTheme.titleLarge),
                  IconButton(
                    icon: Icon(Icons.notifications),
                    onPressed: () {},
                  ),
                ],
              ),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              ),
            ),
            body: ListView(
              children: <Widget>[
                _buildProfileCard(),
                _buildTabBar(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard() {
    return Card(
      margin: EdgeInsets.fromLTRB(40, 20, 40, 30),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
      color: Theme.of(context).primaryColor,
      elevation: 10,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 50, 0, 10),
        child: Column(
          children: <Widget>[
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 48.0,
              child: CircleAvatar(
                radius: 40,
                // Load the image from the assets instead of network
                backgroundImage: AssetImage('lib/assets/gelo.jpg'), // Change here
              ),
            ),
            SizedBox(height: 7),
            Text('John Doe', style: Theme.of(context).textTheme.displayLarge),
            SizedBox(height: 7),
            Text('Thane', style: Theme.of(context).textTheme.displayMedium),
          ],
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.circular(40.0), topLeft: Radius.circular(40.0)),
        color: Theme.of(context).primaryColor,
      ),
      child: Scaffold(
        appBar: AppBar(
          title: TabBar(
            controller: _tabController,
            indicatorColor: Colors.white,
            tabs: <Widget>[
              Tab(child: Text("Services", style: TextStyle(fontSize: 20))),
              Tab(child: Text("Gallery", style: TextStyle(fontSize: 20))),
              Tab(child: Text("Reviews", style: TextStyle(fontSize: 20))),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            ServiceBody(),
            GalleryBody(),
            Container(child: Text("hello")),
          ],
        ),
      ),
    );
  }
}
