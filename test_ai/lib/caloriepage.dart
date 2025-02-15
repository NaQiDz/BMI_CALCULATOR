import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CaloriePage extends StatefulWidget {
  final int userId;
  CaloriePage({required this.userId});

  @override
  _CaloriePageState createState() => _CaloriePageState();
}

class _CaloriePageState extends State<CaloriePage> {
  late Future<double> caloriePerDay;

  Future<double> fetchCalories() async {
    final response = await http.get(
      Uri.parse('http://172.20.10.5/test/get_calories.php?user_id=${widget.userId}'),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return data['calories_per_day'];  // Assuming the returned data contains 'calories_per_day'
    } else {
      throw Exception('Failed to load calories');
    }
  }

  @override
  void initState() {
    super.initState();
    caloriePerDay = fetchCalories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daily Calorie Intake"),
      ),
      body: FutureBuilder<double>(
        future: caloriePerDay,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else {
            return Center(
              child: Text(
                "Recommended Calories per Day: ${snapshot.data!.toStringAsFixed(2)} kcal",
                style: TextStyle(fontSize: 24),
              ),
            );
          }
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(home: CaloriePage(userId: 1)));  // Pass the userId you want
}
