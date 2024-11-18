import 'package:flutter/material.dart';
import 'started.dart';

void main() {
  runApp(LoadingPage());
}

class LoadingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Navigate to MainPage after 4 seconds
    Future.delayed(Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => StartedPage()),
      );
    });
  }

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Spacer(),
            Center(
              child: Column(
                children: [
                  Image.asset(
                    'sources/logo.png', // Ensure this matches the path in pubspec.yaml
                    height: 100,
                    width: 100,
                  ),
                  SizedBox(height: 20),
                  Text(
                    'SihatSelalu App',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
