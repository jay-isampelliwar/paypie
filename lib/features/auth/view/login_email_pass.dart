// import 'package:flutter/material.dart';
// import 'package:paypie/common_widgets/app_custom_button.dart';
// import 'package:paypie/constants/degine_constants.dart';
// import 'package:paypie/utils/validator.dart';

// import '../../../common_widgets/or_separator.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// // }

// class _LoginScreenState extends State<LoginScreen> {
//   final _formKey = GlobalKey<FormState>();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   final ValueNotifier<bool> isHidePass = ValueNotifier(true);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Padding(
//         padding: const EdgeInsets.all(LARGE_SPACE),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               TextFormField(
//                 validator: (email) => Validate.validateEmail(email!),
//                 decoration: const InputDecoration(
//                   hintText: "Email",
//                 ),
//               ),
//               const SizedBox(height: MEDIUM_SPACE),
//               ValueListenableBuilder(
//                 valueListenable: isHidePass,
//                 builder: (context, value, child) {
//                   return TextFormField(
//                     validator: (password) => Validate.password(password!),
//                     obscureText: isHidePass.value,
//                     decoration: InputDecoration(
//                       hintText: "Password",
//                       suffixIcon: IconButton(
//                         onPressed: () {
//                           isHidePass.value = !isHidePass.value;
//                         },
//                         icon: Icon(
//                           isHidePass.value
//                               ? Icons.visibility
//                               : Icons.visibility_off_rounded,
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//               const SizedBox(height: LARGE_SPACE),
//               AppCustomButton(
//                 onTap: () {
//                   if (_formKey.currentState!.validate()) {}
//                 },
//                 text: "Login",
//                 loading: false,
//               ),
//               const SizedBox(height: VERY_LARGE_SPACE),
//               const OrSeparator(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     emailController.dispose();
//     passwordController.dispose();
//     super.dispose();
//   }
// }
