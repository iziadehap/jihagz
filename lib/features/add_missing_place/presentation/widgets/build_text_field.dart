import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jihagz/core/appCore.dart';
import 'package:jihagz/features/add_missing_place/data/data_source/add_missing_place_controller.dart';

class BuildTextField extends StatelessWidget {
  BuildTextField({super.key, required this.controller});

  final AddMissingPlaceController controller;

  final appCore = AppCore();

  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Type", style: TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(height: 8),
        Obx(
          () => Wrap(
            spacing: 8,
            children: [
              for (final type in AppCore.sportTypes)
                ChoiceChip(
                  label: Text(type[0].toUpperCase() + type.substring(1)),
                  selected: controller.selectedType.value == type,
                  onSelected: (_) => controller.selectedType.value = type,
                ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Obx(
          () => controller.selectedType.value == 'custom'
              ? TextFormField(
                  controller: controller.customTypeController,
                  decoration: InputDecoration(
                    labelText: 'Custom Type Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  validator: (value) {
                    if (controller.selectedType.value == 'custom' &&
                        (value == null || value.trim().isEmpty)) {
                      return 'Please enter a custom type name';
                    }
                    return null;
                  },
                )
              : SizedBox.shrink(),
        ),
        const SizedBox(height: 18),
        TextFormField(
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Name is required';
            }
            return null;
          },
          controller: controller.nameController,
          decoration: InputDecoration(
            labelText: 'Place Name',
            prefixIcon: Icon(Icons.place, color: appCore.secondaryColor),
            filled: true,
            fillColor: appCore.backgroundColor.withOpacity(0.95),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),

        const SizedBox(height: 18),
        Obx(() {
          return controller.isAddPrice.value
              ? TextFormField(
                  controller: controller.priceController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  decoration: InputDecoration(
                    labelText: 'Price',
                    prefixIcon: Icon(
                      Icons.attach_money,
                      color: appCore.secondaryColor,
                    ),
                    filled: true,
                    fillColor: appCore.backgroundColor.withOpacity(0.95),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                )
              : InkWell(
                  onTap: () {
                    controller.isAddPrice.value = true;
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, color: appCore.secondaryColor),
                      const SizedBox(width: 8),
                      Text('Add Price'),
                    ],
                  ),
                );
        }),

        const SizedBox(height: 18),
        // Phone number field
        Obx(() {
          return controller.isAddPhone != null && controller.isAddPhone.value
              ? TextFormField(
                  controller: controller.phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Phone Number',
                    prefixIcon: Icon(
                      Icons.phone,
                      color: appCore.secondaryColor,
                    ),
                    filled: true,
                    fillColor: appCore.backgroundColor.withOpacity(0.95),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                )
              : InkWell(
                  onTap: () {
                    controller.isAddPhone.value = true;
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, color: appCore.secondaryColor),
                      const SizedBox(width: 8),
                      Text('Add Phone'),
                    ],
                  ),
                );
        }),

        const SizedBox(height: 18),

        Divider(color: appCore.primaryColor.withOpacity(0.15)),
      ],
    );
  }
}
