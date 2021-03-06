import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:prism_flutter_core/prism_flutter_core.dart';
import 'package:prism_flutter_app/boostrapper.dart';

late GetIt container;
void main() {
  final boostrapper = Bootstrapper();
  boostrapper.run();
  container = boostrapper.container;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Expanded(
              child: RegionBuilder(
                regionManager: container<RegionManager>(),
                regionName: "main",
                multiChild: (children) => ListView(
                  children: children,
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton:
          RegionBuilder(regionManager: container<RegionManager>(), regionName: "action", singleChild: (child) => child),
    );
  }
}
