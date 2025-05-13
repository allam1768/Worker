import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../values/app_color.dart';
import '../../global-component/CustomButton.dart';
import '../../global-component/CustomTextField.dart';
import 'login_controller.dart';

class LoginView extends StatelessWidget {
  LoginView({super.key});

  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.background,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.05),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.12),
                Center(
                  child: SvgPicture.asset(
                    'assets/images/login_illustration.svg',
                    width: MediaQuery.of(context).size.width * 0.8,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.15),

                Text(
                  "Login",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.08,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.005),
                Text(
                  "Please Sign in to continue.",
                  style: TextStyle(
                    fontSize: MediaQuery.of(context).size.width * 0.05,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),

                // Username
                CustomTextField(
                  hintText: 'Username',
                  svgIcon: 'assets/icons/username.svg',
                  controller: controller.nameController,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),

                // Password
                Obx(() => CustomTextField(
                      hintText: 'Password',
                      svgIcon: 'assets/icons/password.svg',
                      isPassword: true,
                      isPasswordHidden: controller.isPasswordHidden.value,
                      onSuffixTap: controller.togglePasswordVisibility,
                      controller: controller.passwordController,
                    )),
                SizedBox(height: MediaQuery.of(context).size.height * 0.015),

                // Error Login - tetep ada tapi transparan kalau ga ada error
                Obx(() => Padding(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).size.height * 0.015),
                      child: Center(
                        child: Text(
                          controller.loginError.value.isNotEmpty
                              ? controller.loginError.value
                              : ' ', // biar space tetep ada
                          style: TextStyle(
                            color: controller.loginError.value.isNotEmpty
                                ? Colors.red
                                : Colors.transparent, // ilangin warnanya
                            fontSize: MediaQuery.of(context).size.width * 0.035,
                          ),
                        ),
                      ),
                    )),

                // Button Login
                CustomButton(
                  text: 'Sign In',
                  onPressed: controller.login,
                  backgroundColor: AppColor.btnoren,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
