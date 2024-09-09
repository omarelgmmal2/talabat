import 'package:flutter/material.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget mobileWidget;
  final Widget tabletWidget;
  final Widget websiteWidget;

  const ResponsiveLayout({
    super.key,
    required this.mobileWidget,
    required this.tabletWidget,
    required this.websiteWidget,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if(constraints.maxWidth >= 1200){
          return websiteWidget ?? mobileWidget;
        }else if(constraints.maxWidth >= 900){
          return tabletWidget ?? mobileWidget;
        }else{
          return mobileWidget;
        }
      },
    );
  }
}
