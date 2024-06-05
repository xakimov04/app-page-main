import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomInkwellButton extends StatelessWidget {
  final Widget nextPage;
  final String buttonText;
  final int tasks;
  const CustomInkwellButton({
    super.key,
    required this.nextPage,
    required this.buttonText,
    required this.tasks,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (BuildContext context) => nextPage,
          ),
        );
      },
      child: Container(
        height: 130,
        width: 200,
        decoration: BoxDecoration(
          color: const Color(0xff041955),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${tasks.toString()} tasks",
                style: const TextStyle(
                  color: Color(0xff687AB1),
                  fontSize: 20,
                ),
              ),
              Text(
                buttonText,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w800,
                  fontSize: 25,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
