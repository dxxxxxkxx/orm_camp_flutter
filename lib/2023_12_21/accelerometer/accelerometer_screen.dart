import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sensors_plus/sensors_plus.dart';

class AccelerometerScreen extends StatelessWidget {
  const AccelerometerScreen({super.key});

  @override
  Widget build(final BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);

    final double centerX = MediaQuery.of(context).size.width / 2 - 50;
    final double centerY = MediaQuery.of(context).size.height / 2 - 50;

    return Scaffold(
      body: Stack(
        children: [
          StreamBuilder<AccelerometerEvent>(
            stream: accelerometerEventStream(),
            builder: (final BuildContext context,
                final AsyncSnapshot<AccelerometerEvent> snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                AccelerometerEvent accelerometerData = snapshot.data!;

                return Positioned(
                  left: centerX + accelerometerData.y * 20,
                  top: centerY + accelerometerData.x * 20,
                  child: Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.green,
                    ),
                  ),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          )
        ],
      ),
    );
  }
}
