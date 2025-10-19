import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:jihagz/core/appCore.dart';
import 'package:jihagz/features/form/controller/form_controller.dart';

class FormScreen extends StatelessWidget {
  FormScreen({Key? key}) : super(key: key);
  final FormController controller = Get.put(FormController());
  final AppCore appCore = AppCore();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appCore.backgroundColor,
      appBar: AppBar(
        backgroundColor: appCore.surfaceColor,
        elevation: 0,
        title: Text(
          'Complete Profile',
          style: TextStyle(
            color: appCore.primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: appCore.primaryColor),
          onPressed: () => Get.back(),
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Container(
              constraints: BoxConstraints(maxWidth: 420),
              decoration: BoxDecoration(
                color: appCore.surfaceColor.withOpacity(0.98),
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: appCore.primaryColor.withOpacity(0.08),
                    blurRadius: 24,
                    offset: Offset(0, 12),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: CircleAvatar(
                      radius: 36,
                      backgroundColor: appCore.primaryColor.withOpacity(0.15),
                      child: Icon(
                        Icons.person,
                        size: 48,
                        color: appCore.primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Center(
                    child: Text(
                      'Let\'s get to know you!',
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            color: appCore.primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      'Please fill in your details to complete your account.',
                      style: TextStyle(color: Colors.white70, fontSize: 15),
                    ),
                  ),
                  const SizedBox(height: 32),
                  Obx(
                    () => _buildTextField(
                      label: 'Full Name',
                      hint: 'Enter your full name',
                      icon: Icons.person,
                      onChanged: controller.updateName,
                      initialValue: controller.name.value,
                      errorText: controller.nameError.value.isEmpty
                          ? null
                          : controller.nameError.value,
                    ),
                  ),
                  const SizedBox(height: 20),
                  _buildPhoneField(context),
                  const SizedBox(height: 20),
                  _buildGenderRow(context),
                  const SizedBox(height: 20),
                  Obx(
                    () => _buildTextField(
                      label: 'Age',
                      hint: 'Enter your age',
                      icon: Icons.cake,
                      onChanged: (val) => controller.updateAge(val),
                      initialValue: controller.age.value,
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      errorText: controller.ageError.value.isEmpty
                          ? null
                          : controller.ageError.value,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Obx(
                    () => SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: ElevatedButton(
                        onPressed: controller.isLoading.value
                            ? null
                            : controller.saveProfile,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: appCore.primaryColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 6,
                          shadowColor: appCore.primaryColor.withOpacity(0.18),
                        ),
                        child: controller.isLoading.value
                            ? SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                            : Text(
                                'Save Profile',
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
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

  Widget _buildTextField({
    required String label,
    required String hint,
    required IconData icon,
    required Function(String) onChanged,
    String? initialValue,
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
    String? errorText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          initialValue: initialValue,
          onChanged: onChanged,
          keyboardType: keyboardType,
          inputFormatters: inputFormatters,
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Colors.white54),
            prefixIcon: Icon(icon, color: appCore.secondaryColor),
            filled: true,
            fillColor: appCore.backgroundColor.withOpacity(0.95),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade600),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade600),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: appCore.primaryColor, width: 2),
            ),
            errorText: errorText,
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneField(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Phone Number',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Obx(
          () => TextFormField(
            initialValue: controller.phoneNumber.value,
            onChanged: controller.updatePhoneNumber,
            keyboardType: TextInputType.phone,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Enter your phone number',
              hintStyle: TextStyle(color: Colors.white54),
              filled: true,
              fillColor: appCore.backgroundColor.withOpacity(0.95),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade600),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: Colors.grey.shade600),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: appCore.primaryColor, width: 2),
              ),
              prefixIcon: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('🇪🇬', style: TextStyle(fontSize: 20)),
                    const SizedBox(width: 4),
                    Text(
                      '+20',
                      style: TextStyle(
                        color: appCore.secondaryColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(width: 6),
                  ],
                ),
              ),
              errorText: controller.phoneError.value.isEmpty
                  ? null
                  : controller.phoneError.value,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGenderRow(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Gender',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Obx(
          () => Row(
            children: [
              _genderOption(context, 'Male', Icons.male),
              const SizedBox(width: 16),
              _genderOption(context, 'Female', Icons.female),
            ],
          ),
        ),
        Obx(
          () => controller.genderError.value.isNotEmpty
              ? Padding(
                  padding: const EdgeInsets.only(top: 6.0, left: 4.0),
                  child: Text(
                    controller.genderError.value,
                    style: TextStyle(color: Colors.red, fontSize: 13),
                  ),
                )
              : SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _genderOption(BuildContext context, String gender, IconData icon) {
    final isSelected = controller.gender.value == gender;
    return Expanded(
      child: GestureDetector(
        onTap: () => controller.updateGender(gender),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            color: isSelected
                ? appCore.primaryColor.withOpacity(0.18)
                : appCore.backgroundColor.withOpacity(0.95),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? appCore.primaryColor : Colors.grey.shade600,
              width: isSelected ? 2 : 1,
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                color: isSelected
                    ? appCore.primaryColor
                    : appCore.secondaryColor,
                size: 28,
              ),
              const SizedBox(height: 6),
              Text(
                gender,
                style: TextStyle(
                  color: isSelected ? appCore.primaryColor : Colors.white70,
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
