import 'package:flutter/material.dart';
import 'package:zoom/widgets/custom_button.dart';
import 'package:zoom/widgets/sign_in_button.dart';
import 'package:zoom/widgets/sign_up_button.dart';

class BottomRoundedContainer extends StatelessWidget {
  final double height;
  final double width;
  final Color color;
  final double borderRadius;

  const BottomRoundedContainer({
    Key? key,
    this.height = 200.0,
    this.width = double.infinity,
    this.color = Colors.white,
    this.borderRadius = 20.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(borderRadius),
            topRight: Radius.circular(borderRadius),
          ),
        ),
        child: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Welcome',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: Color(0XFF1e1d25)),
              ),
              SizedBox(height: 5),
              Text(
                'Get started with your account',
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: Color(0XFF1e1d25)),
              ),
              SizedBox(height: 30),
              CustomButton(text: 'Join a meeting'),
              SizedBox(height: 14),
              SignUp(text: 'Sign up'),
              SizedBox(height: 14),
              SignIn(text: 'Sign in'),
            ],
          ),
        ),
      ),
    );
  }
}
