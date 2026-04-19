import 'package:clean_arch_bookly_app/Core/widgets/custom_fading_widget.dart';
import 'package:flutter/material.dart';

class NewestBooksListViewFadingLoadingIndicator extends StatelessWidget {
  const NewestBooksListViewFadingLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomFadingWidget(
      child: ListView.builder(
        itemCount: 10,
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
        itemBuilder: (context, index) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: SizedBox(
            height: 125,
            child: Row(
              children: [
                AspectRatio(
                  aspectRatio: 2.5 / 4,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    child: Container(color: Colors.grey[50]),
                  ),
                ),
                const SizedBox(width: 30),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Placeholder for Title
                      Container(
                        height: 20,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Placeholder for Author
                      Container(
                        height: 15,
                        width: 150,
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                      ),
                      const Spacer(),
                      // Placeholder for Price and Rating
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 20,
                            width: 80,
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: const BorderRadius.all(
                                Radius.circular(4),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
