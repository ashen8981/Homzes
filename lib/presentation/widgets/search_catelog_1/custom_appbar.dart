import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';

PreferredSizeWidget buildSearchCatalog1AppBar(BuildContext context) {
  final double screenWidth = MediaQuery.of(context).size.width;
  final double screenHeight = MediaQuery.of(context).size.height;
  return PreferredSize(
    preferredSize: Size.fromHeight(screenHeight * 0.15),
    child: ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(screenWidth * 0.05),
        bottomRight: Radius.circular(screenWidth * 0.05),
      ),
      child: AppBar(
        backgroundColor: ThemeColors.paleYellow,
        elevation: 0,
        actions: [
          Row(
            children: [
              Text(
                "Hi, Stanislav",
                style: TextStyle(color: ThemeColors.charcoalGray, fontSize: 16, fontWeight: FontWeight.w600),
              ),
              SizedBox(width: screenWidth * 0.03),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    backgroundColor: ThemeColors.gray,
                    child: Text(
                      "S",
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: ThemeColors.charcoalGray),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: ThemeColors.customRed,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(width: screenWidth * 0.04),
        ],
        leading: IconButton(
          icon: Icon(Icons.menu, color: ThemeColors.charcoalGray),
          onPressed: () {},
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                Container(
                  height: 45,
                  decoration: BoxDecoration(
                    color: ThemeColors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search",
                      hintStyle: TextStyle(color: ThemeColors.charcoalGray),
                      prefixIcon: Icon(Icons.search, color: ThemeColors.charcoalGray),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
