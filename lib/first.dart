import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
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
      appBar: AppBar(
        title: Text('Dropdown Menu Example'),
        actions: [
          PopupMenuButton<String>(
            onSelected: (String result) {
              // Handle menu item selection
              print("Selected: $result");
            },
            icon: Icon(Icons.menu), // Side button icon
            itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: 'Option 1',
                child: Text('Option 1'),
              ),
              PopupMenuItem<String>(
                value: 'Option 2',
                child: Text('Option 2'),
              ),
              PopupMenuItem<String>(
                value: 'Option 3',
                child: Text('Option 3'),
              ),
            ],
          ),
        ],
      ),
      body: Center(
        child: Text(
          'Tap the menu icon in the top right corner!',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
