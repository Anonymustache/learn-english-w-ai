import 'package:english_learning/config/colors.dart';
import 'package:flutter/material.dart';

class Widgets {
  static AppBar appBar = AppBar(
    backgroundColor: AppColors.primaryBackgroundColor,
    foregroundColor: AppColors.primaryTextColor,
    centerTitle: true,
    title: Text(
      "Обучалка английского",
      maxLines: 10,
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.w500,
        fontSize: 16,
      ),
    ),
  );

  static Container scaffoldContainer(Widget child) {
    return Container(margin: EdgeInsets.all(16), child: child);
  }

  static Container button(String text, VoidCallback? func) => Container(
        color: AppColors.secondaryMainAccent,
        height: 35,
        margin: EdgeInsets.all(8),
        child: InkWell(
          onTap: func,
          child: Center(
            child: Text(
              text,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      );

  static Container field(String hintText, TextEditingController controller) =>
      Container(
        color: AppColors.secondaryMainAccent,
        margin: EdgeInsets.all(8),
        child: TextField(
          textAlign: TextAlign.center,
          controller: controller,
          minLines: 1,
          maxLines: null,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[300]),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(0)),
          ),
          style: TextStyle(color: AppColors.primaryTextColor),
        ),
      );

  static Text text(String text, {double? size}) => Text(
        text,
        style:
            TextStyle(color: AppColors.primaryTextColor, fontSize: size ?? 14),
      );
}
