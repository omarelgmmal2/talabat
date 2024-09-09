import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../../core/design/sub_title_text.dart';
import '../../../../../core/design/title_text.dart';
import '../../../../../core/providers/cart_provider.dart';
import '../../../../../core/providers/product_provider.dart';
import '../../../../../core/providers/viewed_provider.dart';
import '../../../../../core/providers/wishlist_provider.dart';
import '../../../../../core/utils/spacing.dart';
import '../../../../../core/utils/text_styles.dart';
import '../../product_details/product_details.dart';

class ItemProduct extends StatefulWidget {
  final String productId;

  const ItemProduct({super.key, required this.productId});

  @override
  State<ItemProduct> createState() => _ItemProductState();
}

class _ItemProductState extends State<ItemProduct> {
  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    final viewedProvider = Provider.of<ViewedProdProvider>(context);
    final getCurrentProduct = productProvider.findByProductId(widget.productId);
    Size size = MediaQuery.of(context).size;
    final cartProvider = Provider.of<CartProvider>(context);
    return getCurrentProduct == null
        ? const SizedBox.shrink()
        : Padding(
            padding: const EdgeInsets.all(3.0),
            child: GestureDetector(
              onTap: () async {
                viewedProvider.addOrRemoveProductToHistory(
                  productId: getCurrentProduct.productId,
                );
                await Navigator.pushNamed(
                  context,
                  ProductDetails.routeName,
                  arguments: getCurrentProduct.productId,
                );
              },
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(30.r),
                    child: FancyShimmerImage(
                      imageUrl: getCurrentProduct.productImage,
                      width: double.infinity.w,
                      height: size.height * 0.22.h,
                      boxFit: BoxFit.contain,
                    ),
                  ),
                  verticalSpace(16),
                  Row(
                    children: [
                      Flexible(
                        flex: 5,
                        child: TitleTextWidget(
                          maxLines: 2,
                          label: getCurrentProduct.productTitle,
                          textStyle:
                              TextStyles.textStyle20Bold.copyWith(fontSize: 17),
                        ),
                      ),
                      const Spacer(),
                      Flexible(
                        child: IconButton(
                          padding: const EdgeInsets.only(right: 10),
                          onPressed: () {
                            wishlistProvider.addOrRemoveFromWishlist(
                              productId: getCurrentProduct.productId,
                            );
                          },
                          icon: Icon(
                            wishlistProvider.isProductInWishlist(
                                    productId: getCurrentProduct.productId)
                                ? IconlyBold.heart
                                : IconlyLight.heart,
                            color: wishlistProvider.isProductInWishlist(
                                    productId: getCurrentProduct.productId)
                                ? Colors.red
                                : Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        flex: 3,
                        child: SubTitleTextWidget(
                          label: "${getCurrentProduct.productPrice}\$",
                          textStyle: TextStyles.textStyle18Normal.copyWith(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      Flexible(
                        child: Material(
                          borderRadius: BorderRadius.circular(10.r),
                          color: Colors.blue,
                          child: InkWell(
                            splashColor: Colors.greenAccent,
                            borderRadius: BorderRadius.circular(10.r),
                            onTap: () {
                              if (cartProvider.isProductInCart(
                                  productId: getCurrentProduct.productId)) {
                                return;
                              }
                              cartProvider.addProductToCart(
                                  productId: getCurrentProduct.productId);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(
                                cartProvider.isProductInCart(
                                  productId: getCurrentProduct.productId,
                                )
                                    ? Icons.check
                                    : Icons.add_shopping_cart_rounded,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  verticalSpace(10),
                ],
              ),
            ),
          );
  }
}
