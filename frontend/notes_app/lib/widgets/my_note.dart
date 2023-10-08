import 'package:flutter/material.dart';
import 'package:notes_app/widgets/mytext.dart';

class MyNote extends StatelessWidget {
  const MyNote({
    super.key,
    required this.onTap,
    required this.onLongPress,
    required this.color,
    required this.border,
    required this.titleText,
    required this.contentText,
    required this.height,
  });

  final VoidCallback onTap;
  final VoidCallback onLongPress;
  final Color color;
  final Border? border;
  final String titleText;
  final String contentText;
  final double height;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        decoration: BoxDecoration(
            color: color,
            border: border,
            borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyText(
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  text: titleText,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              SizedBox(
                height: height * 0.005,
              ),
              MyText(
                text: contentText,
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.black,
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              )
            ],
          ),
        ),
      ),
    );
  }
}
