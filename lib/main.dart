import 'package:clip_path_background/clipped_background.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  static const double defaultIconSize = 50;
  static const double defaultIconOffsetX = 0;
  static const double defaultIconOffsetY = 0;
  static const double defaultIconSpacing = 16;
  double iconOffsetX = defaultIconOffsetX;
  double iconOffsetY = defaultIconOffsetY;
  double iconSize = defaultIconSize;
  double iconSpacing = defaultIconSpacing;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DefaultClippedBackgroundWithIcon(
              iconSize: iconSize,
              iconOffsetX: iconOffsetX,
              iconOffsetY: iconOffsetY,
              iconSpacing: iconSpacing,
            ),
            SliderWithText(
              value: iconOffsetX,
              min: -100,
              max: 100,
              resetValue: defaultIconOffsetX,
              onChanged: (value) {
                setState(() {
                  iconOffsetX = value;
                });
              },
              text: 'Offset X',
            ),
            SliderWithText(
              value: iconOffsetY,
              min: -100,
              max: 100,
              resetValue: defaultIconOffsetY,
              onChanged: (value) {
                setState(() {
                  iconOffsetY = value;
                });
              },
              text: 'Offset Y',
            ),
            SliderWithText(
              value: iconSize,
              min: defaultIconSize,
              max: 80,
              resetValue: defaultIconSize,
              onChanged: (value) {
                setState(() {
                  iconSize = value;
                });
              },
              text: 'Icon Size',
            ),
            SliderWithText(
              value: iconSpacing,
              min: 0,
              max: 100,
              resetValue: defaultIconSpacing,
              onChanged: (value) {
                setState(() {
                  iconSpacing = value;
                });
              },
              text: 'Icon Spacing',
            ),
          ],
        ),
      ),
    );
  }
}

class SliderWithText extends StatelessWidget {
  const SliderWithText({
    super.key,
    required this.value,
    required this.onChanged,
    required this.text,
    required this.min,
    required this.max,
    required this.resetValue,
  });
  final double value;
  final ValueChanged<double> onChanged;
  final String text;
  final double min;
  final double max;
  final double resetValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(text),
            const SizedBox(width: 9),
            Expanded(
              child: Slider(
                value: value,
                onChanged: onChanged,
                min: min,
                max: max,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(value.toStringAsFixed(1)),
            MaterialButton(
              color: Theme.of(context).colorScheme.secondary,
              onPressed: () {
                onChanged(resetValue);
              },
              child: const Text('Reset'),
            ),
          ],
        ),
      ],
    );
  }
}

// this is just for the demo, provide your own icon and background
class DefaultClippedBackgroundWithIcon extends StatelessWidget {
  const DefaultClippedBackgroundWithIcon(
      {super.key,
      required this.iconSize,
      required this.iconOffsetX,
      required this.iconOffsetY,
      required this.iconSpacing});
  final double iconSize;
  final double iconOffsetX;
  final double iconOffsetY;
  final double iconSpacing;

  @override
  Widget build(BuildContext context) {
    return ClippedBackgroundWithIcon(
      icon: Container(
        decoration: const BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
      ),
      background: Container(
        color: Theme.of(context).colorScheme.secondary,
        height: 200,
      ),
      iconSize: iconSize,
      iconOffsetX: iconOffsetX,
      iconOffsetY: iconOffsetY,
      iconSpacing: iconSpacing,
    );
  }
}
