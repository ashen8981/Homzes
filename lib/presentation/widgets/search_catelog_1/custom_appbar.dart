import 'package:flutter/material.dart';
import '../../../core/constants/colors.dart';

PreferredSizeWidget buildSearchCatalog1AppBar() {
  return PreferredSize(
    preferredSize: Size.fromHeight(120),
    child: ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
      child: AppBar(
        backgroundColor: ThemeColors.paleYellow,
        elevation: 0,
        actions: [
          Row(
            children: [
              Text(
                "Hi, Stanislav",
                style: TextStyle(color: ThemeColors.charcoalGray, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 12),
              Stack(
                clipBehavior: Clip.none,
                children: [
                  CircleAvatar(
                    backgroundColor: ThemeColors.gray,
                    child: Text(
                      "S",
                      style: TextStyle(fontWeight: FontWeight.bold, color: ThemeColors.charcoalGray),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: ThemeColors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          SizedBox(width: 15),
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
                  height: 40,
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
                      contentPadding: EdgeInsets.symmetric(vertical: 0),
                    ),
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}
