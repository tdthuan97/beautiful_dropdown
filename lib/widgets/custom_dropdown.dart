import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getxdemo/controllers/product_controller.dart';
import 'package:getxdemo/models/drop_down_item.dart';

class CustomDropdown extends StatefulWidget {
  final DropDownItem itemSelected;
  final List<DropDownItem> list;
  final Function onChanged;
  final GlobalKey actionKey;
  final double height, width, xPosition, yPosition;
  final bool isDropdownOpened = false;
  final OverlayEntry floatingDropdown;
  final Function onTap;
  final Color backgroundColor;

  const CustomDropdown({
    Key key,
    this.itemSelected,
    this.list,
    this.onChanged,
    this.actionKey,
    this.height,
    this.width,
    this.xPosition,
    this.yPosition,
    this.floatingDropdown,
    this.onTap,
    this.backgroundColor,
  }) : super(key: key);

  @override
  _CustomDropdownState createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  // GlobalKey actionKey;
  // double height, width, xPosition, yPosition;
  // bool isDropdownOpened = false;
  // OverlayEntry floatingDropdown;

  @override
  void initState() {
    // actionKey = LabeledGlobalKey(widget.itemSelected.text);
    super.initState();
  }

  // void findDropDownData() {
  //   RenderBox renderBox = actionKey.currentContext.findRenderObject();
  //   height = renderBox.size.height;
  //   width = renderBox.size.width;
  //   Offset offset = renderBox.localToGlobal(Offset.zero);
  //   xPosition = offset.dx;
  //   yPosition = offset.dy;
  //   print('height ' + height.toString());
  //   print('width ' + width.toString());
  //   print('xPosition ' + xPosition.toString());
  //   print('yPosition ' + yPosition.toString());
  // }
  //
  // OverlayEntry _createFloatingDropdown() {
  //   return OverlayEntry(builder: (context) {
  //     return Positioned(
  //       left: xPosition,
  //       width: width,
  //       top: yPosition + height,
  //       height: widget.list.length * height + 40,
  //       child: AnimatedContainer(
  //         duration: Duration(milliseconds: 5000),
  //         child:
  //         DropDown(
  //           itemSelected: widget.itemSelected,
  //           list: widget.list,
  //           onChanged: widget.onChanged,
  //           itemHeight: height,
  //         ),
  //       ),
  //     );
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: widget.actionKey,
      onTap: widget.onTap,
      //     () {
      //   setState(() {
      //     if (widget.isDropdownOpened) {
      //       widget.floatingDropdown.remove();
      //     } else {
      //       findDropDownData();
      //
      //       floatingDropdown = _createFloatingDropdown();
      //       Overlay.of(context).insert(floatingDropdown);
      //     }
      //
      //     isDropdownOpened = !isDropdownOpened;
      //   });
      // },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: widget.backgroundColor,
        ),
        child: Row(
          children: [
            Text(
              widget.itemSelected.text.toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Icon(
              Icons.arrow_drop_down,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}

class DropDown extends StatelessWidget {
  final double itemHeight;
  final DropDownItem itemSelected;
  final List<DropDownItem> list;
  final Function onChanged;
  final Color backgroundColor;
  final Color backgroundColorSelected;
  final AnimationController animationController;

  const DropDown(
      {Key key,
      this.itemHeight,
      this.list,
      this.onChanged,
      this.itemSelected,
      this.backgroundColor,
      this.backgroundColorSelected,
      this.animationController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 5,
        ),
        ScaleTransition(
          scale: Tween(begin: 0.0, end: 1.0).animate(CurvedAnimation(
              curve: Interval(0.0, 1.0, curve: Curves.ease),
              parent: animationController)),
          child: Align(
            alignment: Alignment(-0.85, 0),
            child: ClipPath(
              clipper: ArrowClipper(),
              child: Container(
                height: 20,
                width: 30,
                decoration: BoxDecoration(color: backgroundColor),
              ),
            ),
          ),
        ),
        // FadeAnimation(
        //   0,
        //   Align(
        //     alignment: Alignment(-0.85, 0),
        //     child: ClipPath(
        //       clipper: ArrowClipper(),
        //       child: Container(
        //         height: 20,
        //         width: 30,
        //         decoration: BoxDecoration(color: backgroundColor),
        //       ),
        //     ),
        //   ),
        // ),
        Material(
          // elevation: 20,
          // shape: ArrowShape(),
          color: Colors.transparent,
          child: Container(
            height: list.length * itemHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                ...list
                    .asMap()
                    .map(
                      (index, item) => MapEntry(
                          index,
                          ScaleTransition(
                            scale: Tween(begin: 0.0, end: 1.0).animate(
                                CurvedAnimation(
                                    curve: Interval(0.2 * index, 1.0,
                                        curve: Curves.ease),
                                    parent: animationController)),
                            child: InkWell(
                              onTap: () => onChanged(item),
                              child: DropDownItemWidget(
                                text: item.text,
                                iconData: item.iconData,
                                isSelected: itemSelected.text == item.text,
                                isFirstItem: item.isFirstItem,
                                isLastItem: item.isLastItem,
                                backgroundColor: backgroundColor,
                                backgroundColorSelected:
                                    backgroundColorSelected,
                              ),
                            ),
                          )
                          // FadeAnimation(
                          //   (0.05 * index) + 0.05,
                          //   InkWell(
                          //     onTap: () => onChanged(item),
                          //     child: DropDownItemWidget(
                          //       text: item.text,
                          //       iconData: item.iconData,
                          //       isSelected: itemSelected.text == item.text,
                          //       isFirstItem: item.isFirstItem,
                          //       isLastItem: item.isLastItem,
                          //       backgroundColor: backgroundColor,
                          //       backgroundColorSelected: backgroundColorSelected,
                          //     ),
                          //   ),
                          // ),
                          ),
                    )
                    .values
                    .toList(),
                // FadeAnimation(
                //   0.15,
                //   DropDownItemWidget.first(
                //     text: 'Add new',
                //     iconData: Icons.add_circle_outline,
                //     isSelected: false,
                //   ),
                // ),
                // FadeAnimation(
                //   0.2,
                //   DropDownItemWidget(
                //     text: 'View Profile',
                //     iconData: Icons.person_outline,
                //     isSelected: true,
                //   ),
                // ),
                // FadeAnimation(
                //   0.25,
                //   DropDownItemWidget(
                //     text: 'Settings',
                //     iconData: Icons.settings,
                //     isSelected: false,
                //   ),
                // ),
                // FadeAnimation(
                //   0.3,
                //   DropDownItemWidget.last(
                //     text: 'Logout',
                //     iconData: Icons.exit_to_app,
                //     isSelected: false,
                //   ),
                // )
              ],
            ),
          ),
        )
      ],
    );
  }
}

