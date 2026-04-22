import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../../models/membership_plan_model.dart';
import '../controller/membership_plan_controller.dart';

class CreatePlanBottomSheet extends StatefulWidget {
  final MembershipPlanModel? planToEdit;

  const CreatePlanBottomSheet({super.key, this.planToEdit});

  static void show({MembershipPlanModel? plan}) {
    Get.bottomSheet(
      CreatePlanBottomSheet(planToEdit: plan),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
    );
  }

  @override
  State<CreatePlanBottomSheet> createState() => _CreatePlanBottomSheetState();
}

class _CreatePlanBottomSheetState extends State<CreatePlanBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  
  late TextEditingController _nameController;
  late TextEditingController _priceController;
  late TextEditingController _featureController;
  
  int _selectedDuration = 1;
  List<String> _features = [];
  bool _isActive = true;
  bool _isPopular = false;

  final List<int> _durationOptions = [1, 3, 6, 12];

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.planToEdit?.name ?? '');
    _priceController = TextEditingController(text: widget.planToEdit?.price.toStringAsFixed(0) ?? '');
    _featureController = TextEditingController();
    
    if (widget.planToEdit != null) {
      _selectedDuration = widget.planToEdit!.durationInMonths;
      _features = List.from(widget.planToEdit!.features);
      _isActive = widget.planToEdit!.isActive;
      _isPopular = widget.planToEdit!.isPopular;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _priceController.dispose();
    _featureController.dispose();
    super.dispose();
  }

  void _addFeature() {
    final feature = _featureController.text.trim();
    if (feature.isNotEmpty && !_features.contains(feature)) {
      setState(() {
        _features.add(feature);
        _featureController.clear();
      });
    }
  }

  void _removeFeature(String feature) {
    setState(() {
      _features.remove(feature);
    });
  }

  void _savePlan() {
    if (_formKey.currentState!.validate()) {
      if (_features.isEmpty) {
        Get.snackbar(
          'Validation Error',
          'Please add at least one feature.',
          backgroundColor: AppColors.error.withOpacity(0.9),
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
        );
        return;
      }

      final controller = Get.find<MembershipPlanController>();
      
      final plan = MembershipPlanModel(
        id: widget.planToEdit?.id ?? DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text.trim(),
        price: double.tryParse(_priceController.text.trim()) ?? 0,
        durationInMonths: _selectedDuration,
        features: _features,
        isActive: _isActive,
        isPopular: _isPopular,
        activeMembers: widget.planToEdit?.activeMembers ?? 0,
      );

      if (widget.planToEdit != null) {
        controller.updatePlan(plan);
      } else {
        controller.addPlan(plan);
      }

      Get.back();
      Get.snackbar(
        'Success',
        widget.planToEdit != null ? 'Plan updated successfully' : 'Plan created successfully',
        backgroundColor: AppColors.success.withOpacity(0.9),
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.divider,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    widget.planToEdit != null ? 'Edit Membership Plan' : 'Create Membership Plan',
                    style: AppTextStyles.h2,
                  ),
                  const SizedBox(height: 24),
                  
                  // Name Field
                  TextFormField(
                    controller: _nameController,
                    style: AppTextStyles.bodyLarge,
                    decoration: const InputDecoration(
                      labelText: 'Plan Name',
                      hintText: 'e.g., Basic, Pro',
                    ),
                    validator: (value) => value == null || value.trim().isEmpty ? 'Required' : null,
                  ),
                  const SizedBox(height: 16),
                  
                  // Price Field
                  TextFormField(
                    controller: _priceController,
                    style: AppTextStyles.bodyLarge,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Price (₹)',
                      hintText: 'e.g., 999',
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) return 'Required';
                      if (double.tryParse(value) == null) return 'Must be a valid number';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  
                  // Duration Dropdown
                  Text('Duration', style: AppTextStyles.bodyMedium),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceLight,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<int>(
                        value: _selectedDuration,
                        dropdownColor: AppColors.surfaceLight,
                        isExpanded: true,
                        style: AppTextStyles.bodyLarge,
                        items: _durationOptions.map((duration) {
                          String label = duration == 1 ? '1 Month' : duration == 12 ? '1 Year' : '$duration Months';
                          return DropdownMenuItem(
                            value: duration,
                            child: Text(label),
                          );
                        }).toList(),
                        onChanged: (value) {
                          if (value != null) {
                            setState(() {
                              _selectedDuration = value;
                            });
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Features Input
                  Text('Features', style: AppTextStyles.bodyMedium),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _featureController,
                          style: AppTextStyles.bodyLarge,
                          decoration: const InputDecoration(
                            hintText: 'Add a feature...',
                          ),
                          onFieldSubmitted: (_) => _addFeature(),
                        ),
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        onPressed: _addFeature,
                        icon: const Icon(Icons.add_circle, color: AppColors.primaryBlue, size: 28),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  
                  // Features Chips
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: _features.map((feature) {
                      return Chip(
                        label: Text(feature, style: AppTextStyles.caption.copyWith(color: AppColors.textPrimary)),
                        backgroundColor: AppColors.surfaceLight,
                        deleteIcon: const Icon(Icons.close, size: 16, color: AppColors.error),
                        onDeleted: () => _removeFeature(feature),
                        side: BorderSide.none,
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 24),
                  
                  // Switches
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Status (Active)', style: AppTextStyles.bodyLarge),
                      Switch(
                        value: _isActive,
                        onChanged: (val) => setState(() => _isActive = val),
                        activeColor: AppColors.primaryBlue,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Mark as Popular', style: AppTextStyles.bodyLarge),
                      Switch(
                        value: _isPopular,
                        onChanged: (val) => setState(() => _isPopular = val),
                        activeColor: AppColors.primaryBlue,
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: 32),
                  
                  // Submit Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _savePlan,
                      child: Text(widget.planToEdit != null ? 'Update Plan' : 'Create Plan'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
