Dart library for parsing and drawing CGM *(Computer Graphics Metafile)* files.


This library is a Dart port of the [jcgm](https://github.com/SwissAS/jcgm-core/) library
(originally written in java)

> **Note:** This library is still in development and does not yet support all CGM features.
> Bugs and missing features are likely to be present.

## Features

- Parsing the commands of a CGM file, and converting them to Dart objects.
- Interface to draw the CGM commands to a `CGMCanvas`

## Usage

This library only provides the parsing of CGM commands, and an interface to draw them to a `CGMCanvas`.

To display the parsed file as a widget in a Flutter app,
you can use the [flutter_cgm](https://pub.dev/packages/flutter_cgm) package.

## Contribution

Contributions are welcome! Feel free to open an issue or a pull request.
