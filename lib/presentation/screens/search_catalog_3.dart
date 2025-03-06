import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:homzes_app/data/models/property_model.dart';
import '../../core/constants/colors.dart';
import '../../data/repositories/property_repository.dart';
import '../blocs/property_cubit.dart';
import '../blocs/property_state.dart';
import '../widgets/search_catelog_3/custom_appbar.dart';

class SearchCatalog3Screen extends StatelessWidget {
  const SearchCatalog3Screen({super.key});

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: ThemeColors.white,
      appBar: buildSearchCatalog3AppBar(context),
      body: BlocProvider(
        create: (context) => PropertyCubit(PropertyRepository())..fetchProperties(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04, vertical: screenHeight * 0.02),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: screenHeight * 0.011),
              Align(alignment: Alignment.center, child: buildSectionHeader("Popular rent offers")),
              SizedBox(height: screenHeight * 0.017),
              Expanded(child: buildOffersList(screenWidth, screenHeight)),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSectionHeader(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 18, color: ThemeColors.charcoalGray, fontWeight: FontWeight.w700),
    );
  }

  Widget buildOffersList(double screenWidth, double screenHeight) {
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
              return buildOfferItem(property, screenWidth, screenHeight);
            },
          );
        } else if (state is PropertyError) {
          return Center(child: Text("Error: ${state.error}"));
        }
        return Center(child: Text("No properties available"));
      },
    );
  }

  Widget buildOfferItem(PropertyModel property, double screenWidth, double screenHeight) {
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        color: ThemeColors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(15), bottom: Radius.circular(15)),
                child: Image.network(
                  property.image.toString(),
                  width: double.infinity,
                  height: screenHeight * 0.24,
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
              Positioned(
                bottom: 10,
                left: 10,
                child: Row(
                  children: [
                    buildTag(property.beds, screenWidth, screenHeight),
                    SizedBox(width: screenWidth * 0.02),
                    buildTag(property.baths, screenWidth, screenHeight),
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(property.title,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: ThemeColors.charcoalGray)),
                    Spacer(),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: property.price,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: ThemeColors.charcoalGray,
                            ),
                          ),
                          TextSpan(
                            text: " / mo",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: ThemeColors.charcoalGray,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.005),
                Text(property.location,
                    style: TextStyle(fontSize: 14, color: ThemeColors.mediumGray, fontWeight: FontWeight.w400)),
                SizedBox(height: screenHeight * 0.01),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTag(String text, double screenWidth, double screenHeight) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.02, vertical: screenHeight * 0.005),
      decoration: BoxDecoration(
        color: ThemeColors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        text,
        style: TextStyle(color: ThemeColors.charcoalGray, fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }
}
