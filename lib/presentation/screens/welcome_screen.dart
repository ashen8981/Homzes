import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/colors.dart';
import '../../core/routes/app_routes.dart';
import '../blocs/background_image_cubit.dart';
import '../../data/repositories/background_image_repository.dart';
import '../widgets/welcome_screen/option_card.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BackgroundImageCubit(BackgroundImageRepository())..fetchBackgroundImage(),
      child: Scaffold(
        body: Stack(
          children: [
            // Background Image using Firestore Data
            BlocBuilder<BackgroundImageCubit, BackgroundImageState>(
              builder: (context, state) {
                if (state is BackgroundImageLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is BackgroundImageLoaded) {
                  return Stack(
                    children: [
                      // Background Image
                      Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(state.image.img.toString()),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // Black Overlay with Opacity
                      Container(
                        color: ThemeColors.semiTransparentBlack,
                      ),
                    ],
                  );
                } else if (state is BackgroundImageError) {
                  return Center(child: Text("Error loading background"));
                } else {
                  return Center(child: Text("No background image available"));
                }
              },
            ),

            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // App Logo
                    Padding(
                      padding: const EdgeInsets.only(top: 20.0),
                      child: Row(
                        children: [
                          Text(
                            "Homzes",
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: ThemeColors.white,
                            ),
                          ),
                          Spacer(),
                          Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: ThemeColors.white, width: 2),
                            ),
                            child: IconButton(
                              icon: Icon(
                                Icons.menu,
                                color: ThemeColors.white,
                                size: 25,
                              ),
                              onPressed: () {},
                            ),
                          )
                        ],
                      ),
                    ),
                    Spacer(),
                    // Title Text
                    Center(
                      child: Text(
                        "Find the best\nplace for you",
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: ThemeColors.white,
                        ),
                      ),
                    ),
                    SizedBox(height: 35),
                    // Buttons (Rent, Buy, etc.)
                    SizedBox(
                      height: 200,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            buildOptionCard(context, Icons.event_seat_outlined, "Rent", ThemeColors.lightCream),
                            buildOptionCard(context, Icons.maps_home_work_outlined, "Buy", ThemeColors.paleYellow),
                            buildOptionCard(context, Icons.house, "Sell", ThemeColors.lightGreen),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 40),
                    // Create Account Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ThemeColors.forestGreen,
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () => Navigator.pushNamed(context, Routes.searchCatalog1),
                        child: Text(
                          "Create an account",
                          style: TextStyle(fontSize: 18, color: ThemeColors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
