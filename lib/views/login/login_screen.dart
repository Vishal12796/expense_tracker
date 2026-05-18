import 'package:expense_tracker/views/login/controller/login_controller.dart';
import 'package:expense_tracker/core/resources/app_icons.dart';
import 'package:expense_tracker/core/router/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';

import '../../core/extension/context_extension.dart';

class LoginScreen extends StatelessWidget {
  final LoginController controller = Get.find();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome Back 👋',
                style: context.text.headlineLarge?.copyWith(
                  color: context.color.primary,
                ),
              ),

              const SizedBox(height: 16),

              Text(
                'Sign in to continue managing your expenses and trades securely.',
                textAlign: TextAlign.center,
                style: context.text.labelSmall?.copyWith(
                  color: context.color.onPrimaryFixedVariant,
                ),
              ),

              const SizedBox(height: 28),

              _GoogleSignInButton(
                onTap: () {
                  Get.toNamed(AppRoutes.home);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GoogleSignInButton extends StatelessWidget {
  final VoidCallback onTap;

  const _GoogleSignInButton({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 50,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: Colors.grey.shade300),
          color: Colors.grey.shade300,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 12,
          children: [
            SvgPicture.asset(AppIcons.google, height: 28, width: 28),
            Text(
              'Sign in with Google',
              style: context.text.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
