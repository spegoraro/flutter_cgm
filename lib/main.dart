import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_cgm/src/cgm/model/model.dart';
import 'package:flutter_cgm/src/cgm_widget.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  CGM? cgm;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          children: [
            Text(
              'flutter_cgm testing',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            Text(
              'Time spent scratching my head: 19.7 hour(s)',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (cgm == null) {
            final file = File('assets/Engin.cgm');
            cgm = CGM(file);
          }
          for (final command in cgm!.commands) {
            print(command.toString());
          }
        },
        child: const Icon(Icons.refresh),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: InteractiveViewer(
          maxScale: 10,
          child: Builder(builder: (context) {
            if (cgm == null) {
              final file = File('assets/Engin.cgm');
              cgm = CGM(file);
            }

            return Container(
              width: 900,
              height: 900,
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(),
              child: CGMWidget(cgm!),
            );
          }),
        ),
      ),
    );
  }
}
