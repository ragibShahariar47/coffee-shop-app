import 'package:coffee_shop_online/constants/app_colors.dart';
import 'package:coffee_shop_online/constants/widgets/custom_text.dart';
import 'package:coffee_shop_online/constants/widgets/veriable_padding.dart';
import 'package:coffee_shop_online/model/coffee_product.dart';
import 'package:coffee_shop_online/route/app_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const new({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _expansibleController = ExpansibleController();
  CoffeeProduct? selectedProduct;

  @override
  void dispose() {
    _expansibleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    final cartItemCount = 3;
    final products = [
      CoffeeProduct(
        id: '1001',
        name: 'Espresso',
        description: 'good coffee',
        category: 'coffee',
        additionalText: 'contains caffain',
      ),
      CoffeeProduct(
        id: '1002',
        name: 'Latte',
        description: 'with oat milk and best coffee',
        category: 'coffee',
        additionalText: 'contains caffain',
      ),
      CoffeeProduct(
        id: '1003',
        name: 'Iced Coffee',
        description: 'Regular coffee with iced.',
        category: 'coffee',
        additionalText: 'contains caffain',
      ),
    ];

    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.scaffoldBackgroundColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
          child: Column(
            spacing: 6,
            children: [
              AppBarWidget(
                screenWidth: screenWidth,
                expansibleController: _expansibleController,
                cartItemCount: cartItemCount,
              ),
              HomeGreetingsTextWidget(screenWidth: screenWidth),
              SearchBarWidget(
                screenWidth: screenWidth,
                products: products,
                onItemSelected: (matchedItem) {
                  setState(() {
                    selectedProduct = matchedItem;
                  });
                  debugPrint('${selectedProduct?.name}');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchBarWidget extends StatelessWidget {
  const new({
    super.key,
    required this.screenWidth,
    required this.products,
    required this.onItemSelected,
  });

  final double screenWidth;
  final List<CoffeeProduct> products;
  final ValueChanged<CoffeeProduct> onItemSelected;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 500,
      height: screenWidth < 1100 ? 50 : 60,
      child: Row(
        spacing: 20,
        children: [
          Expanded(
            child: SearchAnchor.bar(
              barElevation: WidgetStateProperty.all(2),
              barHintText: "Search For Coffee, drinks...",
              barHintStyle: WidgetStateProperty.all(
                TextStyle(fontWeight: .normal, color: Colors.black54),
              ),
              barBackgroundColor: WidgetStateProperty.all(
                AppColors.scaffoldForegroundColor,
              ),
              viewBackgroundColor: AppColors.scaffoldForegroundColor,

              suggestionsBuilder: (context, controller) {
                final String input = controller.value.text;
                return products
                    .where(
                      (CoffeeProduct item) =>
                          item.name.toLowerCase().contains(input),
                    )
                    .map(
                      (CoffeeProduct matchedItem) => ListTile(
                        title: Text(matchedItem.name),
                        onTap: () {
                          onItemSelected(matchedItem);
                          controller.closeView(matchedItem.name);
                        },
                      ),
                    )
                    .toList();
              },
            ),
          ),
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: Text("Not implimented yet"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          context.pop();
                        },
                        child: Text('Okay'),
                      ),
                    ],
                  );
                },
              );
            },
            child: Card(
              elevation: 2,
              color: AppColors.scaffoldForegroundColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(50)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Icon(Icons.tune, color: AppColors.primaryColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class HomeGreetingsTextWidget extends StatelessWidget {
  const new({super.key, this.fontSize = 34.0, required this.screenWidth});

  final double fontSize;
  final double screenWidth;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: screenWidth * .9,
      child: screenWidth > 500.0
          ? FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                children: [
                  veriablePadding(screenWidth: screenWidth),
                  CustomText(
                    text: 'Find your',
                    fontSize: screenWidth > 1100.0 ? fontSize + 10 : fontSize,
                    color: AppColors.primaryColor,
                    isBold: true,
                  ),
                  SizedBox(width: 20),
                  CustomText(
                    text: 'perfect coffee!',
                    fontSize: screenWidth > 1100.0 ? fontSize + 10 : fontSize,
                    color: AppColors.tertiaryColor,
                    isBold: true,
                  ),
                  veriablePadding(screenWidth: screenWidth),
                ],
              ),
            )
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'Find your',
                  fontSize: fontSize,
                  color: AppColors.primaryColor,
                  isBold: true,
                ),
                CustomText(
                  text: 'perfect coffee!',
                  fontSize: fontSize,
                  color: AppColors.tertiaryColor,
                  isBold: true,
                ),
              ],
            ),
    );
  }
}

class AppBarWidget extends StatelessWidget {
  const new({
    super.key,
    required this.screenWidth,
    required this._expansibleController,
    required this.cartItemCount,
  });

  final double screenWidth;
  final ExpansibleController _expansibleController;
  final int cartItemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Row(
        children: [
          veriablePadding(screenWidth: screenWidth),
          LocationPane(expansibleController: _expansibleController),
          Spacer(),
          CartIcon(cartItemCount: cartItemCount),
          SizedBox(width: 20),
          ProfileIcon(),
          veriablePadding(screenWidth: screenWidth),
        ],
      ),
    );
  }
}

class ProfileIcon extends StatelessWidget {
  const new({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}

class CartIcon extends StatelessWidget {
  const new({super.key, required this.cartItemCount});

  final int cartItemCount;

  @override
  Widget build(BuildContext context) {
    return Badge(
      label: Text(cartItemCount.toString()),
      backgroundColor: AppColors.tertiaryColor,
      child: IconButton(
        icon: Icon(Icons.shopping_cart_outlined, color: AppColors.primaryColor),
        onPressed: () {
          // Handle shopping cart button press
        },
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
                  Text(
                    'Dhaka, Bangladesh',
                    style: TextStyle(color: AppColors.primaryColor),
                  ),
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
