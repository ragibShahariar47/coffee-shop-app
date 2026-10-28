import 'package:coffee_shop_online/constants/app_colors.dart';
import 'package:coffee_shop_online/route/app_route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _expansibleController = ExpansibleController();

  @override
  void dispose() {
    _expansibleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final cartItemCount = 3; 
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackgroundColor,
        body: SizedBox(
          height: 60,
          child: Row(
            children: [
              SizedBox(width: screenWidth > 1100? 300 : screenWidth * 0.04),
              LocationPane(expansibleController: _expansibleController),
              Spacer(),
              Badge(
                label: Text(cartItemCount.toString()),
                backgroundColor: AppColors.tertiaryColor,
                child: IconButton(
                  icon: Icon(
                    Icons.shopping_cart_outlined,
                    color: AppColors.primaryColor,
                  ),
                  onPressed: () {
                    // Handle shopping cart button press
                  },
                ),
              ),
              SizedBox(width: 20),
              Container(
                width: 40,
                height: 40,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primaryColor,
                ),
                child: Image.asset(
                  'assets/images/profile.png',
                ), // Replace with your profile image asset
              ),
              SizedBox(width: screenWidth > 1100? 300: screenWidth * 0.04),
            ],
          ),
        ),
      ),
    );
  }
}

class LocationPane extends StatelessWidget {
  const new({super.key, required this._expansibleController});

  final ExpansibleController _expansibleController;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      child: Expansible(
        headerBuilder: (BuildContext context, Animation<double> animation) {
          return GestureDetector(
            onTap: () {
              if (_expansibleController.isExpanded) {
                _expansibleController.collapse();
              } else {
                _expansibleController.expand();
              }
            },
            child: SizedBox(
              height: 30,
              child: Row(
                children: [
                  Icon(
                    Icons.location_on,
                    size: 16,
                    color: AppColors.tertiaryColor,
                  ),
                  Text('Dhaka, Bangladesh', style: TextStyle(color: AppColors.primaryColor)),
                  Icon(
                    _expansibleController.isExpanded
                        ? Icons.arrow_drop_up
                        : Icons.arrow_drop_down,
                    size: 24,
                    color: AppColors.tertiaryColor,
                  ),
                ],
              ),
            ),
          );
        },
        bodyBuilder: (BuildContext context, Animation<double> animation) {
          return SizeTransition(
            alignment: Alignment.centerLeft,
            sizeFactor: animation,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withAlpha(100),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      context.goNamed(
                        AppRouteName.location.name,
                      ); // Handle location selection
                    },
                    child: Text('select location 𖣨'),
                  ),
                ],
              ),
            ),
          );
        },
        controller: _expansibleController,
      ),
    );
  }
}
