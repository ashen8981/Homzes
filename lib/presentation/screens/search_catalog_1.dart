import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homzes_app/core/routes/app_routes.dart';
import 'package:homzes_app/data/models/property_model.dart';
import '../../data/repositories/property_repository.dart';
import '../blocs/property_cubit.dart';
import '../blocs/property_state.dart';

class SearchCatalog1Screen extends StatelessWidget {
  const SearchCatalog1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: _buildAppBar(),
      body: BlocProvider(
        create: (context) => PropertyCubit(PropertyRepository())..fetchProperties(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchBar(),
              SizedBox(height: 20),
              _buildSectionHeader("Featured", () => Navigator.pushNamed(context, Routes.searchCatalog3)),
              SizedBox(height: 10),
              _buildFeaturedList(screenWidth),
              SizedBox(height: 20),
              _buildSectionHeader("New offers", () => Navigator.pushNamed(context, Routes.searchCatalog3)),
              SizedBox(height: 10),
              Expanded(child: _buildNewOffers(screenWidth, screenHeight)),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.yellow.shade200,
      title: Text(
        "Hi, Stanislav",
        style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
      ),
      actions: [
        CircleAvatar(
          backgroundColor: Colors.grey.shade300,
          child: Text("S", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black)),
        ),
        SizedBox(width: 15),
      ],
      leading: IconButton(
        icon: Icon(Icons.menu, color: Colors.black),
        onPressed: () {},
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
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
          contentPadding: EdgeInsets.symmetric(vertical: 15),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title, VoidCallback onViewAll) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        GestureDetector(
          onTap: onViewAll,
          child: Text("View all", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  Widget _buildFeaturedList(double screenWidth) {
    return BlocBuilder<PropertyCubit, PropertyState>(
      builder: (context, state) {
        if (state is PropertyLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is PropertyLoaded) {
          return SizedBox(
            height: 140,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.properties.length,
              itemBuilder: (context, index) {
                final property = state.properties[index];
                return _buildFeaturedItem(property, screenWidth * 0.4);
              },
            ),
          );
        } else if (state is PropertyError) {
          return Center(child: Text("Error: ${state.error}"));
        }
        return Center(child: Text("No properties found"));
      },
    );
  }

  Widget _buildFeaturedItem(PropertyModel property, double width) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Stack(
              children: [
                Image.network(
                  property.image.toString(),
                  width: width,
                  height: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.error, size: 50, color: Colors.red);
                  },
                ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(property.price, style: TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewOffers(double screenWidth, double screenHeight) {
    return BlocBuilder<PropertyCubit, PropertyState>(
      builder: (context, state) {
        if (state is PropertyLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is PropertyLoaded) {
          return ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: state.properties.length,
            itemBuilder: (context, index) {
              final property = state.properties[index];
              return _buildNewOfferItem(property, screenWidth, screenHeight);
            },
          );
        } else if (state is PropertyError) {
          return Center(child: Text("Error: ${state.error}"));
        }
        return Center(child: Text("No properties available"));
      },
    );
  }

  Widget _buildNewOfferItem(PropertyModel property, double screenWidth, double screenHeight) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5, spreadRadius: 2)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.network(
                  property.image.toString(),
                  width: screenWidth,
                  height: screenHeight * 0.3,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.error, size: 50, color: Colors.red);
                  },
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Icon(Icons.favorite_border, color: Colors.white, size: 30),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(property.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                SizedBox(height: 5),
                Text("\$${property.price}",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.green)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
