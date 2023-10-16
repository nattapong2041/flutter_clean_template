import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../common/extension/app_colors.dart';

class NewsCardShimmer extends StatelessWidget {
  const NewsCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 450,
      child: Card(
          child: Column(
        children: [
          Shimmer.fromColors(
            baseColor: AppColors.baseShimmer,
            highlightColor: AppColors.highlightShimmer,
            child: Container(
              color: Theme.of(context).colorScheme.background,
              height: 150,
              width: double.infinity,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Column(children: [
                Shimmer.fromColors(
                  baseColor: AppColors.baseShimmer,
                  highlightColor: AppColors.highlightShimmer,
                  child: Container(
                    color: Theme.of(context).colorScheme.background,
                    height: 15,
                    width: double.infinity,
                  ),
                ),
                const SizedBox(height: 5),
                Shimmer.fromColors(
                  baseColor: AppColors.baseShimmer,
                  highlightColor: AppColors.highlightShimmer,
                  child: Container(
                    color: Theme.of(context).colorScheme.background,
                    height: 15,
                    width: double.infinity,
                  ),
                ),
                const SizedBox(height: 5),
                Shimmer.fromColors(
                  baseColor: AppColors.baseShimmer,
                  highlightColor: AppColors.highlightShimmer,
                  child: Container(
                    color: Theme.of(context).colorScheme.background,
                    height: 15,
                    width: double.infinity,
                  ),
                ),
                const SizedBox(height: 15),
                Shimmer.fromColors(
                  baseColor: AppColors.baseShimmer,
                  highlightColor: AppColors.highlightShimmer,
                  child: Container(
                    color: Theme.of(context).colorScheme.background,
                    height: 10,
                    width: double.infinity,
                  ),
                ),
                const SizedBox(height: 5),
                Shimmer.fromColors(
                  baseColor: AppColors.baseShimmer,
                  highlightColor: AppColors.highlightShimmer,
                  child: Container(
                    color: Theme.of(context).colorScheme.background,
                    height: 10,
                    width: double.infinity,
                  ),
                ),
                const SizedBox(height: 5),
                Shimmer.fromColors(
                  baseColor: AppColors.baseShimmer,
                  highlightColor: AppColors.highlightShimmer,
                  child: Container(
                    color: Theme.of(context).colorScheme.background,
                    height: 10,
                    width: double.infinity,
                  ),
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Shimmer.fromColors(
                    baseColor: AppColors.baseShimmer,
                    highlightColor: AppColors.highlightShimmer,
                    child: Container(
                      color: Theme.of(context).colorScheme.background,
                      height: 15,
                      width: 150,
                    ),
                  ),
                )
              ]),
            ),
          ),
        ],
      )),
    );
  }
}
