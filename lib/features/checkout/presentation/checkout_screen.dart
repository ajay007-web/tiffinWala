import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import '../../../core/constants/asset_paths.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_shadows.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/utils/price_utils.dart';
import '../../../core/widgets/custom_svg_icon.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../../../core/widgets/primary_button.dart';
import '../../../data/mock/mock_user.dart';
import '../../../data/models/address_model.dart';
import '../../../data/models/plan_model.dart';
import '../../payment/presentation/payment_screen.dart';

class CheckoutScreen extends StatefulWidget {
  final PlanModel plan;

  const CheckoutScreen({super.key, required this.plan});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  late AddressModel _address;

  @override
  void initState() {
    super.initState();
    _address = mockDefaultAddress;
  }

  void _openAddressSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => _AddressEditBottomSheet(
        currentAddress: _address,
        onSave: (updated) {
          setState(() => _address = updated);
          Navigator.of(ctx).pop();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final plan = widget.plan;

    return Scaffold(
      backgroundColor: const Color(0xFFFAFBFC),
      appBar: AppBar(
        title: Text('Review Your Plan', style: AppTypography.heading2),
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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Selected Plan Highlight Box
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.pureWhite,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.charcoal200, width: 1),
                      boxShadow: AppShadows.xs,
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: const BoxDecoration(
                            color: AppColors.primaryUltraLight,
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: CustomSvgIcon(
                              assetPath: AssetPaths.tiffinBoxSvg,
                              size: 28,
                            ),
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(plan.name, style: AppTypography.heading3),
                              const SizedBox(height: 2),
                              Text(
                                '${plan.mealCount} Fresh Meals • Daily Doorstep Delivery',
                                style: AppTypography.caption.copyWith(
                                  color: AppColors.charcoal600,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Delivery Address Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Delivery Address', style: AppTypography.heading3),
                      TextButton(
                        onPressed: _openAddressSheet,
                        child: Text(
                          'Change',
                          style: AppTypography.caption.copyWith(
                            color: AppColors.primaryDark,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.pureWhite,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.charcoal200, width: 1),
                      boxShadow: AppShadows.xs,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              PhosphorIconsFill.mapPin,
                              size: 18,
                              color: AppColors.primaryDark,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              _address.fullName,
                              style: AppTypography.bodyMedium.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.charcoal100,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Text(
                                _address.tag,
                                style: AppTypography.caption.copyWith(fontSize: 10),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _address.formattedAddress,
                          style: AppTypography.bodySmall.copyWith(
                            color: AppColors.charcoal600,
                            height: 1.4,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          'Phone: ${_address.phone}',
                          style: AppTypography.caption.copyWith(
                            color: AppColors.charcoal600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Price Breakdown
                  Text('Price Breakdown', style: AppTypography.heading3),
                  const SizedBox(height: 10),

                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: AppColors.pureWhite,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: AppColors.charcoal200, width: 1),
                      boxShadow: AppShadows.xs,
                    ),
                    child: Column(
                      children: [
                        _PriceRow(
                          label: 'Base Plan (${plan.mealCount} × ${PriceUtils.format(plan.pricePerMeal)})',
                          value: PriceUtils.format(plan.subtotal),
                        ),
                        const SizedBox(height: 10),
                        const _PriceRow(
                          label: 'Delivery Charges',
                          value: 'FREE',
                          valueColor: AppColors.success,
                        ),
                        const SizedBox(height: 10),
                        const _PriceRow(
                          label: 'Taxes & Packaging',
                          value: 'FREE',
                          valueColor: AppColors.success,
                        ),
                        const Divider(height: 24),
                        _PriceRow(
                          label: 'Total Payable',
                          value: PriceUtils.format(plan.total),
                          isBold: true,
                        ),
                      ],
                    ),
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
            child: PrimaryButton(
              text: 'Continue to Payment (${PriceUtils.format(plan.total)})',
              suffixIcon: const Icon(
                PhosphorIconsRegular.arrowRight,
                size: 16,
                color: AppColors.pureWhite,
              ),
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => PaymentScreen(
                      plan: plan,
                      address: _address,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  final bool isBold;

  const _PriceRow({
    required this.label,
    required this.value,
    this.valueColor,
    this.isBold = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: isBold
              ? AppTypography.heading3.copyWith(fontSize: 16)
              : AppTypography.bodySmall.copyWith(color: AppColors.charcoal600),
        ),
        Text(
          value,
          style: isBold
              ? AppTypography.heading2.copyWith(
                  color: AppColors.charcoal900,
                  fontSize: 18,
                )
              : AppTypography.bodyMedium.copyWith(
                  color: valueColor ?? AppColors.charcoal900,
                  fontWeight: FontWeight.w600,
                ),
        ),
      ],
    );
  }
}

class _AddressEditBottomSheet extends StatefulWidget {
  final AddressModel currentAddress;
  final ValueChanged<AddressModel> onSave;

  const _AddressEditBottomSheet({
    required this.currentAddress,
    required this.onSave,
  });

  @override
  State<_AddressEditBottomSheet> createState() =>
      _AddressEditBottomSheetState();
}

class _AddressEditBottomSheetState extends State<_AddressEditBottomSheet> {
  late TextEditingController _name;
  late TextEditingController _phone;
  late TextEditingController _building;
  late TextEditingController _area;
  late TextEditingController _city;
  late TextEditingController _pincode;

  @override
  void initState() {
    super.initState();
    _name = TextEditingController(text: widget.currentAddress.fullName);
    _phone = TextEditingController(text: widget.currentAddress.phone);
    _building = TextEditingController(text: widget.currentAddress.flatOrBuilding);
    _area = TextEditingController(text: widget.currentAddress.areaOrStreet);
    _city = TextEditingController(text: widget.currentAddress.city);
    _pincode = TextEditingController(text: widget.currentAddress.pincode);
  }

  @override
  void dispose() {
    _name.dispose();
    _phone.dispose();
    _building.dispose();
    _area.dispose();
    _city.dispose();
    _pincode.dispose();
    super.dispose();
  }

  void _save() {
    final updated = widget.currentAddress.copyWith(
      fullName: _name.text,
      phone: _phone.text,
      flatOrBuilding: _building.text,
      areaOrStreet: _area.text,
      city: _city.text,
      pincode: _pincode.text,
    );
    widget.onSave(updated);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.pureWhite,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.fromLTRB(
        20,
        16,
        20,
        MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.charcoal200,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text('Edit Delivery Address', style: AppTypography.heading2),
          const SizedBox(height: 16),
          CustomTextField(label: 'Full Name', controller: _name),
          const SizedBox(height: 12),
          CustomTextField(label: 'Phone Number', controller: _phone),
          const SizedBox(height: 12),
          CustomTextField(label: 'Flat / Building', controller: _building),
          const SizedBox(height: 12),
          CustomTextField(label: 'Area / Street', controller: _area),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(child: CustomTextField(label: 'City', controller: _city)),
              const SizedBox(width: 12),
              Expanded(child: CustomTextField(label: 'Pincode', controller: _pincode)),
            ],
          ),
          const SizedBox(height: 20),
          PrimaryButton(text: 'Save Address', onPressed: _save),
        ],
      ),
    );
  }
}
