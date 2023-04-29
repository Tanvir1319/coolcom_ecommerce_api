import 'package:coolcom/core/constants/my_colors.dart';
import 'package:coolcom/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class DetailsPage extends StatelessWidget {
 final ProductModel product;
  const DetailsPage({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              _Header(
                imageUrl: product.image ?? 'none',
              ),
              _Title(title: product.title ?? 'No tittle',),
              Container(
                child: Text(
                 
                 product.description ?? 'No Description',
                 style: TextStyle(
                   fontSize: 18.sp,
                   color: MyColors.inputBackground,
                  ),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: SizedBox(
            width: double.infinity,
            height: 64.h,
            child: ElevatedButton(
              onPressed: () {},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/graphics/common/cart.png',
                    width: 32.w,
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  Text(
                    'Add to cart | '//\$${product.price}',
                   // style:
                       // TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
                 ),
                  SizedBox(
                    width: 12.w,
                  ),
                  Text(
                    '\$156',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w300,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                ],
              ),
              style: ElevatedButton.styleFrom(
                elevation: 0.sp,
                backgroundColor: MyColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.r),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  final String title;
  const _Title({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.sp),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'title',
              style: TextStyle(
                fontSize: 24.h,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                height: 48.h,
                width: 48.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(90.r),
                  border: Border.all(color: MyColors.borderColor),
                ),
                child: Icon(
                  Icons.remove,
                  color: MyColors.secondaryColor,
                ),
              ),
              Text(
                '1',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                height: 48.h,
                width: 48.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: MyColors.borderColor),
                ),
                child: Icon(
                  Icons.add,
                  color: MyColors.secondaryColor,
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final String imageUrl;
  const _Header({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 18.sp, horizontal: 24.sp),
              width: double.infinity,
              height: 400.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.r),
                  image: DecorationImage(
                    image: NetworkImage(
                       imageUrl,
                        ),
                   fit: BoxFit.cover,
                  )),
            ),
          ],
        ),
        InkWell(
          onTap: () => context.pop(),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 38.sp, horizontal: 44.sp),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  radius: 24.r,
                  backgroundColor: Colors.white,
                  child: Image.asset(
                    'assets/graphics/common/back_arrow.png',
                    width: 8.w,
                  ),
                ),
                CircleAvatar(
                  radius: 24.r,
                  backgroundColor: Colors.white,
                  child: Image.asset(
                    'assets/graphics/common/heart.png',
                    width: 18.w,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
