import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:ionicons/ionicons.dart';
import '../../../core/design/title_text.dart';
import '../../../core/utils/text_styles.dart';

class PickImageDialogs {
  static Future<void> imagePickDialogs({
    required BuildContext context,
    required Function cameraFunction,
    required Function galleryFunction,
    required Function removeFunction,
  }) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: TitleTextWidget(
              label: "Choose options",
              textStyle: TextStyles.textStyle18Normal,
            ),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                TextButton.icon(
                  onPressed: () {
                    cameraFunction();
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  icon: const Icon(IconlyLight.camera),
                  label: const Text("Camera"),
                ),
                TextButton.icon(
                  onPressed: () {
                    galleryFunction();
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  icon: const Icon(Ionicons.image),
                  label: const Text("Gallery"),
                ),
                TextButton.icon(
                  onPressed: () {
                    removeFunction();
                    if (Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
                  icon: const Icon(Icons.remove_circle_outline,
                      color: Colors.red),
                  label: const Text("Remove"),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
