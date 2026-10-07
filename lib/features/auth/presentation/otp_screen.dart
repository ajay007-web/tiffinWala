import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/constants/asset_paths.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/custom_svg_icon.dart';
import '../../../core/widgets/primary_button.dart';
import '../../navigation/main_navigation_screen.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

class OtpScreen extends StatefulWidget {
  final String phone;

  const OtpScreen({super.key, required this.phone});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _controllers =
      List.generate(6, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(6, (_) => FocusNode());
  bool _isSuccessAnim = false;

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }
    for (var f in _focusNodes) {
      f.dispose();
    }
    super.dispose();
  }

  String get _currentOtp => _controllers.map((c) => c.text).join();

  void _onChanged(int index, String value) {
    if (value.isNotEmpty) {
      if (index < 5) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
        _verifyCurrentOtp();
      }
    }
    setState(() {});
  }

  void _onBackspace(int index) {
    if (_controllers[index].text.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  Future<void> _verifyCurrentOtp() async {
    final otp = _currentOtp;
    if (otp.length == 6) {
      final success = await context.read<AuthCubit>().verifyOtp(otp);
      if (success && mounted) {
        setState(() => _isSuccessAnim = true);
        await Future.delayed(const Duration(milliseconds: 700));
        if (mounted) {
          Navigator.of(context).pushAndRemoveUntil(
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 400),
              pageBuilder: (_, __, ___) => const MainNavigationScreen(),
              transitionsBuilder: (_, anim, __, child) =>
                  FadeTransition(opacity: anim, child: child),
            ),
            (route) => false,
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureWhite,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(PhosphorIconsRegular.arrowLeft, color: AppColors.charcoal900),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {},
          builder: (context, state) {
            final authOtp = state is AuthOtpSent ? state : null;
            final isVerifying = authOtp?.isVerifying ?? false;
            final countdown = authOtp?.resendCountdown ?? 30;
            final canResend = authOtp?.canResend ?? false;
            final errorMessage = authOtp?.error;

            if (_isSuccessAnim) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 90,
                      height: 90,
                      decoration: const BoxDecoration(
                        color: AppColors.successLight,
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: CustomSvgIcon(
                          assetPath: AssetPaths.successCheckSvg,
                          size: 64,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text('Verified Successfully!', style: AppTypography.heading2),
                    const SizedBox(height: 8),
                    Text('Welcome to TiffinWala', style: AppTypography.bodyMedium),
                  ],
                ),
              );
            }

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Text('Verify your number', style: AppTypography.displayMedium),
                  const SizedBox(height: 8),
                  Text.rich(
                    TextSpan(
                      text: 'Enter the 6-digit code sent to ',
                      style: AppTypography.bodyLarge.copyWith(
                        color: AppColors.charcoal600,
                      ),
                      children: [
                        TextSpan(
                          text: '+91 ${widget.phone}',
                          style: const TextStyle(
                            color: AppColors.charcoal900,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 36),

                  // 6 OTP Box Inputs
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(6, (index) {
                      final isFocused = _focusNodes[index].hasFocus;
                      final isFilled = _controllers[index].text.isNotEmpty;

                      return SizedBox(
                        width: 48,
                        height: 56,
                        child: KeyboardListener(
                          focusNode: FocusNode(),
                          onKeyEvent: (event) {
                            if (event is KeyDownEvent &&
                                event.logicalKey ==
                                    LogicalKeyboardKey.backspace) {
                              _onBackspace(index);
                            }
                          },
                          child: TextField(
                            controller: _controllers[index],
                            focusNode: _focusNodes[index],
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            maxLength: 1,
                            style: AppTypography.heading1.copyWith(
                              color: AppColors.charcoal900,
                              fontWeight: FontWeight.w700,
                            ),
                            inputFormatters: [
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            decoration: InputDecoration(
                              counterText: '',
                              filled: true,
                              fillColor: isFilled || isFocused
                                  ? AppColors.pureWhite
                                  : AppColors.charcoal50,
                              contentPadding: EdgeInsets.zero,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: errorMessage != null
                                      ? AppColors.error
                                      : (isFilled
                                          ? AppColors.primary
                                          : AppColors.charcoal200),
                                  width: 1.5,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: AppColors.primary,
                                  width: 2.0,
                                ),
                              ),
                            ),
                            onChanged: (val) => _onChanged(index, val),
                          ),
                        ),
                      );
                    }),
                  ),

                  if (errorMessage != null) ...[
                    const SizedBox(height: 12),
                    Text(
                      errorMessage,
                      style: AppTypography.caption.copyWith(color: AppColors.error),
                    ),
                  ],

                  const SizedBox(height: 28),

                  // Resend countdown
                  Center(
                    child: canResend
                        ? TextButton(
                            onPressed: () {
                              context.read<AuthCubit>().resendOtp();
                            },
                            child: Text(
                              'Didn\'t receive code? Resend OTP',
                              style: AppTypography.bodyMedium.copyWith(
                                color: AppColors.primaryDark,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          )
                        : Text(
                            'Resend code in 00:${countdown.toString().padLeft(2, '0')}',
                            style: AppTypography.bodyMedium.copyWith(
                              color: AppColors.charcoal400,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                  ),

                  const Spacer(),

                  PrimaryButton(
                    text: 'Verify & Continue',
                    isEnabled: _currentOtp.length == 6,
                    isLoading: isVerifying,
                    onPressed: _verifyCurrentOtp,
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
