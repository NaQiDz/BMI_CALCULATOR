import 'package:flutter/material.dart';
import 'choose.dart';

void main() {
  runApp(StartedPage());
}

class StartedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: MyStartedPage(),
      ),
    );
  }
}

class MyStartedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Colors.blue.shade900],
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start, // Aligns to the top
              children: [
                SizedBox(height: 185), // Adds 100 pixels of space from the top
                Image.asset(
                  'sources/img1.png',
                  height: 400,
                  width: 400,
                ),
                SizedBox(height: 20),
                Text(
                  'Welcome to',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                Text(
                  'SihatSelalu App',
                  style: TextStyle(
                    color: Colors.blue.shade400,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'A smart health monitoring tracks your BMI in real-time using connected devices and Suggestion calorie in just one click',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    // Navigate to SecondPage
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChoosePage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(color: Colors.white, width: 2),
                    backgroundColor: Colors.blue,  // Use backgroundColor instead of color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  ),
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}