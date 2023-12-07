import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  final TextEditingController _depositCash = TextEditingController();

  double petrolUsed = 0.0;
  double cashAvailable = 0.0;
  double price = 96.45; // Initial petrol price

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

  void _updatePetrolPrice() {
    showDialog(
      context: context,
      builder: (context) {
        TextEditingController _newPriceController = TextEditingController();

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Container(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Update Petrol Price',
                  style: TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextField(
                  controller: _newPriceController,
                  keyboardType: TextInputType.numberWithOptions(decimal: true),
                  decoration: const InputDecoration(
                    hintText: 'Enter new petrol price',
                  ),
                ),
                SizedBox(height: 20.0), // Increase the height as needed
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
                      onPressed: () {
                        // Update petrol price from the dialog
                        price =
                            double.tryParse(_newPriceController.text) ?? price;

                        // Clear the new petrol price text field
                        _newPriceController.clear();

                        // Update UI
                        setState(() {});

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
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            Container(
              height: 50,
              width: 320,
              color: Colors.red,
            ),
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
            Container(
              child: Padding(
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
                    const Text(
                      'Opening Meter:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: _opening,
                      keyboardType: TextInputType.number,
                      inputFormatters: [LengthLimitingTextInputFormatter(10)],
                      decoration: InputDecoration(
                        hintText: 'Enter Opening Meter',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      focusNode: _openingFocusNode,
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(_closingFocusNode);
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'Closing Meter:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: _closing,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [LengthLimitingTextInputFormatter(10)],
                      decoration: InputDecoration(
                        hintText: 'Enter Closing Meter',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      focusNode: _closingFocusNode,
                      onEditingComplete: () {
                        FocusScope.of(context).requestFocus(_pinlabFocusNode);
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'Pinelab Value:',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: _pinlab,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        hintText: 'Enter Pinelab Value',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      focusNode: _pinlabFocusNode,
                      onEditingComplete: () {
                        FocusScope.of(context)
                            .requestFocus(_onlinePaymentFocusNode);
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'Online Payment :',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: _onlinePayment,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        hintText: 'Enter Online Payment',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      focusNode: _onlinePaymentFocusNode,
                      onEditingComplete: () {
                        FocusScope.of(context)
                            .requestFocus(_depositCashFocusNode);
                      },
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const Text(
                      'Deposit Cash :',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: _depositCash,
                      keyboardType:
                          TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        hintText: 'Enter Deposit Cash',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      focusNode: _depositCashFocusNode,
                      onEditingComplete: _calculatePetrolAndCash,
                    ),
                  ],
                ),
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
                SizedBox(
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
