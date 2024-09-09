import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../core/design/app_image.dart';
import '../../../../core/design/empty_bag_widget.dart';
import '../../../../core/design/title_text.dart';
import '../../../../core/providers/cart_provider.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/spacing.dart';
import '../../../../core/utils/text_styles.dart';
import '../profile/widget/my_app_methods.dart';
import 'widget/bottom_sheet_widget.dart';
import 'widget/cart_widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  final bool isEmpty = false;

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return cartProvider.getCartItems.isEmpty
        ? const Scaffold(
            body: EmptyBagWidget(
              img: AssetsData.shoppingCart,
              text: "Whoops!",
              title: "Your cart is empty",
              subTitle:
                  "Looks like you have not added anything to your cart.\nGo ahead & explore top categories",
              buttonText: "Shop now",
            ),
          )
        : Scaffold(
            appBar: AppBar(
              title: TitleTextWidget(
                label: "Cart (${cartProvider.getCartItems.length})",
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
                            cartProvider.clearLocalCart();
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
            bottomSheet: const CartBottomCheckout(),
            body: Column(
              children: [
                Expanded(
                  child: ListView.separated(
                    itemCount: cartProvider.getCartItems.length,
                    separatorBuilder: (context, index) => verticalSpace(10),
                    itemBuilder: (context, index) =>
                        ChangeNotifierProvider.value(
                      value: cartProvider.getCartItems.values
                          .toList()
                          .reversed
                          .toList()[index],
                      child: const CartItem(),
                    ),
                  ),
                ),
                verticalSpace(55),
              ],
            ),
          );
  }
}
