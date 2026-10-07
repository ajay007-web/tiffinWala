import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/constants/asset_paths.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/price_utils.dart';
import '../../../core/widgets/animated_pressable.dart';
import '../../../core/widgets/custom_svg_icon.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../data/models/address_model.dart';
import '../../../data/models/plan_model.dart';
import 'payment_success_screen.dart';

class PaymentScreen extends StatefulWidget {
  final PlanModel plan;
  final AddressModel address;

  const PaymentScreen({
    super.key,
    required this.plan,
    required this.address,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String _selectedMethod = 'upi';
  bool _isProcessing = false;

  Future<void> _processPayment() async {
    setState(() => _isProcessing = true);
    await Future.delayed(const Duration(milliseconds: 1200));

    if (mounted) {
      setState(() => _isProcessing = false);
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          transitionDuration: const Duration(milliseconds: 400),
          pageBuilder: (_, __, ___) => PaymentSuccessScreen(
            plan: widget.plan,
            address: widget.address,
          ),
          transitionsBuilder: (_, anim, __, child) =>
              FadeTransition(opacity: anim, child: child),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final total = widget.plan.total;

    return Scaffold(
      backgroundColor: const Color(0xFFFAFBFC),
      appBar: AppBar(
        title: Text('Select Payment', style: AppTypography.heading2),
        leading: IconButton(
          icon: const Icon(PhosphorIconsRegular.arrowLeft, color: AppColors.charcoal900),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Total Amount Hero Display
                  Center(
                    child: Column(
                      children: [
                        Text(
                          'TOTAL PAYABLE AMOUNT',
                          style: AppTypography.overline.copyWith(
                            color: AppColors.charcoal600,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          PriceUtils.format(total),
                          style: AppTypography.priceDisplay.copyWith(fontSize: 34),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.plan.name,
                          style: AppTypography.caption.copyWith(
                            color: AppColors.charcoal600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  Text('Payment Options', style: AppTypography.heading3),
                  const SizedBox(height: 14),

                  // UPI
                  _PaymentMethodTile(
                    id: 'upi',
                    title: 'UPI (Google Pay, PhonePe, Paytm)',
                    subtitle: 'Fastest & Zero Extra Charges',
                    icon: const CustomSvgIcon(
                      assetPath: AssetPaths.upiLogoSvg,
                      size: 28,
                    ),
                    isSelected: _selectedMethod == 'upi',
                    onTap: () => setState(() => _selectedMethod = 'upi'),
                  ),

                  const SizedBox(height: 12),

                  // Credit / Debit Card
                  _PaymentMethodTile(
                    id: 'card',
                    title: 'Credit or Debit Card',
                    subtitle: 'Visa, MasterCard, RuPay',
                    icon: const Icon(
                      PhosphorIconsRegular.creditCard,
                      size: 26,
                      color: AppColors.charcoal800,
                    ),
                    isSelected: _selectedMethod == 'card',
                    onTap: () => setState(() => _selectedMethod = 'card'),
                  ),

                  const SizedBox(height: 12),

                  // Net Banking
                  _PaymentMethodTile(
                    id: 'netbanking',
                    title: 'Net Banking',
                    subtitle: 'All major Indian banks supported',
                    icon: const Icon(
                      PhosphorIconsRegular.bank,
                      size: 26,
                      color: AppColors.charcoal800,
                    ),
                    isSelected: _selectedMethod == 'netbanking',
                    onTap: () => setState(() => _selectedMethod = 'netbanking'),
                  ),

                  const SizedBox(height: 12),

                  // Digital Wallets
                  _PaymentMethodTile(
                    id: 'wallet',
                    title: 'Wallets',
                    subtitle: 'Paytm Wallet, Amazon Pay, Mobikwik',
                    icon: const Icon(
                      PhosphorIconsRegular.wallet,
                      size: 26,
                      color: AppColors.charcoal800,
                    ),
                    isSelected: _selectedMethod == 'wallet',
                    onTap: () => setState(() => _selectedMethod = 'wallet'),
                  ),
                ],
              ),
            ),
          ),

          // Bottom Action
          Container(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 24),
            decoration: const BoxDecoration(
              color: AppColors.pureWhite,
              boxShadow: AppShadows.lg,
              border: Border(
                top: BorderSide(color: AppColors.charcoal100, width: 1),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                PrimaryButton(
                  text: 'Pay ${PriceUtils.format(total)}',
                  isLoading: _isProcessing,
                  onPressed: _processPayment,
                ),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      PhosphorIconsRegular.lockKey,
                      size: 13,
                      color: AppColors.charcoal400,
                    ),
                    const SizedBox(width: 6),
                    Text(
                      '100% Encrypted & Bank-grade Secure',
                      style: AppTypography.caption.copyWith(
                        color: AppColors.charcoal400,
                        fontSize: 10.5,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PaymentMethodTile extends StatelessWidget {
  final String id;
  final String title;
  final String subtitle;
  final Widget icon;
  final bool isSelected;
  final VoidCallback onTap;

  const _PaymentMethodTile({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedPressable(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.pureWhite,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.charcoal200,
            width: isSelected ? 1.8 : 1,
          ),
          boxShadow: isSelected ? AppShadows.primary : AppShadows.xs,
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.charcoal50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(child: icon),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTypography.bodyMedium.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: AppTypography.caption.copyWith(
                      color: AppColors.charcoal600,
                    ),
                  ),
                ],
              ),
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.charcoal400,
                  width: 2,
                ),
              ),
              child: Center(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  width: isSelected ? 10 : 0,
                  height: isSelected ? 10 : 0,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
