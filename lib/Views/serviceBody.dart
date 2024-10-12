import 'package:flutter/material.dart';

class ServiceBody extends StatefulWidget {
  @override
  _ServiceBodyState createState() => _ServiceBodyState();
}

class _ServiceBodyState extends State<ServiceBody> {
  int _totalAmount = 0;
  bool _isBooking = false;

  static const Map<String, int> haircuts = {
    'Basic Haircut': 100,
    'Fade Haircut': 140,
    'Beard Trimming': 80,
    'French Beard': 120,
    'Afro Haircut': 300,
  };

  List<bool> _selectedHaircuts = List.filled(haircuts.length, false);

  Widget haircutPrice(String name, int price, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
      child: Row(
        children: <Widget>[
          InkWell(
            onTap: () {
              setState(() {
                _selectedHaircuts[index] = !_selectedHaircuts[index];
                _isBooking = _selectedHaircuts.contains(true);
              });
            },
            child: Container(
              height: 26,
              width: 26,
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                color: _selectedHaircuts[index] ? Colors.blue : Colors.white38,
                borderRadius: BorderRadius.circular(5.0),
              ),
              child: Icon(
                _selectedHaircuts[index] ? Icons.clear : Icons.add,
                size: 26.0,
                color: _selectedHaircuts[index] ? Colors.white : Colors.black,
              ),
            ),
          ),
          const SizedBox(width: 20),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        children: <Widget>[
          ...haircuts.entries.map((entry) {
            int index = haircuts.keys.toList().indexOf(entry.key);
            return haircutPrice(entry.key, entry.value, index);
          }).toList(),
          const SizedBox(height: 20),
          Container(
            height: 65,
            color: Colors.white38,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                const SizedBox(width: 10),
                Center(
                  child: Text(
                    '${_selectedHaircuts.where((selected) => selected).length} item(s) selected',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: _isBooking ? Colors.white : Colors.white54,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (_isBooking) {
                      _totalAmount = _selectedHaircuts
                          .asMap()
                          .entries
                          .where((entry) => entry.value)
                          .map((entry) => haircuts.values.elementAt(entry.key))
                          .fold(0, (prev, amount) => prev + amount);
                      print('Total Amount: $_totalAmount');
                      // Navigate to appointment screen
                      // Navigator.push(context, 'appointmentScreen');
                    }
                  },
                  child: Card(
                    color: _isBooking ? Colors.blue : Colors.grey[850],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
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
                              color: _isBooking ? Colors.white : Colors.white54,
                            ),
                          ),
                          Text(
                            'Now',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: _isBooking ? Colors.white : Colors.white54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
