import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/constants/asset_paths.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/custom_svg_icon.dart';
import '../../../core/widgets/primary_button.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import 'otp_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();
  bool _isValidPhone = false;

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(() {
      final text = _phoneController.text.replaceAll(RegExp(r'\D'), '');
      final valid = text.length == 10;
      if (valid != _isValidPhone) {
        setState(() => _isValidPhone = valid);
      }
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  void _onContinue() {
    if (_isValidPhone) {
      final phone = _phoneController.text.replaceAll(RegExp(r'\D'), '');
      context.read<AuthCubit>().sendOtp(phone);
      Navigator.of(context).push(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 300),
          pageBuilder: (_, __, ___) => OtpScreen(phone: phone),
          transitionsBuilder: (_, anim, __, child) => SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(CurvedAnimation(parent: anim, curve: Curves.easeOutCubic)),
            child: child,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureWhite,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 36),

              // Brand Header
              Center(
                child: Column(
                  children: [
                    Container(
                      width: 68,
                      height: 68,
                      decoration: const BoxDecoration(
                        color: AppColors.primaryUltraLight,
                        shape: BoxShape.circle,
                        boxShadow: AppShadows.xs,
                      ),
                      child: const Center(
                        child: CustomSvgIcon(
                          assetPath: AssetPaths.tiffinBoxSvg,
                          size: 42,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text('TiffinWala', style: AppTypography.heading2),
                  ],
                ),
              ),

              const SizedBox(height: 48),

              // Welcome text
              Text(
                'Welcome back 👋',
                style: AppTypography.displayMedium,
              ),
              const SizedBox(height: 8),
              Text(
                'Healthy homemade meals, delivered to you.',
                style: AppTypography.bodyLarge.copyWith(
                  color: AppColors.charcoal600,
                ),
              ),

              const SizedBox(height: 36),

              // Phone Number Field Label
              Text(
                'PHONE NUMBER',
                style: AppTypography.overline.copyWith(
                  color: AppColors.charcoal600,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 8),

              // Phone input container
              Container(
                height: 56,
                decoration: BoxDecoration(
                  color: AppColors.pureWhite,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: _isValidPhone
                        ? AppColors.primary
                        : AppColors.charcoal200,
                    width: 1.5,
                  ),
                  boxShadow: _isValidPhone ? AppShadows.xs : AppShadows.none,
                ),
                child: Row(
                  children: [
                    // Country Code
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: const BoxDecoration(
                        border: Border(
                          right: BorderSide(color: AppColors.charcoal200, width: 1),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Text('🇮🇳', style: TextStyle(fontSize: 18)),
                          const SizedBox(width: 8),
                          Text(
                            '+91',
                            style: AppTypography.bodyLarge.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.charcoal900,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Digits Input
                    Expanded(
                      child: TextField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(10),
                        ],
                        autofocus: true,
                        style: AppTypography.bodyLarge.copyWith(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.2,
                        ),
                        decoration: InputDecoration(
                          hintText: '98765 43210',
                          hintStyle: AppTypography.bodyLarge.copyWith(
                            color: AppColors.charcoal400,
                            letterSpacing: 1.2,
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Continue Button
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  final isLoading = state is AuthLoading;
                  return PrimaryButton(
                    text: 'Continue',
                    isEnabled: _isValidPhone,
                    isLoading: isLoading,
                    onPressed: _onContinue,
                  );
                },
              ),

              const Spacer(),

              // Terms & Conditions
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Text.rich(
                    TextSpan(
                      text: 'By continuing, you agree to our ',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.charcoal400,
                      ),
                      children: const [
                        TextSpan(
                          text: 'Terms of Service',
                          style: TextStyle(
                            color: AppColors.primaryDark,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        TextSpan(text: ' and '),
                        TextSpan(
                          text: 'Privacy Policy',
                          style: TextStyle(
                            color: AppColors.primaryDark,
                            fontWeight: FontWeight.w600,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
