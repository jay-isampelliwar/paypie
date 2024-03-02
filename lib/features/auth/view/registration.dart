import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:paypie/common_widgets/app_custom_button.dart';
import 'package:paypie/features/auth/provider/auth_provider.dart';
import 'package:provider/provider.dart';

import '../../../constants/degine_constants.dart';
import '../../../utils/validator.dart';
import '../../home/view/home.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _formKey = GlobalKey<FormState>();
  FocusNode firstNameNode = FocusNode();
  FocusNode lastNameNode = FocusNode();
  FocusNode emailNode = FocusNode();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  XFile? profilePicture;
  Future getImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      profilePicture = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(VERY_LARGE_SPACE),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Profile Details",
                  style: TextStyle(
                    fontSize: LARGE_FONT_SIZE,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: VERY_LARGE_SPACE),
                Center(
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          getImage();
                        },
                        child: Container(
                          clipBehavior: Clip.hardEdge,
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                  width: 2,
                                  color: Theme.of(context).primaryColor)),
                          child: profilePicture == null
                              ? const Icon(Icons.add)
                              : Image.file(
                                  File(profilePicture!.path),
                                  fit: BoxFit.cover,
                                ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: VERY_LARGE_SPACE),
                TextFormField(
                  focusNode: firstNameNode,
                  controller: firstNameController,
                  keyboardType: TextInputType.name,
                  validator: (firstName) => Validate.name(firstName!),
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(lastNameNode);
                  },
                  decoration: const InputDecoration(
                    hintText: "First Name",
                  ),
                ),
                const SizedBox(height: LARGE_SPACE),
                TextFormField(
                  focusNode: lastNameNode,
                  controller: lastNameController,
                  keyboardType: TextInputType.name,
                  validator: (lastName) => Validate.name(lastName!),
                  onFieldSubmitted: (_) {
                    FocusScope.of(context).requestFocus(emailNode);
                  },
                  decoration: const InputDecoration(
                    hintText: "Last Name",
                  ),
                ),
                const SizedBox(height: LARGE_SPACE),
                TextFormField(
                  focusNode: emailNode,
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: (email) => Validate.validateEmail(email!),
                  decoration: const InputDecoration(
                    hintText: "Email",
                  ),
                ),
                const Spacer(),
                Consumer<AuthProvider>(
                  builder: (context, provider, child) {
                    return AppCustomButton(
                      loading: provider.registerLoading,
                      onTap: () async {
                        if (_formKey.currentState!.validate() &&
                            profilePicture != null) {
                          FocusManager.instance.primaryFocus!.unfocus();

                          String firstName = firstNameController.text.trim();
                          String lastName = lastNameController.text.trim();
                          String email = emailController.text.trim();

                          bool status = await provider.registration(firstName,
                              lastName, email, profilePicture!, context);

                          if (status && mounted) {
                            profilePicture = null;

                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const HomeScreen(),
                                ),
                                (route) => false);
                          }
                        }
                      },
                      text: "Register",
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    super.dispose();
  }
}
