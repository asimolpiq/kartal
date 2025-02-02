import 'package:flutter/material.dart';
import 'package:kartal/kartal.dart';

void main() {
  _appInit();
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Material App',
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Kartal Extension Application')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildImageRotate(),
            // buildContainerPaddingAndHeight(context),
            // buildTextFormFieldValid(),
            // buildContainerRandomColor(context),
            // buildTextFieldFormatter()
          ],
        ),
      ),
    );
  }

  /// [Input Formatter] Validation
  ///
  /// [String] value mask and unmask
  Widget buildTextFieldFormatter() {
    return TextField(
      inputFormatters: [InputFormatter.instance.phoneFormatter],
      onChanged: (value) {
        debugPrint(value.phoneFormatValue);
      },
    );
  }

  /// [context] Helper
  ///
  /// Padding, height etc. direct access and use centrically for app

  Widget buildContainerPaddingAndHeight(BuildContext context) {
    return Container(
      padding: context.paddingLow,
      height: context.dynamicHeight(0.1),
      width: context.dynamicWidth(0.5),
      color: context.randomColor,
      child: const Text('Hello World'),
    );
  }

  /// [String] Validator
  ///
  /// Need validation for your field, use to "string.isValidEmail"
  Widget buildTextFormFieldValid() {
    return TextFormField(
      autovalidateMode: AutovalidateMode.always,
      validator: (value) => value.isValidEmail ? null : 'OH NOO',
    );
  }

  /// [Color] Generator
  ///
  /// Need draw any color for widget, just call [context.randomColor]
  Widget buildContainerRandomColor(BuildContext context) {
    return ColoredBox(
      color: context.randomColor,
      child: const Text('Hello World'),
    );
  }

  /// [Image] Rotation
  ///
  /// You can rotate right, left, top, bottom any image widget.

  Widget buildImageRotate() =>
      Image.network('https://picsum.photos/200/300').upRotation;
}

void _appInit() {
  WidgetsFlutterBinding.ensureInitialized();
}
