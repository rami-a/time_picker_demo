import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDark = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Time Picker Demo',
      themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: ColorScheme.light().primary,
        colorScheme: ColorScheme.light(),
        buttonTheme: ButtonThemeData(
          textTheme: ButtonTextTheme.primary,
        ),
        toggleableActiveColor: ColorScheme.light().primary,
        highlightColor: Colors.transparent,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: ColorScheme.dark().primary,
        colorScheme: ColorScheme.dark(),
        buttonTheme: ButtonThemeData(
          textTheme: ButtonTextTheme.primary,
        ),
        toggleableActiveColor: ColorScheme.dark().primary,
        highlightColor: Colors.transparent,
      ),
      home: MyHomePage(
        onDarkModeChanged: (value) {
          setState(() {
            _isDark = value;
          });
        },
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key key, this.onDarkModeChanged}) : super(key: key);

  final ValueChanged<bool> onDarkModeChanged;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TimeOfDay _time = TimeOfDay.now();
  bool _isSlow = false;
  bool _isDark = false;
  bool _use24hour = false;
  List<bool> _isSelected = [true, false, false];

  double get _textScale {
    if (_isSelected[1]) return 1.3;
    if (_isSelected[2]) return 2.0;
    return 1.0;
  }
  void _selectTime() async {
    final TimeOfDay newTime = await showTimePicker(
      context: context,
      initialTime: _time,
      builder: (context, child) {

        return MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaleFactor: _textScale,
            alwaysUse24HourFormat: _use24hour,
          ),
          child: child,
        );
      }
    );
    if (newTime != null) {
      setState(() { _time = newTime; });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaleFactor: _textScale),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Time Picker Demo'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    onPressed: _selectTime,
                    child: Text('SELECT TIME'),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Selected time: ${_time.format(context)}',
                  ),
                  SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Use 24h'),
                      Switch(
                        value: _use24hour,
                        onChanged: (value) {
                          setState(() {
                            _use24hour = value;
                          });
                        },
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Dark mode'),
                      Switch(
                        value: _isDark,
                        onChanged: (value) {
                          setState(() {
                            _isDark = value;
                            widget.onDarkModeChanged(_isDark);
                          });
                        },
                      )
                    ],
                  ),
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
                  ),
                  SizedBox(height: 8),
                  Text('Text scale:'),
                  SizedBox(height: 4),
                  ToggleButtons(
                    children: <Widget>[
                      Text('1.0'),
                      Text('1.3'),
                      Text('2.0'),
                    ],
                    onPressed: (int index) {
                      setState(() {
                        for (int buttonIndex = 0; buttonIndex < _isSelected.length; buttonIndex++) {
                          if (buttonIndex == index) {
                            _isSelected[buttonIndex] = true;
                          } else {
                            _isSelected[buttonIndex] = false;
                          }
                        }
                      });
                    },
                    isSelected: _isSelected,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
