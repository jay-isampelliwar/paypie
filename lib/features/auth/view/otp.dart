import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:paypie/features/auth/provider/auth_provider.dart';
import 'package:paypie/features/auth/view/registration.dart';
import 'package:provider/provider.dart';

import '../../../common_widgets/app_custom_button.dart';
import '../../../constants/degine_constants.dart';
import '../../../utils/validator.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({required this.phoneNumber, super.key});
  final String phoneNumber;
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController otpController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(VERY_LARGE_SPACE),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Verification Code",
                    style: TextStyle(
                      fontSize: LARGE_FONT_SIZE,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: VERY_LARGE_SPACE),
                  const Padding(
                    padding: EdgeInsets.only(right: VERY_LARGE_SPACE),
                    child: Text(
                      "We have sent you the verification code on your mobile number.",
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: MEDIUM_FONT_SIZE,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: LARGE_SPACE),
                  Theme(
                    data: ThemeData(),
                    child: TextButton.icon(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.black,
                      ),
                      label: Text(
                        widget.phoneNumber,
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: MEDIUM_FONT_SIZE,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: VERY_LARGE_SPACE),
                  Theme(
                    data: ThemeData(),
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        controller: otpController,
                        keyboardType: TextInputType.phone,
                        validator: (otp) => Validate.otp(otp!),
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(6),
                        ],
                        decoration: const InputDecoration(
                          hintText: "OTP",
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: VERY_LARGE_SPACE),
                  const SizedBox(height: VERY_LARGE_SPACE),
                  Consumer<AuthProvider>(
                    builder: (context, provider, child) {
                      return AppCustomButton(
                        loading: provider.verifyLoading,
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            FocusManager.instance.primaryFocus!.unfocus();
                            String otp = otpController.text.trim();
                            await provider.verifyOtp(otp, context);
                          }
                        },
                        text: "Verify",
                      );
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    otpController.dispose();
    super.dispose();
  }
}
