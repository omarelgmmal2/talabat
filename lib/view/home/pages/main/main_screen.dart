import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../core/design/app_image.dart';
import '../../../../core/design/app_name_text.dart';
import '../../../../core/design/title_text.dart';
import '../../../../core/providers/product_provider.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/spacing.dart';
import '../../../../core/utils/text_styles.dart';
import 'widget/category_model.dart';
import 'widget/category_rounded_widget.dart';
import 'widget/custom_carousel_slider_widget.dart';
import 'widget/latest_arrival_products_widget.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: AppNameText(
            text: "ShopSmart",
            style: TextStyles.textStyle20Bold
        ),
        leading: const Padding(
          padding: EdgeInsets.only(left: 8.0,top: 8.0,bottom: 8.0),
          child: AppImage(
            AssetsData.shoppingCart,
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 20),
          children: [
            const CustomCarouselSliderWidget(),
            verticalSpace(25),
            TitleTextWidget(
                label: "Latest arrival",
              textStyle: TextStyles.textStyle20Bold,
            ),
            verticalSpace(18),
            SizedBox(
              height: size.height * 0.2.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => ChangeNotifierProvider.value(
                    value: productProvider.getProducts[index],
                      child: const LatestArrivalProductsWidget(),
                  ),
                itemCount: productProvider.getProducts.length,
              ),
            ),
            verticalSpace(10),
            TitleTextWidget(
              label: "Categories",
              textStyle: TextStyles.textStyle20Bold,
            ),
            verticalSpace(18),
            GridView.count(
              shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 4,
              children: List.generate(
                    categoryList.length,
                    (index) => CategoryRoundedWidget(
                        img: categoryList[index].img,
                        name: categoryList[index].name,
                    ),
                ),
            ),
          ],
        ),
      ),
    );
  }
}