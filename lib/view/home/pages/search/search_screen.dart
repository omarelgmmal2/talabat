import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';
import '../../../../core/design/app_image.dart';
import '../../../../core/design/app_input.dart';
import '../../../../core/design/empty_bag_widget.dart';
import '../../../../core/design/title_text.dart';
import '../../../../core/providers/product_provider.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/spacing.dart';
import '../../../../core/utils/text_styles.dart';
import '../main/widget/product_model.dart';
import 'widget/item_product.dart';

class SearchScreen extends StatefulWidget {
  static const routeName = "/SearchScreen";

  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final searchTextController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    searchTextController.dispose();
  }

  List<ProductModel> productSearchList = [];

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductProvider>(context);
    String? passedCategory =
        ModalRoute.of(context)!.settings.arguments as String?;
    final List<ProductModel> productList = passedCategory == null
        ? productProvider.getProducts
        : productProvider.findByCategory(categoryName: passedCategory);
    return Scaffold(
      appBar: AppBar(
        title: TitleTextWidget(
          label: passedCategory ?? "Store Product",
          textStyle: TextStyles.textStyle20Bold,
        ),
        leading: const Padding(
          padding: EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
          child: AppImage(
            AssetsData.shoppingCart,
          ),
        ),
      ),
      body: productList.isEmpty
          ? const EmptyBagWidget(
              img: AssetsData.bagWish,
              text: "Whoops!",
              title: "Your wishlist is empty",
              subTitle:
                  "Looks like you have not added anything to your cart.\nGo ahead & explore top categories",
              buttonText: "Shop now",
            )
          : ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              children: [
                AppInput(
                  hintText: "Search",
                  controller: searchTextController,
                  isFilled: true,
                  onChanged: (value) {
                    /*
                    setState(() {
                      productSearchList = productProvider.searchQuery(
                          searchText: searchTextController.text,
                        passedList: productList,
                      );
                    });
                     */
                  },
                  onFieldSubmitted: (value) {
                    setState(() {
                      productSearchList = productProvider.searchQuery(
                          searchText: searchTextController.text,
                        passedList: productList,
                      );
                    });
                  },
                  iconData: IconlyLight.search,
                  suffixIcon: IconButton(
                    onPressed: () {
                      searchTextController.clear();
                      FocusScope.of(context).unfocus();
                    },
                    icon: const Icon(
                      Icons.clear_outlined,
                      color: Colors.red,
                    ),
                  ),
                ),
                verticalSpace(16),
                if (searchTextController.text.isNotEmpty &&
                    productSearchList.isEmpty) ...[
                  const Text(
                    textAlign: TextAlign.center,
                      "No result found",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: searchTextController.text.isNotEmpty
                      ? productSearchList.length
                      : productList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 139 / 250,
                    mainAxisSpacing: 16,
                    crossAxisSpacing: 12,
                  ),
                  itemBuilder: ((context, index) {
                    return ItemProduct(
                      productId: searchTextController.text.isNotEmpty
                          ? productSearchList[index].productId
                          : productList[index].productId,
                    );
                  }),
                ),
              ],
            ),
    );
  }
}
