import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:patroli/Componets/MyTextform.dart';
import 'package:patroli/ads_manger.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final TextEditingController _opening = TextEditingController();
  final TextEditingController _closing = TextEditingController();
  final TextEditingController _pinlab = TextEditingController();
  final TextEditingController _onlinePayment = TextEditingController();
  final TextEditingController _depositCash = TextEditingController();

  double petrolUsed = 0.0;
  double cashAvailable = 0.0;
  double price = 96.45; // Initial petrol price

  @override
  void initState() {
    super.initState();
    _loadPetrolPrice();
  }

  // Create FocusNode instances for each TextField
  final FocusNode _openingFocusNode = FocusNode();
  final FocusNode _closingFocusNode = FocusNode();
  final FocusNode _pinlabFocusNode = FocusNode();
  final FocusNode _onlinePaymentFocusNode = FocusNode();
  final FocusNode _depositCashFocusNode = FocusNode();

  @override
  void dispose() {
    // Dispose of the FocusNode instances when the widget is disposed
    _openingFocusNode.dispose();
    _closingFocusNode.dispose();
    _pinlabFocusNode.dispose();
    _onlinePaymentFocusNode.dispose();
    _depositCashFocusNode.dispose();
    super.dispose();
  }

  void _calculatePetrolAndCash() {
    // Check if any text field (except "Deposit Cash") is empty
    if (_opening.text.isEmpty ||
        _closing.text.isEmpty ||
        _pinlab.text.isEmpty ||
        _onlinePayment.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(
            'Please fill in all the required fields',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      );
      return;
    }

    // Parse values from text controllers
    double openingMeter = double.tryParse(_opening.text) ?? 0;
    double closingMeter = double.tryParse(_closing.text) ?? 0;
    double pinlabValue = double.tryParse(_pinlab.text) ?? 0;
    double onlinePaymentValue = double.tryParse(_onlinePayment.text) ?? 0;

    double depositCashValue = double.tryParse(_depositCash.text) ?? 0;

    // Check for suspicious data
    if (openingMeter < 0 ||
        closingMeter < 0 ||
        pinlabValue < 0 ||
        onlinePaymentValue < 0 ||
        depositCashValue < 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(
            'Please enter valid positive values',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      );
      return;
    }

    // Check if opening meter is less than closing meter
    if (openingMeter < closingMeter) {
      // Calculate petrol used
      petrolUsed = closingMeter - openingMeter;

      // Calculate cash available
      cashAvailable = (petrolUsed * price) -
          pinlabValue -
          onlinePaymentValue -
          depositCashValue;

      // Check for negative cash value
      if (cashAvailable < 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              'Calculated cash cannot be negative',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        );
        return;
      }

      // Update UI
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(
            'Opening meter must be less than closing meter',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      );
    }
  }

  // Loads the saved petrol price from SharedPreferences when the app starts.
  // Defaults to 96.45 if no price is found.
  Future<void> _loadPetrolPrice() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      price = prefs.getDouble('petrol_price') ?? 96.45;
    });
  }

  void _updatePetrolPrice() {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController newPriceController = TextEditingController();

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Update Petrol Price',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                const SizedBox(
                  height: 12,
                ),
                TextField(
                  controller: newPriceController,
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: true),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    hintText: 'Enter new petrol price',
                  ),
                ),
                const SizedBox(height: 20.0), // Increase the height as needed
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(color: Colors.redAccent),
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        // Update petrol price from the dialog
                        double? newPrice =
                            double.tryParse(newPriceController.text);
                        if (newPrice != null) {
                          setState(() {
                            price = newPrice;
                          });
                          // Save the new price to SharedPreferences.
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          await prefs.setDouble('petrol_price', price);
                        }

                        // Clear the new petrol price text field
                        newPriceController.clear();

                        // Close the dialog
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Update',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Center(
          child: SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/img/oil.png",
                  height: 30,
                ),
                const Text(
                  'Petrolin',
                  style: TextStyle(
                    fontFamily: 'Oswald',
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                'Petrolin',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // Handle settings tap
              },
            ),
            ListTile(
              leading: Icon(Icons.info_outline),
              title: Text('About'),
              onTap: () {
                // Handle about tap
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            MyBannerAdWidget(adSize: AdSize.banner), // Uncomment if needed
            const SizedBox(height: 15),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.water_drop,
                      color: Color.fromRGBO(253, 147, 70, 1),
                    ),
                    Text(
                      'Petrol : ${petrolUsed.toStringAsFixed(2)} ltr',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/img/dollar.png",
                      height: 25,
                      width: 25,
                    ),
                    const SizedBox(
                      width: 3,
                    ),
                    Text('Cash : ₹${cashAvailable.toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        )),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Text(
                        'Price :',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(width: 10),
                      GestureDetector(
                        onTap: _updatePetrolPrice,
                        child: Text(
                          '₹${price.toStringAsFixed(2)}',
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Opening Meter :',
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            CustomTextField(
                              controller: _opening,
                              hintText: 'Opening Meter',
                              keyboardType: TextInputType.number,
                              focusNode: _openingFocusNode,
                              nextFocusNode: _closingFocusNode,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Closing Meter :'),
                            SizedBox(
                              height: 5,
                            ),
                            CustomTextField(
                              controller: _closing,
                              hintText: 'Closing Meter',
                              keyboardType:
                                  const TextInputType.numberWithOptions(
                                      decimal: true),
                              focusNode: _closingFocusNode,
                              nextFocusNode: _pinlabFocusNode,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  Text('Total Card Value :'),
                  const SizedBox(height: 5),
                  CustomTextField(
                    controller: _pinlab,
                    hintText: 'Card Value',
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    focusNode: _pinlabFocusNode,
                    nextFocusNode: _onlinePaymentFocusNode,
                  ),
                  const SizedBox(height: 10),
                  Text('Online Payment :'),
                  const SizedBox(height: 5),
                  CustomTextField(
                    controller: _onlinePayment,
                    hintText: 'Online Payment',
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    focusNode: _onlinePaymentFocusNode,
                    nextFocusNode: _depositCashFocusNode,
                  ),
                  const SizedBox(height: 10),
                  Text('Deposit Cash :'),
                  const SizedBox(height: 5),
                  CustomTextField(
                    controller: _depositCash,
                    hintText: 'Deposit Cash',
                    keyboardType:
                        const TextInputType.numberWithOptions(decimal: true),
                    focusNode: _depositCashFocusNode,
                    onEditingComplete: _calculatePetrolAndCash,
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _calculatePetrolAndCash,
                  child: const Text('Enter'),
                ),
                const SizedBox(
                  width: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    _opening.clear();
                    _closing.clear();
                    _pinlab.clear();
                    _onlinePayment.clear();
                    _depositCash.clear();
                    petrolUsed = 0.0;
                    cashAvailable = 0.0;
                    setState(() {});
                  },
                  child: const Text('Clear All'),
                ),
              ],
            ),
            const SizedBox(height: 25),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Made By : Bir Mehto",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black38,
                  ),
                ),
                const SizedBox(
                  width: 5,
                ),
                Image.asset(
                  "assets/img/india.png",
                  height: 20,
                ),
                const SizedBox(
                  height: 40,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
