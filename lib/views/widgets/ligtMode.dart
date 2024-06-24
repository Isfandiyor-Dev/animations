import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Ligtmode extends StatefulWidget {
  const Ligtmode({super.key});

  @override
  State<Ligtmode> createState() => _LigtmodeState();
}

class _LigtmodeState extends State<Ligtmode>
    with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;
  late Animation<double> _conainerAnimation;

  @override
  void initState() {
    super.initState();

    // initializing the AnimationController
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat();

    // initializing the Animation<double>
    _conainerAnimation = Tween<double>(begin: 0, end: 150).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _conainerAnimation,
        builder: (context, child) {
          return Container(
            width: 150,
            height: 70,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [Colors.blue, Colors.lightBlueAccent],
              ),
              borderRadius: BorderRadiusDirectional.circular(50),
            ),
            child: Stack(
              children: [
                _buildCloud(top: 10, width: 30, sizeIcon: 20, opacity: 0.7),
                _buildCloud(top: 20, width: 85, sizeIcon: 30, opacity: 0.5),
                _buildCloud(top: 35, width: 125, sizeIcon: 25, opacity: 0.7),
                _buildCloud(top: 27, width: 150, sizeIcon: 17, opacity: 0.8),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildCloud(
      {required double top,
      required double width,
      required double sizeIcon,
      double opacity = 1}) {
    double value = _animationController.value;

    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) {
        final double position =
            (-width + value * (150 + width)) % (150 + width) - width;
        return Positioned(
          right: position,
          top: top,
          child: Icon(
            CupertinoIcons.cloud_fill,
            size: sizeIcon,
            color: Colors.white.withOpacity(0.8),
          ),
        );
      },
    );
  }
}
