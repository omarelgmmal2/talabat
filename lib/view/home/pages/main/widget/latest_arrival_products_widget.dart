import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../../core/design/sub_title_text.dart';
import '../../../../../core/design/title_text.dart';
import '../../../../../core/providers/cart_provider.dart';
import '../../../../../core/providers/viewed_provider.dart';
import '../../../../../core/providers/wishlist_provider.dart';
import '../../../../../core/utils/spacing.dart';
import '../../../../../core/utils/text_styles.dart';
import '../../product_details/product_details.dart';
import 'product_model.dart';

class LatestArrivalProductsWidget extends StatelessWidget {
  const LatestArrivalProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productModel = Provider.of<ProductModel>(context);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final cartProvider = Provider.of<CartProvider>(context);
    final viewedProvider = Provider.of<ViewedProdProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(right: 8.0, top: 8.0, bottom: 8.0),
      child: GestureDetector(
        onTap: () async {
          viewedProvider.addOrRemoveProductToHistory(
            productId: productModel.productId,
          );
          await Navigator.pushNamed(
            context,
            ProductDetails.routeName,
            arguments: productModel.productId,
          );
        },
        child: SizedBox(
          width: size.width * 0.45.w,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10.r),
                  child: FancyShimmerImage(
                    imageUrl: productModel.productImage,
                    width: size.width * 0.28.w,
                    height: size.width * 0.28.h,
                    boxFit: BoxFit.contain,
                  ),
                ),
              ),
              horizontalSpace(7),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleTextWidget(
                      maxLines: 2,
                      label: productModel.productTitle,
                      textStyle: TextStyles.textStyle20Bold.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    FittedBox(
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              if (cartProvider.isProductInCart(
                                  productId: productModel.productId)) {
                                return;
                              }
                              cartProvider.addProductToCart(
                                  productId: productModel.productId);
                            },
                            icon: Icon(
                              cartProvider.isProductInCart(
                                productId: productModel.productId,
                              )
                                  ? Icons.check
                                  : Icons.add_shopping_cart_rounded,
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              wishlistProvider.addOrRemoveFromWishlist(
                                productId: productModel.productId,
                              );
                            },
                            icon: Icon(
                              wishlistProvider.isProductInWishlist(
                                      productId: productModel.productId)
                                  ? IconlyBold.heart
                                  : IconlyLight.heart,
                              color: wishlistProvider.isProductInWishlist(
                                      productId: productModel.productId)
                                  ? Colors.red
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    FittedBox(
                      child: SubTitleTextWidget(
                        label: "${productModel.productPrice}\$",
                        textStyle: TextStyles.textStyle18Normal.copyWith(
                          color: Colors.blue,
                          fontSize: 18,
                        ),
                      ),
                    ),
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
