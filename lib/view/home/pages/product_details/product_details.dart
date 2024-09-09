import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../core/design/app_name_text.dart';
import '../../../../core/design/sub_title_text.dart';
import '../../../../core/design/title_text.dart';
import '../../../../core/logic/helper_methods.dart';
import '../../../../core/providers/product_provider.dart';
import '../../../../core/providers/wishlist_provider.dart';
import '../../../../core/utils/spacing.dart';
import '../../../../core/utils/text_styles.dart';
import '../cart/cart_screen.dart';

class ProductDetails extends StatelessWidget {
  static const routeName = "/ProductDetails";
  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productProvider = Provider.of<ProductProvider>(context,listen: false);
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final getCurrentProduct = productProvider.findByProductId(productId);
    final wishlistProvider = Provider.of<WishlistProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title:
            AppNameText(text: "ShopSmart", style: TextStyles.textStyle20Bold),
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(IconlyLight.arrowLeft2),
          ),
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
                navigateTo(const CartScreen());
              },
              icon: const Icon(
                IconlyLight.bag,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
      body: getCurrentProduct == null ? const SizedBox.shrink(): ListView(
        children: [
          FancyShimmerImage(
            imageUrl: getCurrentProduct.productImage,
            height: size.height * 0.38.h,
            width: double.infinity.w,
            boxFit: BoxFit.contain,
          ),
          verticalSpace(10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        getCurrentProduct.productTitle,
                        style: TextStyles.textStyle20Bold,
                      ),
                    ),
                    SubTitleTextWidget(
                      label: "${getCurrentProduct.productPrice}\$",
                      textStyle: TextStyles.textStyle18Normal.copyWith(
                        color: Colors.blue,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                verticalSpace(25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Material(
                      color: const Color(0xffC5E9FF),
                      shape: const CircleBorder(),
                      child: IconButton(
                        onPressed: () {
                          wishlistProvider.addOrRemoveFromWishlist(
                            productId: getCurrentProduct.productId,
                          );
                        },
                        icon: Icon(
                          wishlistProvider.isProductInWishlist(productId: getCurrentProduct.productId)
                              ? IconlyBold.heart
                              : IconlyLight.heart,
                          color: wishlistProvider.isProductInWishlist(productId: getCurrentProduct.productId)
                              ? Colors.red
                              : Colors.grey,
                        ),
                      ),
                    ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(300, 50),
                        backgroundColor: const Color(0xffC5E9FF),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                      ),
                      onPressed: () {},
                      icon: const Icon(Icons.add_shopping_cart),
                      label: const Text(
                        "Add To Cart",
                      ),
                    ),
                  ],
                ),
                verticalSpace(25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TitleTextWidget(
                        label: "About this item",
                      textStyle: TextStyles.textStyle20Bold,
                    ),
                    TitleTextWidget(
                        label: "In ${getCurrentProduct.productCategory}",
                      textStyle: TextStyles.textStyle18Normal,
                    ),
                  ],
                ),
                verticalSpace(25),
                TitleTextWidget(
                  label: getCurrentProduct.productDescription,
                  maxLines: 9,
                  textStyle: TextStyles.textStyle18Normal.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
