import 'package:flutter/material.dart';

class AppointmentScreen extends StatefulWidget {
  @override
  _AppointmentScreenState createState() => _AppointmentScreenState();
}

class _AppointmentScreenState extends State<AppointmentScreen> {
  final List<String> availableTimings = ['09:00 AM', '10:00 AM', '11:00 AM', '12:00 PM', '01:00 PM'];
  final List<Map<String, dynamic>> services = [
    {'name': 'Afro Haircut', 'price': 300},
    {'name': 'Beard Trim', 'price': 150},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.orangeAccent[100],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Appointment"),
        centerTitle: true,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
          IconButton(icon: Icon(Icons.sort), onPressed: () {}),
        ],
      ),
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildUserCard(),
                buildAvailableTimings(),
                buildServices(),
                buildWhomToBook(),
              ],
            ),
          ),
          buildUserAvatar(),
        ],
      ),
    );
  }

  Widget buildUserCard() {
    return Card(
      elevation: 10,
      color: Colors.orangeAccent[100],
      margin: EdgeInsets.all(0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              buildUserInfo(),
              SizedBox(width: 50),
              IconButton(icon: Icon(Icons.share), onPressed: () {}),
              IconButton(icon: Icon(Icons.favorite), onPressed: () {}),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildUserInfo() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: <Widget>[
            Text("John Doe", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Icon(Icons.done, size: 15),
          ],
        ),
        SizedBox(height: 5),
        Text("Thane, India", style: TextStyle(fontSize: 14)),
        SizedBox(height: 5),
        Row(
          children: List.generate(5, (index) => Icon(Icons.star, size: 17)),
        ),
        SizedBox(height: 7),
      ],
    );
  }

  Widget buildAvailableTimings() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 40),
          Text("Available Timings", style: TextStyle(color: Colors.black54, fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          Container(width: 55, color: Colors.black54, height: 3),
          SizedBox(height: 20),
          Container(
            height: 110,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: availableTimings.length,
              itemBuilder: (context, index) {
                return buildTimingCard(availableTimings[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTimingCard(String time) {
    return Stack(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(height: 110, width: 110),
        ),
        Container(
          height: 110,
          width: 90,
          decoration: BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.circular(25),
          ),
        ),
        Container(
          height: 110,
          width: 90,
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(time.split(' ')[0], style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500)),
              Text(time.split(' ')[1], style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500)),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildServices() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(height: 20),
          Text("Services", style: TextStyle(color: Colors.black54, fontSize: 20, fontWeight: FontWeight.bold)),
          SizedBox(height: 5),
          Container(width: 55, color: Colors.black54, height: 3),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.fromLTRB(8, 4, 8, 2),
            child: Column(
              children: services.map((service) => buildServiceRow(service)).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildServiceRow(Map<String, dynamic> service) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(service['name'], style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.w600)),
        Text("\u20B9 ${service['price']}", style: TextStyle(color: Colors.grey, fontSize: 18, fontWeight: FontWeight.w600)),
      ],
    );
  }

  Widget buildWhomToBook() {
    return Divider(height: 15, color: Colors.grey);
  }

  Widget buildUserAvatar() {
    return Positioned(
      left: 25,
      top: 20,
      child: CircleAvatar(
        backgroundColor: Colors.white,
        radius: 55.0,
        child: CircleAvatar(
          radius: 48,
          backgroundImage: AssetImage('lib/assets/gelo.jpg'),
        ),
      ),
    );
  }
}
