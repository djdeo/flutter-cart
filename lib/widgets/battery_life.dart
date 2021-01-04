import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BatterLife extends StatefulWidget {
  @override
  _BatterLifeState createState() => _BatterLifeState();
}

class _BatterLifeState extends State<BatterLife> {
  int _batteryLevel;

  Future<void> _getBatteryLevel() async {
    const platform = MethodChannel('course.flutter.dev/battery');
    try {
      final batteryLevel = await platform.invokeMethod('getBatteryLevel');
      setState(() {
        _batteryLevel = batteryLevel;
      });
    } on PlatformException catch (e) {
      setState(() {
        _batteryLevel = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
            leading: Icon(Icons.battery_std_outlined),
            title: Text('Show Current Battery Life: $_batteryLevel'),
            onTap: _getBatteryLevel,
          );
  }
}