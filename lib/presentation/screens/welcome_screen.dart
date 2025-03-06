import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
                        color: Colors.black.withAlpha((0.7 * 255).toInt()),
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
                              color: Colors.white,
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.menu,
                            color: Colors.white,
                            size: 45,
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
                          color: Colors.white,
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
                            buildOptionCard(context, Icons.event_seat, "Rent", Colors.amber.shade100),
                            buildOptionCard(context, Icons.apartment, "Buy", Colors.yellow.shade200),
                            buildOptionCard(context, Icons.house, "Sell", Colors.green.shade100),
                            buildOptionCard(context, Icons.business, "Office", Colors.blue.shade100),
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
                          backgroundColor: Colors.green,
                          padding: EdgeInsets.symmetric(vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        onPressed: () => Navigator.pushNamed(context, Routes.searchCatalog1),
                        child: Text(
                          "Create an account",
                          style: TextStyle(fontSize: 18, color: Colors.white),
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
