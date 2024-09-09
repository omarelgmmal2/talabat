import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../../../core/design/app_button.dart';
import '../../../../../core/design/sub_title_text.dart';
import '../../../../../core/design/title_text.dart';
import '../../../../../core/providers/cart_provider.dart';
import '../../../../../core/providers/product_provider.dart';
import '../../../../../core/utils/text_styles.dart';

class CartBottomCheckout extends StatelessWidget {
  const CartBottomCheckout({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        border: const Border(
          top: BorderSide(width: 1, color: Colors.grey),
        ),
      ),
      child: SizedBox(
        height: kBottomNavigationBarHeight + 10,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      child: TitleTextWidget(
                          label:
                              "Total (${cartProvider.getCartItems.length} products/${cartProvider.getQty()} Items)"),
                    ),
                    SubTitleTextWidget(
                      label:
                          "${cartProvider.getTotal(productProvider: productProvider)}\$",
                      textStyle: TextStyles.textStyle18Normal.copyWith(
                        color: Colors.blue,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              AppButton(
                buttonStyle: FilledButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                onPress: () {},
                text: "Checkout",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
