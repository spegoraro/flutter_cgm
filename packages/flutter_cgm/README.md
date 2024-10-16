Flutter implementation of the [cgm](https://pub.dev/packages/cgm) library.

> **Note:** This library is still in development and does not yet support all CGM features.
> Bugs and missing features are likely to be present.

## Features

- Drawing the commands of a parsed CGM file to a Canvas, or displaying them in a widget.

## Usage

To paint the commands to a canvas:
```dart
final cgm = CGM.fromFile(file);

// Create a canvas to draw the CGM commands on
// The paramter canvas is an instance of Flutter's Canvas class
final cgmCanvas = FlutterCGMCanvas(canvas);
final display = CGMDisplay(cgm);

// Paint the CGM commands to the canvas
display.paint(cgmCanvas);
```
<br>

To display the CGM file in a stateful widget:
```dart
class ExampleWidget extends StatefulWidget {
  @override
  _ExampleWidgetState createState() => _ExampleWidgetState();
}

class _ExampleWidgetState extends State<ExampleWidget> {
  late final CGM cgm;

  @override
  void initState() {
    super.initState();
    final file = File('path/to/file.cgm');
    cgm = CGM.fromFile(file);
  }

  @override
  Widget build(BuildContext context) {
    return CGMWidget(
      cgm: cgm,
    );
  }
}
```

## Contribution

Contributions are welcome! Feel free to open an issue or a pull request.
