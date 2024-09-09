import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../../../core/design/sub_title_text.dart';
import '../../../../../../../core/design/title_text.dart';
import '../../../../../../../core/utils/app_constants.dart';
import '../../../../../../../core/utils/spacing.dart';
import '../../../../../../../core/utils/text_styles.dart';

class OrdersWidgetFree extends StatefulWidget {
  const OrdersWidgetFree({super.key});

  @override
  State<OrdersWidgetFree> createState() => _OrdersWidgetFreeState();
}

class _OrdersWidgetFreeState extends State<OrdersWidgetFree> {
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: FancyShimmerImage(
              height: size.width * 0.25.h,
              width: size.width * 0.25.w,
              imageUrl: AppConstants.productImageUrl,
            ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: TitleTextWidget(
                          label: 'productTitle',
                          textStyle: TextStyles.textStyle20Bold.copyWith(
                            fontSize: 15.sp,
                          ),
                          maxLines: 2,
                        ),
                      ),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.clear,
                            color: Colors.red,
                            size: 22,
                          ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      TitleTextWidget(
                        label: 'Price:  ',
                        textStyle: TextStyles.textStyle20Bold.copyWith(
                          fontSize: 15.sp,
                        ),
                      ),
                      Flexible(
                        child: SubTitleTextWidget(
                          label: "11.99 \$",
                          textStyle: TextStyles.textStyle18Normal.copyWith(
                            fontSize: 15.sp,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(5),
                  SubTitleTextWidget(
                    label: "Qty: 10",
                    textStyle: TextStyles.textStyle18Normal.copyWith(
                      fontSize: 15.sp,
                    ),
                  ),
                  verticalSpace(5),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}