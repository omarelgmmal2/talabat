import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../core/design/app_image.dart';
import '../../../../core/design/app_name_text.dart';
import '../../../../core/design/title_text.dart';
import '../../../../core/logic/helper_methods.dart';
import '../../../../core/providers/theme_provider.dart';
import '../../../../core/design/sub_title_text.dart';
import '../../../../core/utils/assets.dart';
import '../../../../core/utils/spacing.dart';
import '../../../../core/utils/text_styles.dart';
import 'screens/address/address.dart';
import 'screens/all_order/all_order.dart';
import 'screens/viewed_recently/viewed_recently.dart';
import 'screens/wishlist/wishlist.dart';
import 'widget/custom_elevated_button_icon.dart';
import 'widget/custom_list_tile.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: false,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: TitleTextWidget(
                  label: "Please login to have ultimate access",
                textStyle: TextStyles.textStyle20Bold,
              ),
            ),
          ),
          verticalSpace(20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              children: [
                Container(
                  height: 60.h,
                  width: 60.w,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).cardColor,
                    border: Border.all(
                        color: Theme.of(context).colorScheme.surface,
                        width: 3.w,
                    ),
                    image: const DecorationImage(
                      image: NetworkImage(
                        "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460__340.png",
                      ),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                horizontalSpace(7),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleTextWidget(label: "Omar Elgmmal"),
                    SubTitleTextWidget(label: "omarelgmmal23@gmail.com"),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TitleTextWidget(label: "General",textStyle: TextStyles.textStyle18Normal,),
                CustomListTile(
                  imagePath: AssetsData.orderSvg,
                  text: "All orders",
                  function: () {
                    navigateTo(const AllOrderScreen());
                  },
                ),
                CustomListTile(
                  imagePath: AssetsData.wishlist,
                  text: "Wishlist",
                  function: () {
                    navigateTo(const WishlistScreen());
                  },
                ),
                CustomListTile(
                  imagePath: AssetsData.recent,
                  text: "Viewed recently",
                  function: () {
                    navigateTo(const ViewedRecentlyScreen());
                  },
                ),
                CustomListTile(
                  imagePath: AssetsData.address,
                  text: "Address",
                  function: () {
                    navigateTo(const AddressScreen());
                  },
                ),
                const Divider(
                  thickness: 1,
                ),
                verticalSpace(7),
                TitleTextWidget(label: "Settings",textStyle: TextStyles.textStyle18Normal,),
                verticalSpace(7),
                SwitchListTile(
                  secondary: AppImage(
                    AssetsData.theme,
                    height: 30.h,
                  ),
                  title: Text(themeProvider.getIsDarkTheme
                      ? "Dark mode"
                      : "Light mode",
                  ),
                  value: themeProvider.getIsDarkTheme,
                  onChanged: (value) {
                    themeProvider.setDarkTheme(themeValue: value);
                  },
                ),
                const Divider(
                  thickness: 1,
                ),
                verticalSpace(7),
                TitleTextWidget(label: "Others",textStyle: TextStyles.textStyle18Normal,),
                verticalSpace(7),
                CustomListTile(
                  imagePath: AssetsData.privacy,
                  text: "Privacy & Policy",
                  function: () {},
                ),
              ],
            ),
          ),
          const Center(
            child: CustomElevatedButtonIcon(),
          ),
        ],
      ),
    );
  }
}
