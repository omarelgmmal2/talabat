import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../../../core/design/app_image.dart';
import '../../../../../../core/design/empty_bag_widget.dart';
import '../../../../../../core/design/title_text.dart';
import '../../../../../../core/providers/viewed_provider.dart';
import '../../../../../../core/utils/assets.dart';
import '../../../../../../core/utils/text_styles.dart';
import '../../../search/widget/item_product.dart';
import '../../widget/my_app_methods.dart';

class ViewedRecentlyScreen extends StatelessWidget {
  const ViewedRecentlyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final viewedProvider = Provider.of<ViewedProdProvider>(context);
    return  viewedProvider.getViewedProdItems.isEmpty ?
    const Scaffold(
      body: EmptyBagWidget(
        img: AssetsData.order,
        text: "Whoops!",
        title: "Your view recently is empty",
        subTitle:
        "Looks like you have not added anything to your cart.\nGo ahead & explore top categories",
        buttonText: "Shop now",
      ),
    ) : Scaffold(
      appBar: AppBar(
        title: TitleTextWidget(
          label: "Viewed recently (${viewedProvider.getViewedProdItems.length})",
          textStyle: TextStyles.textStyle20Bold,
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8.0),
            height: 40.h,
            width: 40.w,
            decoration: BoxDecoration(
              color: const Color(0xffC5E9FF),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: IconButton(
              onPressed: () {
                MyAppMethods.showErrorORWarningDialog(
                    isError: false,
                    context: context,
                    subtitle: "Remove items",
                    function: () {
                      viewedProvider.clearLocalViewed();
                    });
              },
              icon: const Icon(
                CupertinoIcons.delete,
                color: Colors.red,
              ),
            ),
          ),
        ],
        leading: const Padding(
          padding: EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
          child: AppImage(
            AssetsData.shoppingCart,
          ),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
        itemCount: viewedProvider.getViewedProdItems.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 139 / 250,
          mainAxisSpacing: 16,
          crossAxisSpacing: 12,
        ),
        itemBuilder: ((context, index) {
          return ItemProduct(
            productId: viewedProvider.getViewedProdItems.values
                .toList()[index]
                .productId,
          );
        }),
      ),
    );
  }
}
