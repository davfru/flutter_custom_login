import 'package:flutter/material.dart';
import 'package:login/app_colors.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            "Start To Find Your ideal relationship",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            "Create a unique emotional story that describes better than words",
            style: TextStyle(
              fontSize: 14,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width * 0.9,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      Icons.apple,
                      color: AppColors.black,
                      size: 30, // Increased size
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "Continue with Apple",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer()
                ],
              ),
            ),
          ),
          SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width * 0.9,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      Icons.facebook,
                      color: AppColors.black,
                      size: 30, // Increased size
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "Continue with Facebook",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer()
                ],
              ),
            ),
          ),
          SizedBox(
            height: 50,
            width: MediaQuery.of(context).size.width * 0.9,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.yellow,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      Icons.smartphone,
                      color: AppColors.black,
                      size: 30, // Increased size
                    ),
                  ),
                  const Spacer(),
                  Text(
                    "Continue with Phone",
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer()
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
