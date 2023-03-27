import 'dart:async';
import 'package:corona_api/Utils/utils.dart';
import 'package:corona_api/Views/world_stats.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  // Animation Controller:

  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 6), vsync: this)
        ..repeat();

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 6),
        () => nextScreenReplace(context, const WorldStatsScreen()));
  }

  @override
  void dispose() {
    _controller.dispose(); // Must dispose the controller:
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            AnimatedBuilder(
              animation: _controller,
              builder: (context, Widget? child) {
                return Transform.rotate(
                  angle: _controller.value * 2.0 * math.pi,
                  child: child,
                );
              },
              child: Container(
                height: height * 0.5, // 50%
                width: width * 1, // 100%
                // color: Colors.black,
                child: const Center(
                  child: Image(
                    image: AssetImage('assets/virus.png'),
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.02),
            const Text(
              'Covid-19\nTracker App',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            )
          ],
        ),
      ),
    );
  }
}
