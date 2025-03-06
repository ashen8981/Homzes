import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';

PreferredSizeWidget buildSearchCatalog3AppBar(BuildContext context) {
  final double screenWidth = MediaQuery.of(context).size.width;
  final double screenHeight = MediaQuery.of(context).size.height;
  return PreferredSize(
    preferredSize: Size.fromHeight(screenHeight * 0.12),
    child: ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(screenWidth * 0.05),
        bottomRight: Radius.circular(screenWidth * 0.05),
      ),
      child: AppBar(
        backgroundColor: ThemeColors.lightGreen,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(screenHeight * 0.06),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.04,
              vertical: screenHeight * 0.02,
            ),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    color: ThemeColors.charcoalGray,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.menu, color: ThemeColors.white),
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: 15),
                buildSearchBar(screenWidth),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Widget buildSearchBar(double screenWidth) {
  return Container(
    height: 45,
    width: screenWidth * 0.75,
    decoration: BoxDecoration(
      color: ThemeColors.white,
      borderRadius: BorderRadius.circular(30),
    ),
    child: TextField(
      decoration: InputDecoration(
        hintText: "Search",
        prefixIcon: Icon(Icons.search, color: ThemeColors.charcoalGray),
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(vertical: 10),
      ),
    ),
  );
}
