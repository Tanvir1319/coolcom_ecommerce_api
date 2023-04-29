import 'package:coolcom/core/constants/my_colors.dart';
import 'package:coolcom/core/constants/widgets/my_app_bar.dart';
import 'package:coolcom/providers/auth_provider.dart';
import 'package:coolcom/route/route_manager.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    //problematic code----context.goNamed(RouteNames.HOME_PAGE);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 12.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                AppBarSection(),
                _LogoSection(),
                _LoginSignUpFormSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LogoSection extends StatelessWidget {
  _LogoSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32.0),
      child: Center(
        child: Image.asset(
          'assets/graphics/common/logo.png',
          width: 177.w,
        ),
      ),
    );
  }
}


class _LoginSignUpFormSection extends StatelessWidget {
  _LoginSignUpFormSection({super.key});
  final TextEditingController _usernameTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Username',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        TextField(
          controller: _usernameTextController,
          decoration: InputDecoration(
              hintText: 'Give your Username Here',
              fillColor: MyColors.inputBackground,
              filled: true,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 18.0, vertical: 26.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: Colors.transparent, width: 0),
              ),
              focusedBorder: OutlineInputBorder(
                gapPadding: 0.0,
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: Colors.transparent, width: 0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: Colors.transparent, width: 0),
              )),
        ),
        SizedBox(
          height: 24.h,
        ),
        Text(
          'Password',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        TextField(
          controller: _passwordTextController,
          obscureText: true,
          decoration: InputDecoration(
              hintText: 'Give Your Password Here',
              fillColor: MyColors.inputBackground,
              filled: true,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 18.0, vertical: 26.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: Colors.transparent, width: 0),
              ),
              focusedBorder: OutlineInputBorder(
                gapPadding: 0.0,
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: Colors.transparent, width: 0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: Colors.transparent, width: 0),
              )),
        ),
        SizedBox(
          height: 26.0,
        ),
        Consumer<AuthProvider>(
          builder: (context, authProvider, _) => authProvider.hasError
              ? Center(
                  child: Text(
                    '${authProvider.errorMessage}',
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                )
              : Container(),
        ),
        const SizedBox(
          height: 26.0,
        ),
        SizedBox(
          width: double.infinity,
          height: 56.h,
          child: ElevatedButton(
            onPressed: () async {
              String username = _usernameTextController.text;
              String password = _passwordTextController.text;
              bool isLoadingSuccedd =
                  await Provider.of<AuthProvider>(context, listen: false)
                      .login(username, password);
              if (isLoadingSuccedd) {
                context.goNamed(RouteNames.MAIN_PAGE);
              }
            },
            child: Consumer<AuthProvider>(
              builder: (context, authProvider, _) => authProvider.isLoading
                  ? CircularProgressIndicator()
                  : Text(
                      'Login',
                      style: TextStyle(
                          fontSize: 14.sp, fontWeight: FontWeight.bold),
                    ),
            ),
            style: ElevatedButton.styleFrom(
                elevation: 0.sp,
                backgroundColor: MyColors.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.r),
                )),
          ),
        ),
        SizedBox(
          height: 26.0,
        ),
        SizedBox(
          width: double.infinity,
          height: 56.h,
          child: ElevatedButton(
            onPressed: () {
              context.goNamed(RouteNames.MAIN_PAGE);
            },
            child: Text(
              'Signup',
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
            style: ElevatedButton.styleFrom(
                elevation: 0.sp,
                backgroundColor: MyColors.secondaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40.r),
                )),
          ),
        ),
      ],
    );
  }
}
