import 'package:flutter/material.dart';
import 'package:homzes_app/core/constants/colors.dart';

Widget buildOptionCard(BuildContext context, IconData icon, String title, Color color) {
  return Container(
    width: MediaQuery.of(context).size.width / 2.5,
    margin: EdgeInsets.symmetric(horizontal: 5),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(25),
      boxShadow: [
        BoxShadow(
          color: Colors.black12,
          blurRadius: 5,
          spreadRadius: 2,
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 15.0),
          child: Container(
              height: 60,
              width: 60,
              decoration: BoxDecoration(
                color: ThemeColors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 30, color: ThemeColors.charcoalGray)),
        ),
        Spacer(),
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0, left: 15.0),
          child: Text(
            title,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: ThemeColors.charcoalGray),
          ),
        ),
      ],
    ),
  );
}
