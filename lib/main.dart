import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';

void main() {
//  timeDilation = 2;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time Picker Demo',
      theme: ThemeData(
        primaryColor: ColorScheme.light().primary,
        colorScheme: ColorScheme.light(),
        buttonTheme: ButtonThemeData(
          textTheme: ButtonTextTheme.primary,
        ),
        toggleableActiveColor: ColorScheme.light().primary,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TimeOfDay _time = TimeOfDay.now();
  DateTime _date = DateTime.now();
  bool _isSlow = false;

  void _selectTime() async {
    final TimeOfDay newTime = await showTimePicker(context: context, initialTime: _time);
    if (newTime != null) {
      setState(() { _time = newTime; });
    }
  }

  void _selectDate() async {
    final DateTime newDate = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2020, 1, 15),
      lastDate: DateTime(2101),
    );
    if (newDate != null) {
      setState(() { _date = newDate; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Picker Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: _selectTime,
              child: Text('SELECT TIME'),
            ),
            SizedBox(height: 16),
            Text(
              'Selected time: ${_time.format(context)}',
            ),
            SizedBox(height: 16),
            RaisedButton(
              onPressed: _selectDate,
              child: Text('SELECT DATE'),
            ),
            SizedBox(height: 16),
            Text(
              'Selected date: ${DateFormat.yMMMd().format(_date)}',
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Slow Motion'),
                Switch(
                  value: _isSlow,
                  onChanged: (value) {
                    setState(() {
                      _isSlow = value;
                      timeDilation = _isSlow ? 5 : 1;
                    });
                  },
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
