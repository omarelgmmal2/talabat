import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../../core/design/sub_title_text.dart';
import '../../../../../core/providers/cart_provider.dart';
import '../../../../../core/utils/spacing.dart';
import '../../../../../core/utils/text_styles.dart';
import 'cart_model.dart';

class QuantityBottomSheetWidget extends StatelessWidget {
  final CartModel cartModel;
  const QuantityBottomSheetWidget({super.key, required this.cartModel});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          verticalSpace(20),
          Container(
            height: 6.h,
            width: 50.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0.r),
              color: Colors.grey,
            ),
          ),
          verticalSpace(20),
          Expanded(
            child: ListView.builder(
              itemCount: 30,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    cartProvider.updateQuantity(
                      productId: cartModel.productId,
                      quantity: index + 1,
                    );
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: Center(
                      child: SubTitleTextWidget(
                        label: "${index + 1}",
                        textStyle: TextStyles.textStyle20Bold.copyWith(
                          fontWeight: FontWeight.w500,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
