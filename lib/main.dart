import 'package:flutter/material.dart';
import 'package:pooly_task/screens/driver.dart';
import 'package:pooly_task/screens/rider_main.dart';
import 'package:pooly_task/screens/rider_signup.dart';
import 'package:pooly_task/screens/select_role.dart';

void main() {
  runApp(MaterialApp(
    home: const SelectRoleScreen(), // becomes the route named '/'
    routes: <String, WidgetBuilder> {
      '/rider': (BuildContext context) => const RiderMainScreen(),
      '/driver': (BuildContext context) => const DriverScreen(),
      '/riderSignup': (BuildContext context) => const RiderSignupScreen(),
    },
  ));
}

// lookup navigator: https://api.flutter.dev/flutter/widgets/Navigator-class.html
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pooly Task',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
