import 'package:flutter/material.dart';

PreferredSizeWidget buildSearchCatalog1AppBar() {
  return PreferredSize(
    preferredSize: Size.fromHeight(120),
    child: ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(20),
      ),
      child: AppBar(
        backgroundColor: Colors.yellow.shade200,
        elevation: 0,
        actions: [
          Row(
            children: [
              Text(
                "Hi, Stanislav",
                style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(width: 8),
              CircleAvatar(
                backgroundColor: Colors.grey.shade300,
                child: Text("S", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
              ),
            ],
          ),
          SizedBox(width: 15),
        ],
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.black),
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
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: "Search",
                      hintStyle: TextStyle(color: Colors.black54),
                      prefixIcon: Icon(Icons.search, color: Colors.black54),
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
