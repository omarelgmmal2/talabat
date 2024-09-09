import 'package:flutter/material.dart';
import '../../../../../../core/design/empty_bag_widget.dart';
import '../../../../../../core/design/title_text.dart';
import '../../../../../../core/utils/assets.dart';
import '../../../../../../core/utils/text_styles.dart';
import 'widget/orders_widget.dart';

class AllOrderScreen extends StatefulWidget {
  const AllOrderScreen({super.key});

  @override
  State<AllOrderScreen> createState() => _AllOrderScreenState();
}

class _AllOrderScreenState extends State<AllOrderScreen> {

  bool isEmptyOrders = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: TitleTextWidget(
            label: 'Placed orders',
            textStyle: TextStyles.textStyle20Bold,
          ),
        ),
        body: isEmptyOrders
            ? const EmptyBagWidget(
            img: AssetsData.order,
            title: "No orders has been placed yet",
            subTitle: "",
            buttonText: "Shop now",
        )
            : ListView.separated(
          itemCount: 15,
          itemBuilder: (ctx, index) {
            return const Padding(
              padding: EdgeInsets.symmetric(horizontal: 2, vertical: 6),
              child: OrdersWidgetFree(),
            );
          },
          separatorBuilder: (BuildContext context, int index) {
            return const Divider();
          },
        ),
    );
  }
}
