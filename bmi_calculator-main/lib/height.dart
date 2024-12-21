import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Height Meter Slider',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HeightMeter(),
    );
  }
}

class HeightMeter extends StatefulWidget {
  @override
  _HeightMeterState createState() => _HeightMeterState();
}

class _HeightMeterState extends State<HeightMeter> {
  double _height = 0.0; // Initial height in cm
  TextEditingController _controller = TextEditingController();

  void _updateSlider(String input) {
    final double? enteredValue = double.tryParse(input);
    if (enteredValue != null && enteredValue >= 0 && enteredValue <= 200) {
      setState(() {
        _height = enteredValue.roundToDouble();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Height Meter'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Input Field
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _controller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Enter Height (0 - 200 cm)',
                ),
                onChanged: _updateSlider, // Update slider on input
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Height: ${_height.round()} cm',
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 20),
            // Height Meter
            Expanded(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  // Ruler
                  CustomPaint(
                    size: Size(50, double.infinity),
                    painter: RulerPainter(),
                  ),
                  // Slider aligned to the bottom
                  Positioned(
                    left: 30,
                    right: 30,
                    child: RotatedBox(
                      quarterTurns: -1,
                      child: Slider(
                        value: _height,
                        onChanged: (newValue) {
                          setState(() {
                            _height = newValue.roundToDouble();
                            _controller.text = _height.round().toString();
                          });
                        },
                        divisions: 200,
                        min: 0.0,
                        max: 200.0,
                        label: '${_height.round()} cm',
                        activeColor: Colors.blue,
                        inactiveColor: Colors.grey[300],
                      ),
                    ),
                  ),






































































































































































































































                  
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Custom Painter for the Height Ruler
class RulerPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = Colors.grey
      ..strokeWidth = 1.0;

    final double maxHeight = 200.0; // Max height in cm
    final double pixelPerCm = size.height / maxHeight; // Pixels per cm

    for (double i = 0; i <= maxHeight; i++) {
      double y = size.height - (i * pixelPerCm);
      double tickLength = (i % 10 == 0) ? 20 : (i % 5 == 0) ? 15 : 10;

      canvas.drawLine(
        Offset(0, y),
        Offset(tickLength, y),
        paint,
      );

      // Draw labels every 10 cm
      if (i % 10 == 0) {
        TextPainter textPainter = TextPainter(
          text: TextSpan(
            text: '${i.round()}',
            style: TextStyle(color: Colors.grey, fontSize: 12),
          ),
          textAlign: TextAlign.right,
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();
        textPainter.paint(canvas, Offset(25, y - 6));
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
