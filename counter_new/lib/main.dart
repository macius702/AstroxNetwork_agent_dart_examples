import 'dart:io';
import 'dart:convert';
import 'package:agent_dart/agent_dart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'config.dart' show backendCanisterId;


// import Counter class with canister call
import 'counter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// enum for mode of execution: playground, mainnet or local     
  enum Mode {
    playground,
    local,
    mainnet
  }



class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool _loading = false;
  // setup state class variable;
  Counter? counter;

  @override
  void initState() {
    initCounter();
    super.initState();
  }

  Future<void> initCounter({Identity? identity}) async {
    // initialize counter, change canister id here 
     //10.0.2.2  ? private const val BASE_URL = "http://10.0.2.2:4944"

    // String url;
    // var backendCanisterId;
    // if (kIsWeb) {
    //   print("kIsWeb");
    //   url = 'http://localhost:4944'; 
  

    // } else {
    //     print("not kIsWeb");

    //   // url = 'http://10.0.2.2:4944'; // default to localhost for other platforms

    //   // url = 'https://mdwwn-niaaa-aaaab-qabta-cai.ic0.app:4944';

    // }


    // url = 'https://z7chj-7qaaa-aaaab-qacbq-cai.icp0.io:4944';
    // backendCanisterId = 'ocpcu-jaaaa-aaaab-qab6q-cai';

    Mode mode = Mode.playground;

  var frontend_url;

  if (mode == Mode.playground) {
    frontend_url = 'https://icp-api.io';
  } else if (mode == Mode.local) {
    if (kIsWeb  ) {
      frontend_url = 'http://localhost:4944';
    } else {  // for android emulator
      frontend_url = 'http://10.0.2.2:4944';  
    }
  } else if (mode == Mode.mainnet) {
  }



    counter = Counter(canisterId: backendCanisterId, url: frontend_url);    // set agent when other paramater comes in like new Identity
    await counter?.setAgent(newIdentity: identity);
    await getValue();
  }

  // get value from canister
  Future<void> getValue() async {
    var counterValue = await counter?.getValue();
    setState(() {
      _counter = counterValue ?? _counter;
      _loading = false;
    });
  }

  // increment counter
  Future<void> _incrementCounter() async {
    setState(() {
      _loading = true;
    });
    await counter?.increment();
    await getValue();
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'The canister counter is now:',
            ),
            Text(
              _loading ? 'loading...' : '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
