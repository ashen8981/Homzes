import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homzes_app/core/routes/app_routes.dart';
import 'package:homzes_app/data/models/property_model.dart';
import '../../core/constants/colors.dart';
import '../../data/repositories/property_repository.dart';
import '../blocs/property_cubit.dart';
import '../blocs/property_state.dart';
import '../widgets/search_catelog_1/custom_appbar.dart';

class SearchCatalog1Screen extends StatelessWidget {
  const SearchCatalog1Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: buildSearchCatalog1AppBar(),
      body: BlocProvider(
        create: (context) => PropertyCubit(PropertyRepository())..fetchProperties(),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              buildSectionHeader("Featured", () => Navigator.pushNamed(context, Routes.searchCatalog3)),
              SizedBox(height: 10),
              buildFeaturedList(screenWidth),
              SizedBox(height: 10),
              buildSectionHeader("New offers", () => Navigator.pushNamed(context, Routes.searchCatalog3)),
              SizedBox(height: 15),
              Expanded(child: buildNewOffers(screenWidth, screenHeight)),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSectionHeader(String title, VoidCallback onViewAll) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, color: ThemeColors.charcoalGray)),
        GestureDetector(
          onTap: onViewAll,
          child: Text("View all",
              style: TextStyle(fontSize: 14, color: ThemeColors.mediumGray, fontWeight: FontWeight.w600)),
        ),
      ],
    );
  }

  Widget buildFeaturedList(double screenWidth) {
    return BlocBuilder<PropertyCubit, PropertyState>(
      builder: (context, state) {
        if (state is PropertyLoading) {
          return Center(child: CircularProgressIndicator());
        } else if (state is PropertyLoaded) {
          return SizedBox(
            height: 240,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: state.properties.length,
              itemBuilder: (context, index) {
                final property = state.properties[index];
                return buildFeaturedItem(property, screenWidth * 0.4);
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

  Widget buildFeaturedItem(PropertyModel property, double width) {
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
                  height: 170,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(Icons.error, size: 50, color: ThemeColors.red);
                  },
                ),
                Positioned(
                  bottom: 5,
                  right: 5,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: ThemeColors.white,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(property.price, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 12)),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 5),
          SizedBox(
            width: width,
            child: Text(
              property.title,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              maxLines: 2, // Allow up to two lines
              overflow: TextOverflow.ellipsis, // Show ellipsis if text overflows
              softWrap: true, // Enable soft wrap to allow text to break into new lines
            ),
          )
        ],
      ),
    );
  }

  Widget buildNewOffers(double screenWidth, double screenHeight) {
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
              return buildNewOfferItem(property, screenWidth, screenHeight);
            },
          );
        } else if (state is PropertyError) {
          return Center(child: Text("Error: ${state.error}"));
        }
        return Center(child: Text("No properties available"));
      },
    );
  }

  Widget buildNewOfferItem(PropertyModel property, double screenWidth, double screenHeight) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: ThemeColors.white,
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
                    return Icon(Icons.error, size: 50, color: ThemeColors.red);
                  },
                ),
              ),
              Positioned(
                top: 10,
                right: 10,
                child: Icon(Icons.favorite_border, color: ThemeColors.white, size: 30),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(property.title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    Icon(Icons.star_border, color: ThemeColors.forestGreen),
                    Padding(
                      padding: const EdgeInsets.only(left: 2.0, right: 2.0),
                      child: Text("4.9",
                          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: ThemeColors.charcoalGray)),
                    ),
                    Text("(29 reviews)",
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.normal, color: ThemeColors.mediumGray)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
