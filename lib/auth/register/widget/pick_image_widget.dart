import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class PickImageWidget extends StatelessWidget {
  final XFile? pickedImage;
  final Function function;

  const PickImageWidget({
    super.key,
    this.pickedImage,
    required this.function,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0.r),
            child: pickedImage == null
                ? Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0.r),
                      border: Border.all(),
                    ),
                  )
                : Image.file(
                    File(
                      pickedImage!.path,
                    ),
                    fit: BoxFit.fill,
                  ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Material(
            borderRadius: BorderRadius.circular(16.0.r),
            color: Colors.lightBlue,
            child: InkWell(
              //splashColor: Colors.red,
              borderRadius: BorderRadius.circular(16.0.r),
              onTap: () {
                function();
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  IconlyLight.camera,
                  size: 20,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
