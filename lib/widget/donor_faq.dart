import 'package:blood_donation/data/demo_question.dart';
import 'package:blood_donation/utils/style.dart';
import 'package:flutter/material.dart';

class DonarFAQWidget extends StatefulWidget {
  final Question question;
  const DonarFAQWidget({
    Key? key,
    required this.question,
  }) : super(key: key);

  @override
  State<DonarFAQWidget> createState() => _DonarFAQWidgetState();
}

class _DonarFAQWidgetState extends State<DonarFAQWidget> {
  String? answer;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 5, bottom: 5),
      padding: const EdgeInsets.all(15),
      decoration: inputDecoration,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.question.question,
            style: const TextStyle(
              color: Colors.black,
              fontFamily: "Schyler",
              fontSize: 14,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Radio(
                value: "Yes",
                groupValue: answer,
                onChanged: (value) {
                  setState(() {
                    answer = value;
                    widget.question.answer = true;
                  });
                },
              ),
              const Text(
                "Yes",
                style: TextStyle(color: Colors.grey),
              ),
              Radio(
                value: "No",
                groupValue: answer,
                onChanged: (value) {
                  setState(() {
                    answer = value;
                    widget.question.answer = false;
                  });
                },
              ),
              const Text(
                "No",
                style: TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
