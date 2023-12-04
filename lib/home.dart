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
  double opvalue = 0;
  double Clovalue = 0;
  double pinevalue = 0;
  double price = 96.45;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        // backgroundColor: ColorSwatch(primary, context),
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

              // strokeWidth: double.infinity,
            ),
            Placeholder(
              fallbackHeight: 50,
              // strokeWidth: double.infinity,
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
                          )),
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
                          )),
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
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: _closing,
                      decoration: InputDecoration(
                          hintText: 'Enter Closing Meter',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          )),
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
                      controller: _pinlab,
                      decoration: InputDecoration(
                          hintText: 'Enter Online Payment',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                          )),
                    ),
                  ],
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {},
                    child: Text(
                      'Enter',
                    )),
                SizedBox(
                  width: 30,
                ),
                ElevatedButton(onPressed: () {}, child: Text('Clear All')),
              ],
            )
          ],
        ),
      ),
    );
  }
}

class Calculation {}
