import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController _opening = TextEditingController();
  final TextEditingController _closing = TextEditingController();
  final TextEditingController _pinlab = TextEditingController();
  final TextEditingController _onlinePayment = TextEditingController();
  double opvalue = 0;
  double Clovalue = 0;
  double pinevalue = 0;
  double price = 96.45;

  double petrolUsed = 0.0;
  double cashAvailable = 0.0;

  void _calculatePetrolAndCash() {
    // Parse values from text controllers
    double openingMeter = double.tryParse(_opening.text) ?? 0;
    double closingMeter = double.tryParse(_closing.text) ?? 0;
    double pinlabValue = double.tryParse(_pinlab.text) ?? 0;
    double onlinePaymentValue = double.tryParse(_onlinePayment.text) ?? 0;

    // Check if opening meter is less than closing meter
    if (openingMeter < closingMeter) {
      // Calculate petrol used
      petrolUsed = closingMeter - openingMeter;

      // Calculate cash available
      cashAvailable = (petrolUsed * price) - pinlabValue - onlinePaymentValue;

      // Update UI if needed
      setState(() {});
    } else {
      // Show an error message or handle the case where opening meter is not less than closing meter
      // You can display a snackbar or set an error message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Opening meter must be less than closing meter'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        drawer: Drawer(
          child: Column(
            children: [
              Container(
                height: 50,
                width: 320,
                color: Colors.amber,
              ),
            ],
          ),
        ),
        appBar: AppBar(
          flexibleSpace: const Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.water_drop,
                  color: Color.fromRGBO(253, 147, 70, 1),
                  size: 25,
                ),
                Text(
                  'Petroli',
                  style: TextStyle(
                      fontFamily: 'Oswald',
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                      color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            SizedBox(
              height: 5,
            ),
            Container(
              height: 50,
              width: 320,
              color: Colors.red,
            ),
            Placeholder(
              fallbackHeight: 120,
            ),
            Placeholder(
              fallbackHeight: 50,
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Opening :',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: _opening,
                      decoration: InputDecoration(
                        hintText: 'Enter Opening Meter',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Closing :',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: _closing,
                      decoration: InputDecoration(
                        hintText: 'Enter Closing Meter',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Pinelab :',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: _pinlab,
                      decoration: InputDecoration(
                        hintText: 'Enter Pinelab Value',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Online Payment :',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: _onlinePayment,
                      decoration: InputDecoration(
                        hintText: 'Enter Online Payment',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    _calculatePetrolAndCash();
                  },
                  child: Text('Enter'),
                ),
                SizedBox(
                  width: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    // Clear all fields
                    _opening.clear();
                    _closing.clear();
                    _pinlab.clear();
                    _onlinePayment.clear();

                    // Clear calculated values
                    petrolUsed = 0.0;
                    cashAvailable = 0.0;

                    // Update UI
                    setState(() {});
                  },
                  child: Text('Clear All'),
                ),
              ],
            ),
            // Display calculated values
            SizedBox(height: 20),
            Text('Petrol Used: ${petrolUsed.toStringAsFixed(2)} liters'),
            Text('Cash Available: ₹${cashAvailable.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }
}
