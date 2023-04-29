import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBarSection extends StatelessWidget {
  AppBarSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello Welcome',
              style: TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 14.sp,
              ),
            ),
            Text(
              'Lets Login or Signup',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        CircleAvatar(
          backgroundImage: AssetImage('assets/graphics/common/avatar.png'),
        ),
      ],
    );
  }
}