// ignore: must_be_immutable
class DropDownItemWidget extends StatelessWidget {
  final String text;
  final IconData iconData;
  final bool isSelected;
  final bool isFirstItem;
  final bool isLastItem;
  final Color backgroundColor;
  final Color backgroundColorSelected;

  DropDownItemWidget({
    Key key,
    this.text,
    this.iconData,
    this.isSelected = false,
    this.isFirstItem = false,
    this.isLastItem = false,
    this.backgroundColor,
    this.backgroundColorSelected,
  }) : super(key: key);

  ProductController productController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.vertical(
            top: isFirstItem ? Radius.circular(8) : Radius.zero,
            bottom: isLastItem ? Radius.circular(8) : Radius.zero,
          ),
          color: productController.itemSelected.value.text == text
              ? backgroundColorSelected
              : backgroundColor,
        ),
        child: Row(
          children: [
            Text(
              text.toUpperCase(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(),
            Icon(
              iconData,
              color: Colors.white,
            )
          ],
        ),
      );
    });
  }
}

class ArrowClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    print('height ${size.height}, width ${size.width}');
    path.moveTo(0, size.height);
    path.lineTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    throw UnimplementedError();
  }
}

class ArrowShape extends ShapeBorder {
  @override
  // TODO: implement dimensions
  EdgeInsetsGeometry get dimensions => throw UnimplementedError();

  @override
  Path getInnerPath(Rect rect, {TextDirection textDirection}) {
    // TODO: implement getInnerPath
    throw UnimplementedError();
  }

  @override
  Path getOuterPath(Rect rect, {TextDirection textDirection}) {
    return getClip(rect.size);
  }

  @override
  void paint(Canvas canvas, Rect rect, {TextDirection textDirection}) {
    // TODO: implement paint
  }

  @override
  ShapeBorder scale(double t) {
    // TODO: implement scale
    throw UnimplementedError();
  }

  Path getClip(Size size) {
    Path path = Path();
    print('height ${size.height}, width ${size.width}');
    path.moveTo(0, size.height);
    path.lineTo(size.width / 2, 0);
    path.lineTo(size.width, size.height);

    return path;
  }
}
