import 'package:animations/providers/theme_provider.dart';
import 'package:animations/views/widgets/airplane.dart';
import 'package:animations/views/widgets/darkMode.dart';
import 'package:animations/views/widgets/ligtMode.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  bool isLigtMode = false;
  late final AnimationController animationController;
  late Animation<double> conainerAnimation;

  @override
  void initState() {
    super.initState();

    // initializing the AnimationController
    animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    // initializing the Animation<double>
    conainerAnimation = Tween<double>(begin: 0, end: 70).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: GestureDetector(
          onTap: () {
            setState(() {
              isLigtMode = !isLigtMode;
                    Provider.of<ThemeProvider>(context, listen: false).toggleThemeMode();
              animationController.forward();
            });
          },
          child: AnimatedContainer(
            duration: const Duration(seconds: 1),
            width: 150,
            height: 70,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  blurRadius: 10,
                  spreadRadius: 2,
                )
              ],
            ),
            child: Stack(
              children: [
                AnimatedCrossFade(
                  firstChild: const Ligtmode(),
                  secondChild: const Darkmode(),
                  crossFadeState: isLigtMode
                      ? CrossFadeState.showFirst
                      : CrossFadeState.showSecond,
                  duration: const Duration(milliseconds: 1500),
                ),
                AnimatedPositioned(
                  left: isLigtMode ? 80 : 0,
                  duration: const Duration(milliseconds: 1200),
                  child: AnimatedContainer(
                    duration: const Duration(seconds: 2),
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey[200],
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          blurRadius: 10,
                          spreadRadius: 2,
                        )
                      ],
                    ),
                    child: AirPlane(
                      isLigtMode: isLigtMode,
                      conainerAnimation: conainerAnimation,
                      animationController: animationController,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
