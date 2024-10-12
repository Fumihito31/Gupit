import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:gupit/Provider/map_data_provider.dart';
import 'package:gupit/screens/AppointmentScreen.dart';
import 'package:gupit/screens/bookingScreen.dart';
import 'package:gupit/screens/mapScreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<MapDataProvider>(
            create: (_) => MapDataProvider()),
      ],
      child: MaterialApp(
        title: "Barber App",
        theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.blueGrey[900],
          hintColor: Colors.cyan[600],
          textTheme: TextTheme(
            displayLarge: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
                color: Colors.white),
            displayMedium: TextStyle(fontSize: 20.0, fontWeight: FontWeight.normal),
            titleLarge: TextStyle(fontSize: 20.0, fontStyle: FontStyle.normal),
            bodyMedium: TextStyle(
              fontSize: 14.0,
            ),
          ),
        ),
        routes: {
          '/bookingScreen': (context) => BookingScreen(),
          '/mappage': (context) => Mappage(),
          '/appointmentScreen': (context) => AppointmentScreen(),
        },
        home: SplashScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {
  Widget defaultPage = Container();

  void checkSharedPrefs() async {
    var sharedPrefs = await SharedPreferences.getInstance();
    if (!sharedPrefs.containsKey("firstTime")) {
      // Navigate to onboarding screen if it's the first time
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (BuildContext context) => OnboardingScreen(),
        ),
      );
    } else {
      // Load the default page
      defaultPage = Container();
    }
  }

  @override
  void initState() {
    super.initState();
    checkSharedPrefs();
    Timer(Duration(seconds: 4), () {
      Navigator.of(context).pushReplacementNamed('/appointmentScreen');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            "assets/splash_screen.gif",
            height: (60 / 100) * MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
          ),
          CircularProgressIndicator(
            strokeWidth: 4,
            backgroundColor: Colors.amberAccent[400],
          )
        ],
      ),
    );
  }
}

class ServiceBody extends StatefulWidget {
  @override
  _ServiceBodyState createState() => _ServiceBodyState();
}

class _ServiceBodyState extends State<ServiceBody> {
  int _amount = 0;
  int _quantity = 0;
  bool _booking = false;

  static Map<String, int> haircuts = {
    'Basic Haircut': 100,
    'Fade Haircut': 140,
    'Beard Trimming': 80,
    'French Beard': 120,
    'Afro Haircut': 300
  };
  List<bool> _check = List.generate(haircuts.length, (index) => false);

  void updateBookingStatus() {
    setState(() {
      _booking = _check.any((selected) => selected);
      _quantity = _check.where((selected) => selected).length;
      _amount = _check.asMap().entries.fold(0, (sum, entry) {
        if (entry.value) {
          sum += haircuts[haircuts.keys.toList()[entry.key]]!;
        }
        return sum;
      });
    });
  }

  Widget haircutPrice(String name, int price, int index) {
    return Column(
      children: <Widget>[
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Row(
            children: <Widget>[
              InkWell(
                onTap: () {
                  setState(() {
                    _check[index] = !_check[index];
                    updateBookingStatus();
                  });
                },
                child: Container(
                  height: 26,
                  width: 26,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: _check[index] ? Colors.blue : Colors.white38,
                    borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  ),
                  child: Icon(
                    _check[index] ? Icons.clear : Icons.add,
                    size: 26.0,
                    color: _check[index] ? Colors.white : Colors.black,
                  ),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Text(
                  name,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Text(
                '\u20B9 $price',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          for (int i = 0; i < haircuts.length; i++)
            haircutPrice(
              haircuts.keys.elementAt(i),
              haircuts[haircuts.keys.elementAt(i)]!,
              i,
            ),
          SizedBox(height: 20),
          Container(
            height: 65,
            color: Colors.white38,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Center(
                  child: Text(
                    '$_quantity item selected',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: _booking ? Colors.white : Colors.white54,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (_booking) {
                      print('Total amount: $_amount');
                      // Uncomment below line to navigate to booking screen
                      // Navigator.pushNamed(context, '/bookingScreen');
                    }
                  },
                  child: Card(
                    color: _booking ? Colors.blue : Colors.grey[850],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0))),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(38, 8, 38, 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Text(
                            'Book',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: _booking ? Colors.white : Colors.white54),
                          ),
                          Text(
                            'Now',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: _booking ? Colors.white : Colors.white54),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// Create your OnboardingScreen widget here
class OnboardingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Welcome to the Barber App!"),
      ),
    );
  }
}
