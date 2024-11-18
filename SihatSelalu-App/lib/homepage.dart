import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'qrpage.dart';

void main() {
  runApp(SihatSelaluApp());
}

class SihatSelaluApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.black, Colors.blue.shade900],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: Icon(
                            FontAwesomeIcons.clipboardList,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(width: 90),
                        Text(
                          'SihatSelalu App',
                          style: TextStyle(
                            color: Colors.blue[900],
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Icon(
                      FontAwesomeIcons.bell,
                      color: Colors.white,
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  'Today',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                SizedBox(height: 16),
                Container(
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      Text(
                        'Calories',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 16),
                      Center(
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 4),
                          ),
                          child: Center(
                            child: Text(
                              'Calorie\nRemaining',
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Weight :',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(height: 8),
                            Icon(
                              FontAwesomeIcons.weight,
                              color: Colors.red,
                              size: 32,
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Height :',
                              style: TextStyle(color: Colors.white),
                            ),
                            SizedBox(height: 8),
                            Icon(
                              FontAwesomeIcons.ruler,
                              color: Colors.blue,
                              size: 32,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Container(
                  width: 450,
                  height: 250,
                  padding: EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Weight :',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        'Goal to achieve :',
                        style: TextStyle(color: Colors.white),
                      ),
                      SizedBox(height: 30),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '95',
                            style: TextStyle(color: Colors.white),
                          ),
                          Divider(color: Colors.white),
                          Text(
                            '90',
                            style: TextStyle(color: Colors.white),
                          ),
                          Divider(color: Colors.white),
                          Text(
                            '85',
                            style: TextStyle(color: Colors.white),
                          ),
                          Divider(color: Colors.white),
                          Text(
                            '80',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => QrPage()),
                          );
                        },
                        child: Column(
                          children: [
                            Icon(
                              FontAwesomeIcons.calculator,
                              color: Colors.white,
                              size: 32,
                            ),
                            SizedBox(height: 4),
                            Text(
                              'Calculate BMI',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),

                      // QR Navigation Button
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => QrPage()),
                            );
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Icon(
                              FontAwesomeIcons.qrcode,
                              color: Colors.black,
                              size: 36,
                            ),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => QrPage()),
                              );
                            },
                            child: Column(
                              children: [
                                Icon(
                                  FontAwesomeIcons.search,
                                  color: Colors.white,
                                  size: 32,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Track Calorie',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                    ],
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
