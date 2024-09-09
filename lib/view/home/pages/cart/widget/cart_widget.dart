import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../../core/design/sub_title_text.dart';
import '../../../../../core/design/title_text.dart';
import '../../../../../core/providers/cart_provider.dart';
import '../../../../../core/providers/product_provider.dart';
import '../../../../../core/providers/wishlist_provider.dart';
import '../../../../../core/utils/spacing.dart';
import '../../../../../core/utils/text_styles.dart';
import 'cart_model.dart';
import 'quantity_bottom_sheet_widget.dart';

class CartItem extends StatelessWidget {
  const CartItem({super.key});

  @override
  Widget build(BuildContext context) {
    final cartModelProvider = Provider.of<CartModel>(context);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final productProvider = Provider.of<ProductProvider>(context);
    final getCurrProduct =
        productProvider.findByProductId(cartModelProvider.productId);
    final cartProvider = Provider.of<CartProvider>(context);
    Size size = MediaQuery.of(context).size;

    return getCurrProduct == null
        ? const SizedBox.shrink()
        : FittedBox(
            child: IntrinsicWidth(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12.r),
                      child: FancyShimmerImage(
                        imageUrl: getCurrProduct.productImage,
                        height: size.height * 0.2.h,
                        width: size.height * 0.2.w,
                        boxFit: BoxFit.contain,
                      ),
                    ),
                    horizontalSpace(10),
                    IntrinsicWidth(
                      child: Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: size.width * 0.6.w,
                                child: TitleTextWidget(
                                  label: getCurrProduct.productTitle,
                                  textStyle: TextStyles.textStyle20Bold,
                                  maxLines: 2,
                                ),
                              ),
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      cartProvider.removeOneItem(
                                        productId: getCurrProduct.productId,
                                      );
                                    },
                                    icon: const Icon(
                                      IconlyLight.delete,
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      wishlistProvider.addOrRemoveFromWishlist(
                                        productId: getCurrProduct.productId,
                                      );
                                    },
                                    icon: Icon(
                                      wishlistProvider.isProductInWishlist(productId: getCurrProduct.productId)
                                          ? IconlyBold.heart
                                          : IconlyLight.heart,
                                      color: wishlistProvider.isProductInWishlist(productId: getCurrProduct.productId)
                                          ? Colors.red
                                          : Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SubTitleTextWidget(
                                label: "${getCurrProduct.productPrice}\$",
                                textStyle:
                                    TextStyles.textStyle18Normal.copyWith(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 22,
                                ),
                              ),
                              const Spacer(),
                              //const OutlinedButtonIcon(),
                              OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                  textStyle:
                                      TextStyles.textStyle18Normal.copyWith(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30.r),
                                  ),
                                ),
                                onPressed: () async {
                                  await showModalBottomSheet(
                                    backgroundColor: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(16.r),
                                        topRight: Radius.circular(16.r),
                                      ),
                                    ),
                                    context: context,
                                    builder: (context) {
                                      return QuantityBottomSheetWidget(
                                        cartModel: cartModelProvider,
                                      );
                                    },
                                  );
                                },
                                icon: const Icon(IconlyLight.arrowDown2),
                                label:
                                    Text("Qty: ${cartModelProvider.quantity} "),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
