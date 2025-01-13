import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hastools/core/constants/color.dart';

Widget buildToolCard(BuildContext context, String title, String imagePath,
    int clickCount, String path, VoidCallback onTap) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 16.0),
    child: Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    color: AppColors.white,
                  ),
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () {
                    onTap();
                    context.push(path);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.accent,
                  ),
                  child: Row(
                    children: [
                      Text(
                        'Open',
                        style: TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      // if (clickCount > 0)
                      //   Text(
                      //     clickCount.toString(),
                      //     style: TextStyle(
                      //       color: AppColors.white,
                      //       fontWeight: FontWeight.w500,
                      //     ),
                      //   ),
                      SizedBox(width: 4),
                      Icon(
                        Icons.arrow_forward,
                        size: 16,
                        color: AppColors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imagePath,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
