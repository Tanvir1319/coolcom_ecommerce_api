import 'package:coolcom/core/constants/assets_locations.dart';
import 'package:coolcom/core/constants/my_colors.dart';
import 'package:coolcom/pages/main_page/providers/main_page_provider.dart';
import 'package:coolcom/pages/main_page/ui/fragments/cart_fragment%20.dart';
import 'package:coolcom/pages/main_page/ui/fragments/home_fragment.dart';
import 'package:coolcom/pages/main_page/ui/fragments/wish_list_fragment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MainPageProvider(),
      builder: (context, child) => Scaffold(
        body: Consumer<MainPageProvider>(
          builder: (context, mainPageProvider, child) {
            if (mainPageProvider.getSelectedIndex() == 0) {
              return HomeFragment();
            }
            if (mainPageProvider.getSelectedIndex() == 1) {
              return CartFragment();
            }
            if (mainPageProvider.getSelectedIndex() == 2) {
              return WishlistFragment();
            }
            return Center(
              child: Text('Nothing to show'),
            );
          },
        ),
        bottomNavigationBar: Consumer<MainPageProvider>(
          builder: (context, mainPageProvider, child) => Padding(
            padding: const EdgeInsets.all(12.0),
            child: Theme(
              data: Theme.of(context).copyWith(canvasColor: MyColors.primaryColor),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40.0),
                child: BottomNavigationBar(
                  showSelectedLabels: false,
                  showUnselectedLabels: false,
                    currentIndex: mainPageProvider.getSelectedIndex(),
                    onTap: (index) => mainPageProvider.setTab(index),
                    items:  [
                      BottomNavigationBarItem
                      (
                        icon: SizedBox(
                        height: 44.sp,
                        width: 44.sp,
                        child: Image.asset(AssetLocation.HOME_ICON),
                        ),
                         label: 'Home'),
                      BottomNavigationBarItem(
                         icon: SizedBox(
                        height: 44.sp,
                        width: 44.sp,
                        child: Image.asset(AssetLocation.CART_ICON),
                        ),
                         label: 'Cart'),
                      BottomNavigationBarItem(
                        icon: SizedBox(
                        height: 44.sp,
                        width: 44.sp,
                        child: Image.asset(AssetLocation.WISHLIST_ICON),
                        ),
                         label: 'Wishlist'),
                    ]),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
