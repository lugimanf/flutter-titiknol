import 'package:flutter/material.dart';

const double mainContainerMarginTop30 = 30;
const double mainContainerMarginTop50 = 50;
const double mainContainerMarginBottom = 10;
const double mainContainerMarginLeft = 10;
const double mainContainerMarginRight = 10;
const double mainContainerPaddingTop = 0;
const double mainContainerPaddingBottom = 0;
const double mainContainerPaddingLeft = 0;
const double mainContainerPaddingRight = 0;
const double heightScreen707 = 708;

class MainContainer extends StatefulWidget {
  const MainContainer({super.key, required this.child, this.useMargin = true});

  final Widget child;
  final bool useMargin;

  static MainContainerState of(BuildContext context) {
    return context.findAncestorStateOfType<MainContainerState>()!;
  }

  @override
  State<MainContainer> createState() => MainContainerState();
}

class MainContainerState extends State<MainContainer> {
  @override
  Widget build(BuildContext context) {
    double heightScreen = MediaQuery.sizeOf(context).height;
    double marginTop = mainContainerMarginTop30;
    if (heightScreen > heightScreen707) {
      marginTop = mainContainerMarginTop50;
    }

    if (!widget.useMargin) {
      marginTop = 0;
    }

    return Container(
      constraints: BoxConstraints(
        minHeight: MediaQuery.of(context).size.height,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.grey.shade900,
            Colors.black,
            Colors.grey.shade800,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Container(
        width: double.infinity,
        margin: EdgeInsets.only(
            top: marginTop,
            bottom: mainContainerMarginBottom,
            left: mainContainerMarginLeft,
            right: mainContainerMarginRight),
        padding: const EdgeInsets.only(
            top: mainContainerPaddingTop,
            bottom: mainContainerPaddingBottom,
            left: mainContainerPaddingLeft,
            right: mainContainerPaddingRight),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight,
              ),
              child: widget.child,
            );
          },
        ),
      ),
    );
  }
}
