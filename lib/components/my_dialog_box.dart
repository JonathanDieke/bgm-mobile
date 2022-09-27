import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ConstantsDialogBox {
  ConstantsDialogBox._();
  static const double padding = 15;
  static const double containerRadius = 10;
  static const double containerMargin = 10;
  static const double avatarRadius = 25;
}

class CustomDialogBox extends StatefulWidget {
  final String title, description;
  final Widget? footer;

  const CustomDialogBox({
    Key? key,
    this.title = "",
    this.description = "",
    this.footer,
  }) : super(key: key);

  @override
  _CustomDialogBoxState createState() => _CustomDialogBoxState();
}

class _CustomDialogBoxState extends State<CustomDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(ConstantsDialogBox.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Stack(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.only(
              left: ConstantsDialogBox.padding,
              top: ConstantsDialogBox.padding,
              right: ConstantsDialogBox.padding,
            ),
            margin: const EdgeInsets.only(top: ConstantsDialogBox.containerMargin),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.circular(ConstantsDialogBox.containerRadius),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.65),
                  offset: const Offset(0, 3),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text(
                  widget.title,
                  style: const TextStyle(
                      fontSize: 23, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  widget.description,
                  style: const TextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 22,
                ),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //   children: [
                //     // Retour buttonform
                //     // const FlatButton(
                //     //   onPressed: () {},
                //     //   child: Text(
                //     //     "Retour",
                //     //     style: TextStyle(fontSize: 16),
                //     //   ),
                //     // ),
                //     // OK button
                //     FlatButton(
                //       onPressed: () {
                //         SystemChannels.platform
                //             .invokeMethod('SystemNavigator.pop');
                //       },
                //       child: Text(
                //         "OK",
                //         style: TextStyle(fontSize: 16),
                //       ),
                //     ),
                //   ],
                // )
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: widget.footer,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // contentBox(context) {
  //   return Stack(
  //     children: <Widget>[
  //       Container(
  //         padding: EdgeInsets.only(
  //           left: Constants.padding,
  //           top: Constants.padding,
  //           right: Constants.padding,
  //         ),
  //         margin: EdgeInsets.only(top: Constants.avatarRadius),
  //         decoration: BoxDecoration(
  //             shape: BoxShape.rectangle,
  //             color: Colors.white,
  //             borderRadius: BorderRadius.circular(Constants.padding),
  //             boxShadow: [
  //               BoxShadow(
  //                   color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
  //             ]),
  //         child: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: <Widget>[
  //             Text(
  //               widget.title,
  //               style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
  //             ),
  //             SizedBox(
  //               height: 15,
  //             ),
  //             Text(
  //               widget.description,
  //               style: TextStyle(fontSize: 14),
  //               textAlign: TextAlign.center,
  //             ),
  //             SizedBox(
  //               height: 22,
  //             ),
  //             Align(
  //               alignment: Alignment.bottomRight,
  //               child: FlatButton(
  //                   onPressed: () {
  //                     Navigator.of(context).pop(true);
  //                   },
  //                   child: Text(
  //                     widget.text,
  //                     style: TextStyle(fontSize: 18),
  //                   )),
  //             ),
  //             Align(
  //               alignment: Alignment.bottomRight,
  //               child: FlatButton(
  //                   onPressed: () {
  //                     Navigator.of(context).pop(true);
  //                   },
  //                   child: Text(
  //                     widget.text,
  //                     style: TextStyle(fontSize: 18),
  //                   )),
  //             ),
  //           ],
  //         ),
  //       ),
  //       // Positioned(
  //       //   left: Constants.padding,
  //       //     right: Constants.padding,
  //       //     child: CircleAvatar(
  //       //       backgroundColor: Colors.transparent,
  //       //       radius: Constants.avatarRadius,
  //       //       child: ClipRRect(
  //       //         borderRadius: BorderRadius.all(Radius.circular(Constants.avatarRadius)),
  //       //           child: Image.asset("assets/model.jpeg")
  //       //       ),
  //       //     ),
  //       // ),
  //     ],
  //   );
  // }
}
