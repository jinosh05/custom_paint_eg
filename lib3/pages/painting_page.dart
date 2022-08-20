import 'package:flutter/material.dart';

import '../widgets/measure_painter.dart';

class PaintingPage extends StatefulWidget {
  const PaintingPage({Key? key}) : super(key: key);

  @override
  PaintingPageState createState() => PaintingPageState();
}

class PaintingPageState extends State<PaintingPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 5),
      value: 0.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    print(_animationController.value);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Container(
                  width: 200,
                  height: 200,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(),
                  child: CustomPaint(
                    painter: MeasurePainter(
                      value: _animationController.value,
                    ),
                  ),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () async {
                  _animationController.value = 0.0;
                  await _animationController.forward();
                },
                child: const Text('Animate'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
