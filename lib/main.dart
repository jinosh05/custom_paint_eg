import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        backgroundColor: const Color(0xff804C36),
        appBar: AppBar(
          title: const Text('Material App Bar'),
        ),
        body: const Body(),
      ),
    );
  }
}

class Body extends StatefulWidget {
  const Body({
    Key? key,
  }) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Color _color;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
      value: 0.0,
    );
    _color = Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Wrap(
          children: [
            for (var i = 0; i < 100; i++)
              SizedBox(
                width: w * 0.1,
                height: w * 0.1,
                child: AnimatedBuilder(
                    animation: _animationController,
                    builder: (context, child) {
                      return CustomPaint(
                        painter: SquarePainter(
                          value: _animationController.value,
                          color: _color,
                        ),
                      );
                    }),
              ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        ElevatedButton(
          onPressed: () async {
            _animationController.value = 0.0;
            await _animationController.forward();
          },
          child: const Text('Animate'),
        ),
        ElevatedButton(
          onPressed: () async {
            setState(() {
              _color = Colors.redAccent;
            });

            await Future.delayed(const Duration(milliseconds: 250), () {
              setState(() {
                _color = Colors.white;
              });
            });
          },
          child: const Text('Red'),
        ),
      ],
    );
  }
}

class SquarePainter extends CustomPainter {
  final double value;
  final Color? color;

  SquarePainter({
    required this.value,
    this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color ?? Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    var path = Path();
    // path.addRect(const Offset(0, 0) & size * value);

    canvas.drawLine(Offset.zero, Offset(0, size.height * value), paint);
    canvas.drawLine(
        Offset(0, size.height), Offset(size.width * value, size.height), paint);
    canvas.drawLine(Offset(size.width, size.height),
        Offset(size.width, (size.height - size.height * value)), paint);
    canvas.drawLine(Offset(size.width, 0),
        Offset((size.width - size.width * value), 0), paint);
    // canvas.drawLine(Offset(size.width, 0), Offset.zero, paint);
    // canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(SquarePainter oldDelegate) {
    return oldDelegate.value != value;
  }

  @override
  bool shouldRebuildSemantics(SquarePainter oldDelegate) => false;
}
