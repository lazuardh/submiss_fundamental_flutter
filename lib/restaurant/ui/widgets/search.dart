import 'package:flutter/material.dart';

import '../../../utils/color.dart';
import '../../../utils/fonts_utils.dart';

class CustomTextFormFieldSearch extends StatelessWidget {
  final TextEditingController _controller;
  final Function(String)? _onSubmitted;
  final Function()? _onPressed;
  final String? _hint;
  const CustomTextFormFieldSearch({
    Key? key,
    required TextEditingController controller,
    required Function(String)? onSubmitted,
    required Function()? onPressed,
    String? hint,
  })  : _controller = controller,
        _onSubmitted = onSubmitted,
        _onPressed = onPressed,
        _hint = hint,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
            prefixIcon: IconButton(
              onPressed: _onPressed,
              icon:
                  const Icon(Icons.search, color: Color(0xFFA5A3A3), size: 20),
            ),
            filled: true,
            fillColor: AppColors.greyLighter,
            hintText: _hint ?? "Search",
            hintStyle: AppTextStyle.regular.copyWith(
              color: AppColors.greyDarker,
            ),
            contentPadding: const EdgeInsets.all(12),
            border: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFFF4F0ED), width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFFF4F0ED), width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFFF4F0ED), width: 1),
              borderRadius: BorderRadius.circular(12),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Color(0xFFF4F0ED), width: 1),
              borderRadius: BorderRadius.circular(12),
            )),
        onSubmitted: _onSubmitted,
      ),
    );
  }
}
