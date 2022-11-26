import 'package:blood_donation/provider/navigation_provider.dart';
import 'package:blood_donation/provider/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BloodDropDesign extends StatefulWidget {
  final bloodGroup;

  const BloodDropDesign(
    this.bloodGroup, {
    Key? key,
  }) : super(key: key);

  @override
  State<BloodDropDesign> createState() => _BloodDropDesignState();
}

class _BloodDropDesignState extends State<BloodDropDesign>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1000,
      ),
    );
    _controller.addStatusListener((animationStatus) {
      switch (animationStatus) {
        case AnimationStatus.completed:
          _controller.reverse();
          break;
        case AnimationStatus.dismissed:
          _controller.forward();
          break;
        case AnimationStatus.forward:
          break;
        case AnimationStatus.reverse:
          break;
      }
    });
    _controller.forward();
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, value, child) => InkWell(
        onTap: () {
          setState(() {
            value.selectBlood = widget.bloodGroup;
          });
        },
        child: Stack(
          children: [
            Transform.rotate(
              angle: -0.8,
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) => Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: widget.bloodGroup == value.selectBlood
                        ? Colors.red
                        : Colors.white,
                    border: Border.all(
                        color: Colors.red, width: _controller.value * 4),
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 5,
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  widget.bloodGroup,
                  style: TextStyle(
                    color: widget.bloodGroup == value.selectBlood
                        ? Colors.white
                        : Colors.red,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
