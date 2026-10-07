import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/animated_pressable.dart';
import '../../auth/cubit/auth_cubit.dart';
import '../../auth/presentation/login_screen.dart';
import '../../plans/presentation/plans_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.pureWhite,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Log out of TiffinWala?', style: AppTypography.heading2),
        content: Text(
          'You will need to verify your phone number to sign back in.',
          style: AppTypography.bodyMedium.copyWith(color: AppColors.charcoal600),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: Text(
              'Cancel',
              style: AppTypography.buttonMedium.copyWith(
                color: AppColors.charcoal600,
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              context.read<AuthCubit>().logout();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false,
              );
            },
            child: Text(
              'Log Out',
              style: AppTypography.buttonMedium.copyWith(color: AppColors.error),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFBFC),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Profile', style: AppTypography.displayMedium),
              const SizedBox(height: 20),

              // User Info Card
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.pureWhite,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.charcoal200, width: 1),
                  boxShadow: AppShadows.xs,
                ),
                child: Row(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: const BoxDecoration(
                        color: AppColors.primaryUltraLight,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          'AK',
                          style: AppTypography.heading1.copyWith(
                            color: AppColors.primaryDark,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Ajay Kumar', style: AppTypography.heading2),
                          const SizedBox(height: 2),
                          Text(
                            '+91 98765 43210',
                            style: AppTypography.bodySmall.copyWith(
                              color: AppColors.charcoal600,
                            ),
                          ),
                          Text(
                            'ajay.kumar@gmail.com',
                            style: AppTypography.caption.copyWith(
                              color: AppColors.charcoal400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      PhosphorIconsRegular.pencilSimple,
                      size: 20,
                      color: AppColors.primaryDark,
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Active Plan Quick Shortcut
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.primaryUltraLight,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(
                    color: AppColors.primaryLight.withOpacity(0.6),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    const Icon(
                      PhosphorIconsFill.sealCheck,
                      color: AppColors.primaryDark,
                      size: 22,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '20 Meal Subscription Active',
                            style: AppTypography.bodySmall.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryDark,
                            ),
                          ),
                          Text(
                            '12 meals remaining',
                            style: AppTypography.caption.copyWith(
                              color: AppColors.charcoal600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    AnimatedPressable(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const PlansScreen()),
                        );
                      },
                      child: Text(
                        'Change Plan',
                        style: AppTypography.caption.copyWith(
                          color: AppColors.primaryDark,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Section: Account
              const _SectionLabel('ACCOUNT SETTINGS'),
              _MenuGroup(
                items: [
                  _MenuItem(
                    icon: PhosphorIconsRegular.mapPin,
                    title: 'Delivery Addresses',
                    subtitle: 'Manage home & office delivery addresses',
                    onTap: () {},
                  ),
                  _MenuItem(
                    icon: PhosphorIconsRegular.clockCounterClockwise,
                    title: 'Order History',
                    subtitle: 'Past invoices and transactions',
                    onTap: () {},
                  ),
                  _MenuItem(
                    icon: PhosphorIconsRegular.bell,
                    title: 'Notifications',
                    subtitle: 'Daily delivery alerts & reminders',
                    onTap: () {},
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // Section: Preferences & Support
              const _SectionLabel('SUPPORT & LEGAL'),
              _MenuGroup(
                items: [
                  _MenuItem(
                    icon: PhosphorIconsRegular.chatsCircle,
                    title: 'Customer Support',
                    subtitle: 'Chat or call with support (24x7)',
                    onTap: () {},
                  ),
                  _MenuItem(
                    icon: PhosphorIconsRegular.fileText,
                    title: 'Terms of Service',
                    onTap: () {},
                  ),
                  _MenuItem(
                    icon: PhosphorIconsRegular.shieldCheck,
                    title: 'Privacy Policy',
                    onTap: () {},
                  ),
                  _MenuItem(
                    icon: PhosphorIconsRegular.info,
                    title: 'About TiffinWala',
                    subtitle: 'Made with love in India 🇮🇳',
                    onTap: () {},
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Logout Button
              AnimatedPressable(
                onTap: () => _showLogoutDialog(context),
                child: Container(
                  height: 52,
                  decoration: BoxDecoration(
                    color: AppColors.pureWhite,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.error.withOpacity(0.3), width: 1.2),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        PhosphorIconsRegular.signOut,
                        size: 20,
                        color: AppColors.error,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Log Out',
                        style: AppTypography.buttonMedium.copyWith(
                          color: AppColors.error,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Center(
                child: Text(
                  'TiffinWala v1.0.0 (Production Build)',
                  style: AppTypography.caption.copyWith(
                    color: AppColors.charcoal400,
                  ),
                ),
              ),

              const SizedBox(height: 110),
            ],
          ),
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;

  const _SectionLabel(this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        text,
        style: AppTypography.overline.copyWith(
          color: AppColors.charcoal400,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

class _MenuGroup extends StatelessWidget {
  final List<_MenuItem> items;

  const _MenuGroup({required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.charcoal200, width: 1),
        boxShadow: AppShadows.xs,
      ),
      child: Column(
        children: items.asMap().entries.map((entry) {
          final index = entry.key;
          final item = entry.value;
          final isLast = index == items.length - 1;

          return Column(
            children: [
              AnimatedPressable(
                onTap: item.onTap,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  child: Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: AppColors.charcoal50,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(item.icon, size: 20, color: AppColors.charcoal800),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.title,
                              style: AppTypography.bodyMedium.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            if (item.subtitle != null) ...[
                              const SizedBox(height: 1),
                              Text(
                                item.subtitle!,
                                style: AppTypography.caption.copyWith(
                                  color: AppColors.charcoal400,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                      const Icon(
                        PhosphorIconsRegular.caretRight,
                        size: 16,
                        color: AppColors.charcoal400,
                      ),
                    ],
                  ),
                ),
              ),
              if (!isLast)
                const Divider(height: 1, indent: 64, color: AppColors.charcoal100),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _MenuItem {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.title,
    this.subtitle,
    required this.onTap,
  });
}
