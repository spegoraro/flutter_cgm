import 'package:flutter/material.dart';
import 'package:flutter_cgm/flutter_cgm.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const ExampleApp());
}

/// The names of the CGMs to be displayed in the page view.
const List<String> _cgmNames = ['fuel_pump', 'F421D014', 'F421D034', 'piston', 'engine', 'circuit_1', 'circuit_2'];

class ExampleApp extends StatefulWidget {
  const ExampleApp({super.key});

  @override
  State<ExampleApp> createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  late List<CGM> cgms;
  late PageController _pageController;
  int _currentPage = 0;
  bool rasterize = true;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          notificationPredicate: (notification) => false,
          title: const Text('CGM Example'),
        ),
        body: Stack(
          alignment: Alignment.center,
          children: [
            PageView(
              controller: _pageController,
              onPageChanged: (int page) => setState(() => _currentPage = page),
              children: cgms.map((CGM cgm) => _buildCGMWidget(context, cgm)).toList(),
            ),
            Positioned(
              bottom: 10,
              child: _buildButtons(context),
            ),
            Positioned(
              right: 0,
              child: Container(
                width: 300,
                height: MediaQuery.sizeOf(context).height,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surfaceContainerLowest,
                  borderRadius: const BorderRadius.horizontal(left: Radius.circular(24)),
                  boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
                ),
                // Wrap the inspector in a Material widget to get ink response for the ExpansionTile.
                child: Material(
                  color: Colors.transparent,
                  child: _buildInspector(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    cgms = _cgmNames.map((String name) => CGM.fromPath('assets/$name.cgm')).toList();
    _pageController = PageController();
  }

  Widget _buildButtons(BuildContext context) {
    const easingDuration = Duration(milliseconds: 300);
    const easingCurve = Curves.easeInOut;

    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => _pageController.previousPage(duration: easingDuration, curve: easingCurve),
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
          onPressed: () => _pageController.nextPage(duration: easingDuration, curve: easingCurve),
        ),
      ],
    );
  }

  InteractiveViewer _buildCGMWidget(BuildContext context, CGM cgm) {
    return InteractiveViewer(
      child: Center(
        child: Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)],
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
    );
  }

  Widget _buildInspector(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 10),
      children: [
        const Center(child: Text('Inspector', style: TextStyle(fontSize: 20))),
        const SizedBox(height: 20),
        ...cgms[_currentPage].commands.map(
              (command) => ExpansionTile(
                title: Text(command.runtimeType.toString()),
                dense: true,
                childrenPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                children: [
                  Text(
                    command.toString(),
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            )
      ],
    );
  }
}
