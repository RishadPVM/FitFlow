// import 'package:fitflow/common/widgets/app_button.dart';
// import 'package:fitflow/common/widgets/app_textfield.dart';
// import 'package:fitflow/core/theme/app_colors.dart';
// import 'package:fitflow/core/theme/app_text_styles.dart';
// import 'package:fitflow/modules/admin/users/trainers/controller/trainers_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// void showTrainerForm(
//   BuildContext context,
//   TrainerModel? trainer,
//   AdminTrainerController controller,
// ) {
//   final bool isEdit = trainer != null;
  
//   String selectedSpec = trainer?.specialization ?? 'Strength';
//   String selectedStatus = trainer?.status ?? 'Active';

//   Widget formContent = Container(
//     padding: const EdgeInsets.all(24),
//     child: Column(
//       mainAxisSize: MainAxisSize.min,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           isEdit ? 'Edit Trainer' : 'Add New Trainer',
//           style: AppTextStyles.h3,
//         ),
//         const SizedBox(height: 24),
//         AppTextField(
//           hintText: 'Full Name',
//           controller: nameController,
//           prefixIcon: Icons.person_outline_rounded,
//         ),
//         const SizedBox(height: 16),
//         AppTextField(
//           hintText: 'Email Address',
//           controller: emailController,
//           prefixIcon: Icons.email_outlined,
//           keyboardType: TextInputType.emailAddress,
//         ),
//         const SizedBox(height: 16),
//         Row(
//           children: [
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text('Specialty', style: AppTextStyles.caption),
//                   const SizedBox(height: 8),
//                   DropdownButtonFormField<String>(
//                     initialValue: selectedSpec,
//                     decoration: InputDecoration(
//                       contentPadding: const EdgeInsets.symmetric(
//                         horizontal: 16,
//                         vertical: 8,
//                       ),
//                       border: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                     ),
//                     items:[
//                           'Strength',
//                           'Cardio',
//                           'Yoga',
//                           'CrossFit',
//                           'General Fitness',
//                         ].map((spec) {
//                           return DropdownMenuItem(
//                             value: spec,
//                             child: Text(spec),
//                           );
//                         }).toList(),
//                     onChanged: (val) => selectedSpec = val!,
//                   ),
//                 ],
//               ),
//             ),
//             if (isEdit) ...[
//               const SizedBox(width: 16),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text('Status', style: AppTextStyles.caption),
//                     const SizedBox(height: 8),
//                     DropdownButtonFormField<String>(
//                       initialValue: selectedStatus,
//                       decoration: InputDecoration(
//                         contentPadding: const EdgeInsets.symmetric(
//                           horizontal: 16,
//                           vertical: 8,
//                         ),
//                         border: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(12),
//                         ),
//                       ),
//                       items: ['Active', 'Inactive'].map((status) {
//                         return DropdownMenuItem(
//                           value: status,
//                           child: Text(status),
//                         );
//                       }).toList(),
//                       onChanged: (val) => selectedStatus = val!,
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ],
//         ),
//         const SizedBox(height: 32),
//         AppButton(
//           text: isEdit ? 'Update Trainer' : 'Create Trainer',
//           onPressed: () {
//             if (nameController.text.isNotEmpty &&
//                 emailController.text.isNotEmpty) {
//               if (isEdit) {
//                 controller.updateTrainer(
//                   trainer.copyWith(
//                     name: nameController.text,
//                     email: emailController.text,
//                     specialization: selectedSpec,
//                     status: selectedStatus,
//                   ),
//                 );
//               } else {
//                 controller.addTrainer(
//                   nameController.text,
//                   emailController.text,
//                   selectedSpec,
//                 );
//               }
//             } else {
//               Get.snackbar('Error', 'Please fill all fields');
//             }
//           },
//         ),
//       ],
//     ),
//   );

//   Get.bottomSheet(
//     Container(
//       decoration: const BoxDecoration(
//         color: AppColors.background,
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       child: SingleChildScrollView(child: formContent),
//     ),
//     isScrollControlled: true,
//   );
// }
