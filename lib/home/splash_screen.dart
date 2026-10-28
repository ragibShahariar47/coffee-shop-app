import 'package:coffee_shop_online/constants/app_colors.dart';
import 'package:coffee_shop_online/constants/app_images.dart';
import 'package:coffee_shop_online/constants/widgets/custom_text.dart';
import 'package:coffee_shop_online/constants/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:slide_to_act/slide_to_act.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            AppImages.splashScreenImage,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          SplashHeading(),
          Positioned(
            top: 108, // Adjust this value as needed
            left: 30,
            child: SplashBody(screenWidth: screenWidth),
          ),
          Positioned(
            bottom: 50,
            left: screenWidth < 900 ? screenWidth * 0.1 : screenWidth * 0.3,
            right: screenWidth < 900 ? screenWidth * 0.1 : screenWidth * 0.3,
            child: FooterActionWidget(
              screenWidth: screenWidth,
              onActionCompleted: () => context.goNamed('home'),
            ),
          ),
        ],
      ),
    );
  }
}

class FooterActionWidget extends StatelessWidget {
  const FooterActionWidget({
    super.key,
    required this.screenWidth,
    this.onActionCompleted,
  });

  final double screenWidth;
  final VoidCallback? onActionCompleted;

  @override
  Widget build(BuildContext context) {
    return SlideAction(
      outerColor: AppColors.primaryColor,
      innerColor: Colors.white,
      sliderButtonIcon: const Icon(
        Icons.arrow_forward,
        color: AppColors.primaryColor,
      ),
      text: 'Get Started',
      textStyle: TextStyle(
        color: Colors.white,
        fontSize: screenWidth < 1100 ? 16 : 20,
      ),
      onSubmit: () {
        if (onActionCompleted != null) {
          onActionCompleted!();
        }
        return null;
      },
    );
  }
}

class SplashBody extends StatelessWidget {
  const SplashBody({super.key, required this.screenWidth});

  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidth * 0.55, // Adjust this value as needed
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: screenWidth < 1100 ? 0.0 : 20.0,
        ),
        child: Column(
          children: [
            CustomText(
              text: 'Exceptional coffee for a brighter you',
              fontSize: screenWidth < 1100 ? 34 : 50,
              isBold: true,
            ),
            SizedBox(height: 10),
            CustomText(
              text: 'Discover handcrafted coffee made with love and fineast beans.',
              fontSize: screenWidth < 1100 ? 18 : 24,
              isBold: false,
              color: AppColors.primaryColor.withAlpha(180),
            ),
          ],
        ),
      ),
    );
  }
}

class SplashHeading extends StatelessWidget {
  const SplashHeading({super.key});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.05,
        vertical: 8.0,
      ),
      child: Row(
        children: [
          Logo(),
          Spacer(),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondaryColor,
              foregroundColor: AppColors.primaryColor,
            ),
            child: Text('Skip'),
          ),
        ],
      ),
    );
  }
}
