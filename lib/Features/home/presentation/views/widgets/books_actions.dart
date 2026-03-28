import 'package:flutter/material.dart';
import '../../../../../Core/widgets/custom_button.dart';

class BooksActionButtons extends StatelessWidget {
  const BooksActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          const Expanded(
            child: CustomButton(
              text: '19.99 €',
              backgroundColor: Colors.white,
              textColor: Colors.black,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                bottomLeft: Radius.circular(16),
              ),
            ),
          ),
          Container(width: 0.5, color: Colors.black, height: 48),
          const Expanded(
            child: CustomButton(
              text: 'Free Preview',
              backgroundColor: Color(0xffEF8262),
              textColor: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(16),
                bottomRight: Radius.circular(16),
              ),
              fontsize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
