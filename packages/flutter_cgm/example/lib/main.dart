import 'package:flutter/material.dart';
import 'package:flutter_cgm/flutter_cgm.dart';

/// The names of the CGMs to be displayed in the page view.
const List<String> _cgmNames = ['engine', 'circuit_1', 'circuit_2'];

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ExampleApp());
}

class ExampleApp extends StatefulWidget {
  const ExampleApp({super.key});

  @override
  State<ExampleApp> createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  late List<CGM> cgms;
  late PageController _pageController;
  bool rasterize = true;

  @override
  void initState() {
    super.initState();

    cgms = _cgmNames.map((String name) => CGM.fromPath('assets/$name.cgm')).toList();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('CGM Example'),
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            PageView(
              controller: _pageController,
              children: cgms
                  .map((CGM cgm) => InteractiveViewer(
                        child: Center(
                          child: Container(
                            clipBehavior: Clip.antiAlias,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 20)],
                            ),
                            child: CGMWidget(
                              cgm: cgm,
                              width: 600,
                              rasterize: rasterize,
                              color: Theme.of(context).colorScheme.surfaceContainerLowest,
                              blendMode: BlendMode.darken,
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
            Positioned(
              bottom: 10,
              child: _buildButtons(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildButtons(BuildContext context) {
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => _pageController.previousPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerLowest,
            borderRadius: BorderRadius.circular(20),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
          ),
          child: Row(
            children: [
              const Text('Rasterize', style: TextStyle(fontSize: 16)),
              const SizedBox(width: 10),
              Switch(
                value: rasterize,
                onChanged: (bool value) => setState(() => rasterize = value),
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.arrow_forward_ios),
          onPressed: () => _pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          ),
        ),
      ],
    );
  }
}
