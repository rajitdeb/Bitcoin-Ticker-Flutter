import 'package:flutter/material.dart';

import '../../utilities/constants.dart';

/// Another way to define callback functions that take some argument
/// Step 1
// typedef StringCallback = void Function(String?);

class CustomDropDownButton extends StatelessWidget {
  final String selectedCurrency;
  final Function(String?) onValueChanged;

  /// Step 2
  // final StringCallback onValueChanged;

  const CustomDropDownButton({
    super.key,
    required this.selectedCurrency,
    required this.onValueChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: selectedCurrency,
      menuMaxHeight: 300.0,
      dropdownColor: Colors.lightBlue,
      elevation: 16,
      style: const TextStyle(color: Colors.white),
      underline: Container(
        height: 2,
        color: Colors.white,
      ),
      items: kCurrenciesList.map((String itemValue) {
        return DropdownMenuItem(
          value: itemValue,
          child: Text(itemValue),
        );
      }).toList(),
      onChanged: (String? value) => onValueChanged(value),
    );
  }
}
