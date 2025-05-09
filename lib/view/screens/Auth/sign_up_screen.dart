// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:binrushd_medical_center/constants/constants.dart';
import 'package:binrushd_medical_center/controller/Auth/sign_up_provider.dart';
import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // ValueNotifiers to manage password visibility
  final ValueNotifier<bool> _passwordVisible = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _confirmPasswordVisible =
      ValueNotifier<bool>(false);

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _passwordVisible.dispose();
    _confirmPasswordVisible.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signUpProvider = Provider.of<SignUpProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          'انشاء حساب جديد',
          style: TextStyle(
              color: backgroundColor,
              fontWeight: FontWeight.w700,
              fontSize: 20),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildLabeledTextField(
                  'الاسم الاول',
                  'الاسم الاول',
                  "",
                  suffixIcon: const Icon(
                    Icons.person,
                    color: Color.fromRGBO(159, 159, 159, 1),
                  ),
                  controller: firstNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الاسم الأول مطلوب';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                buildLabeledTextField(
                  'الاسم التاني',
                  'الاسم التاني',
                  "",
                  suffixIcon: const Icon(
                    Icons.person,
                    color: Color.fromRGBO(159, 159, 159, 1),
                  ),
                  controller: lastNameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الاسم الثاني مطلوب';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                buildLabeledTextField(
                  'الإيميل',
                  'اميلك',
                  "assets/images/midd.png",
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الإيميل مطلوب';
                    }
                    final emailRegex = RegExp(
                        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
                    if (!emailRegex.hasMatch(value)) {
                      return 'يرجى إدخال إيميل صحيح';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                buildLabeledTextField(
                  'رقم الهاتف',
                  'رقم هاتفك',
                  "assets/images/phonecall.png",
                  controller: phoneController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'رقم الهاتف مطلوب';
                    }
                    if (!RegExp(r'^\d+$').hasMatch(value)) {
                      return 'يرجى إدخال رقم هاتف صحيح';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                buildPasswordField(
                  'كلمة السر',
                  //'●●●●●●●',
                  "",
                  Icons.visibility,
                  controller: passwordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'كلمة السر مطلوبة';
                    }
                    if (value.length < 6) {
                      return 'كلمة السر يجب أن تكون 6 أحرف أو أكثر';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 15),
                buildPasswordField(
                  'تاكيد كلمة السر',
                  // '●●●●●●●',
                  "",
                  Icons.visibility,
                  controller: confirmPasswordController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'تأكيد كلمة السر مطلوب';
                    }
                    if (value != passwordController.text) {
                      return 'كلمة السر وتأكيد كلمة السر غير متطابقين';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),
                signUpProvider.isLoading
                    ? const CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            await signUpProvider.signUpUser(
                              fName: firstNameController.text,
                              lName: lastNameController.text,
                              email: emailController.text,
                              phone: phoneController.text,
                              password: passwordController.text,
                              confPassword: confirmPasswordController.text,
                              context: context,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          backgroundColor: backgroundColor,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 115, vertical: 15),
                          textStyle: const TextStyle(fontSize: 16),
                        ),
                        child: const Text(
                          'انشاء حساب',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildPasswordField(
    String label,
    String hintText,
    IconData icon, {
    required TextEditingController controller,
    required String? Function(String?) validator,
  }) {
    return ValueListenableBuilder<bool>(
      valueListenable:
          label == 'كلمة السر' ? _passwordVisible : _confirmPasswordVisible,
      builder: (context, isPasswordVisible, child) {
        return buildLabeledTextField(
          label,
          hintText,
          "assets/images/eye.png",
          controller: controller,
          obscureText: !isPasswordVisible,
          validator: validator,
          suffixIcon: IconButton(
            icon: Icon(
              isPasswordVisible ? Icons.visibility_off : Icons.visibility,
              size: 23,
              color: const Color.fromRGBO(
                159,
                159,
                159,
                1,
              ),
            ),
            onPressed: () {
              if (label == 'كلمة السر') {
                _passwordVisible.value = !isPasswordVisible;
              } else {
                _confirmPasswordVisible.value = !isPasswordVisible;
              }
            },
          ),
        );
      },
    );
  }

  Widget buildLabeledTextField(
    String label,
    String hintText,
    String assetImagePath, // Asset image path for non-password fields
    {
    bool obscureText = false,
    TextEditingController? controller,
    String? Function(String?)? validator,
    Widget? suffixIcon, // For custom suffix icons like password toggles
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          textAlign: TextAlign.right,
          obscureText: obscureText,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.grey, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.grey, width: 1),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Colors.grey, width: 1.5),
            ),
            hintText: hintText,
            hintStyle: const TextStyle(
              color: Colors.grey,
              fontSize: 12,
              fontWeight: FontWeight.w400,
            ),
            suffixIcon: suffixIcon ??
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, right: 12.0),
                  child: Image.asset(
                    assetImagePath,
                    width: 21,
                    height: 21,
                    fit: BoxFit.contain,
                  ),
                ),
          ),
          validator: validator,
        ),
      ],
    );
  }
}
