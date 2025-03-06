import 'package:flutter/material.dart';

PreferredSizeWidget buildSearchCatalog3AppBar() {
  return PreferredSize(
    preferredSize: Size.fromHeight(100),
    child: ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
      child: AppBar(
        backgroundColor: Colors.green.shade200,
        elevation: 0,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    icon: Icon(Icons.menu, color: Colors.white),
                    onPressed: () {},
                  ),
                ),
                SizedBox(width: 15),
                buildSearchBar(),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

Widget buildSearchBar() {
  return Container(
    height: 45,
    width: 300,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(30),
      boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 1)],
    ),
    child: TextField(
      decoration: InputDecoration(
        hintText: "Search",
        prefixIcon: Icon(Icons.search, color: Colors.black54),
        border: InputBorder.none,
        contentPadding: EdgeInsets.symmetric(vertical: 10),
      ),
    ),
  );
}
