import 'package:coolcom/core/constants/my_colors.dart';
import 'package:coolcom/models/product_model.dart';
import 'package:coolcom/pages/main_page/providers/home_fragment_provider.dart';
import 'package:coolcom/route/route_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class HomeFragment extends StatelessWidget {
  const HomeFragment({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeFragmentProvider(),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 35.0, vertical: 20.0),
          child: CustomScrollView(
            slivers: [
              _AppBarHome(),
              _SearchBox(),
              CategoriesTab(),
              SliverToBoxAdapter(
                child: Consumer<HomeFragmentProvider>(
                  builder: (context, homeFragmentProvider, child) {
                    List<ProductModel> products = homeFragmentProvider.products;
                    return homeFragmentProvider.isProductLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: MyColors.primaryColor,
                            ),
                          )
                        : GridView.builder(
                            itemCount: homeFragmentProvider.products.length,
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisSpacing: 12.sp,
                              mainAxisSpacing: 12.sp,
                              childAspectRatio: 3 / 9,
                              crossAxisCount: 2,
                            ),
                            itemBuilder: (context, index) => ProductCard(
                                  onTap: () {
                                    context.goNamed(RouteNames.DETAILS,
                                    extra: products[index],
                                    );
                                  },
                                  title: (products[index].title!.length > 20
                                          ? "${products[index].title!.substring(0, 20)} ..."
                                          : products[index].title) ??
                                      'Nothing found',
                                  category:
                                      products[index].category ?? 'No category',
                                  price:
                                      "\$${products[index].price.toString()}",
                                  stars: '5.00',
                                  image: products[index].image ?? "No image",
                                ));
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String title;
  final String category;
  final String price;
  final String stars;
  final String image;
  final VoidCallback? onTap;
  const ProductCard({
    super.key,
    required this.category,
    required this.price,
    required this.stars,
    required this.title,
    required this.image,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: Container(
                alignment: Alignment.topRight,
                width: double.infinity,
                child: IconButton(
                  onPressed: () {},
                  icon: CircleAvatar(
                    backgroundColor: MyColors.primaryColor,
                    child: Icon(
                      Icons.favorite,
                      color: Colors.white,
                    ),
                  ),
                ),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18.r),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(image),
                    )),
              ),
            ),
            SizedBox(
              height: 12.sp,
            ),
            Expanded(
              flex: 2,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                      ),
                    ),
                    SizedBox(
                      height: 12.sp,
                    ),
                    Text(
                      category,
                      style: TextStyle(
                        color: MyColors.secondaryColor,
                        fontSize: 12.sp,
                      ),
                    ),
                    SizedBox(
                      height: 12.sp,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          price,
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Image.asset(
                              'assets/graphics/common/star.png',
                              width: 12.sp,
                            ),
                            Text(
                              stars,
                              style: TextStyle(fontSize: 18.sp),
                            ),
                          ],
                        ),
                      ],
                    ),
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

class CategoriesTab extends StatelessWidget {
  const CategoriesTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 24.sp),
        height: 110.sp,
        child: Consumer<HomeFragmentProvider>(
          builder: (context, homeFragmentProvider, child) =>
              homeFragmentProvider.isCategoryLoading
                  ? Center(
                      child: CircularProgressIndicator(
                        color: MyColors.primaryColor,
                      ),
                    )
                  : ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: homeFragmentProvider.categories.length,
                      itemBuilder: (context, index) => InkWell(
                        onTap: () => homeFragmentProvider
                            .changeProductCategoryTab(index),
                        child: CategoryTab(
                          icon: 'assets/graphics/common/icon_cat_all.png',
                          title: homeFragmentProvider.categories[index]
                              .toString()
                              .toUpperCase(),
                          isSelected:
                              index == homeFragmentProvider.selectedTabIndex,
                        ),
                      ),
                    ),
        ),
      ),
    );
  }
}

class CategoryTab extends StatelessWidget {
  const CategoryTab({
    super.key,
    required this.icon,
    required this.title,
    this.isSelected = false,
  });
  final String icon;
  final String title;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 12.0),
      padding: EdgeInsets.symmetric(vertical: 24.sp, horizontal: 20.sp),
      child: Row(
        children: [
          Image.asset(
            icon,
            //'assets/graphics/common/icon_cat_all.png'
            width: 18.w,
            color: isSelected ? Colors.white : MyColors.primaryColor,
          ),
          SizedBox(
            width: 8.sp,
          ),
          Text(
            title,
            style: TextStyle(
              color: isSelected ? Colors.white : MyColors.primaryColor,
            ),
          ),
        ],
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: isSelected ? MyColors.primaryColor : Colors.white,
        border: Border.all(color: MyColors.inputBackground),
      ),
    );
  }
}

class _SearchBox extends StatelessWidget {
  const _SearchBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 24.0),
        child: TextField(
          decoration: InputDecoration(
              prefixIcon: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/graphics/common/search_icon.png',
                  width: 24.w,
                ),
              ),
              hintText: 'Search',
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Color(0xffEDEDED),
                ),
                borderRadius: BorderRadius.circular(12.r),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(
                  color: Color(0xffEDEDED),
                ),
              )),
        ),
      ),
    );
  }
}

class _AppBarHome extends StatelessWidget {
  const _AppBarHome({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Hello Welcome!',
                style: TextStyle(
                  fontSize: 14.sp,
                ),
              ),
              Text(
                'Alex Bond',
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          CircleAvatar(
            backgroundImage:
                NetworkImage('https://www.w3schools.com/howto/img_avatar.png'),
          ),
        ],
      ),
    );
  }
}
