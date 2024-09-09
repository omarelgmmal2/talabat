import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/design/app_image.dart';
import '../../../../../core/utils/app_constants.dart';
import '../../../../../core/utils/spacing.dart';

class CustomCarouselSliderWidget extends StatefulWidget {
  const CustomCarouselSliderWidget({super.key});

  @override
  State<CustomCarouselSliderWidget> createState() =>
      _CustomCarouselSliderWidgetState();
}

class _CustomCarouselSliderWidgetState
    extends State<CustomCarouselSliderWidget> {

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: List.generate(
            AppConstants.bannersImages.length,
            (index) => ClipRRect(
              borderRadius: BorderRadius.circular(15.r),
              child: AppImage(
                AppConstants.bannersImages[index],
                fit: BoxFit.fill,
                height: 200,
                width: double.infinity,
              ),
            ),
          ),
          options: CarouselOptions(
            height: 200,
            autoPlay: true,
            viewportFraction: 1,
            onPageChanged: (index, reason) {
              currentIndex = index;
              setState(() {});
            },
          ),
        ),
        verticalSpace(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            AppConstants.bannersImages.length,
            (index) => Padding(
              padding: const EdgeInsetsDirectional.only(end: 3),
              child: CircleAvatar(
                radius: index == currentIndex ? 6 : 4,
                backgroundColor:
                    index == currentIndex ? Colors.blue : Colors.grey,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
