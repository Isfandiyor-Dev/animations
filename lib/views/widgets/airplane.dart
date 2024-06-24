import 'package:flutter/material.dart';

// ignore: must_be_immutable
class AirPlane extends StatefulWidget {
  AnimationController animationController;
  Animation<double> conainerAnimation;
  bool isLigtMode;
  AirPlane(
      {super.key,
      required this.isLigtMode,
      required this.animationController,
      required this.conainerAnimation});

  @override
  State<AirPlane> createState() => _AirPlaneState();
}

class _AirPlaneState extends State<AirPlane>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: widget.conainerAnimation,
        builder: (context, child) {
          return Container(
            width: 70,
            height: 70,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadiusDirectional.circular(50),
            ),
            child: Stack(
              children: [
                _buildAirplane(image: "assets/flying_plane.png"),
                _buildAirplane(image: "assets/landed_plane_black.png"),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildAirplane({required String image}) {
    return AnimatedBuilder(
      animation: widget.animationController,
      builder: (context, child) {
        return AnimatedAlign(
          duration: const Duration(seconds: 3),
          alignment: const Alignment(1, -0.5),
          child: Container(
            width: 40,
            height: 40,
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(),
            transform: Matrix4.rotationZ(0.78),
            child: Image.asset(
              image,
              color: widget.isLigtMode ? Colors.blue : null,
            ),
          ),
        );
      },
    );
  }
}
