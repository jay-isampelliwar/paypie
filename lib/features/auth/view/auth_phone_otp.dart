import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:paypie/constants/degine_constants.dart';
import 'package:paypie/features/auth/provider/auth_provider.dart';
import 'package:paypie/utils/screen_config.dart';
import 'package:provider/provider.dart';

import '../../../common_widgets/app_custom_button.dart';
import '../../../common_widgets/or_separator.dart';
import '../../../utils/validator.dart';
import 'otp.dart';

class PhoneLogin extends StatefulWidget {
  const PhoneLogin({super.key});

  @override
  State<PhoneLogin> createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController phoneController =
      TextEditingController(text: "7030356059");
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(VERY_LARGE_SPACE),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Center(child: SvgPicture.asset("assets/icons/login.svg")),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Enter your number to receive OTP",
                        style: TextStyle(
                          fontSize: LARGE_FONT_SIZE,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: LARGE_SPACE),
                      Theme(
                        data: ThemeData(),
                        child: TextFormField(
                          controller: phoneController,
                          keyboardType: TextInputType.phone,
                          validator: (phone) => Validate.phoneNumber(phone!),
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(10),
                          ],
                          decoration: const InputDecoration(
                            hintText: "Mobile number",
                          ),
                        ),
                      ),
                      const SizedBox(height: VERY_LARGE_SPACE),
                      const SizedBox(height: VERY_LARGE_SPACE),
                      Consumer<AuthProvider>(
                        builder: (context, provider, child) {
                          return AppCustomButton(
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                FocusManager.instance.primaryFocus!.unfocus();
                                String phoneNumber =
                                    "+91${phoneController.text.trim()}";
                                await provider.sendOtp(phoneNumber, context);
                              }
                            },
                            text: "Send OTP",
                            loading: provider.sendOtpLoading,
                          );
                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    phoneController.dispose();
    super.dispose();
  }
}
