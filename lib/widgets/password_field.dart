import 'package:fec_app2/providers/password_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasswordField extends StatelessWidget {
  const PasswordField({
    super.key,
    required TextEditingController passwordController,
    required this.passwordProvider,
    required this.hintText,
    required this.labelText,
  }) : _passwordController = passwordController;

  final TextEditingController _passwordController;
  final PasswordProvider passwordProvider;
  final String hintText;
  final String labelText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: passwordProvider.isObscure,
      controller: _passwordController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        hintText: hintText,
        label: Text(labelText,
            style: TextStyle(fontSize: 16.sp, color: Colors.black)),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(width: 3, color: Colors.grey)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.r),
            borderSide: const BorderSide(width: 3, color: Colors.grey)),
        prefixIcon: const Icon(Icons.vpn_key, color: Colors.black),
        suffixIcon: IconButton(
          onPressed: () => passwordProvider.isToggleObscure(),
          icon: Icon(
            passwordProvider.isObscure
                ? Icons.visibility_off
                : Icons.visibility,
          ),
          color: passwordProvider.isObscure ? Colors.black : Colors.red,
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter passoword';
        } else if (value.length < 7) {
          return 'required eight digit passoword';
        } else if (value.length > 12) {
          return 'Please enter only twelve digit passoword';
        }
        return null;
      },
    );
  }
}
