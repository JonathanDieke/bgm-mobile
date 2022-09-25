import 'package:flutter/material.dart';

class ButtonWidget extends StatefulWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const ButtonWidget({Key? key, required this.isLoading, required this.onPressed})
      : super(key: key);

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return //Bouton de soumission
        Container(
      constraints: BoxConstraints(
        minWidth: screenSize.width,
        minHeight: 50.0,
      ),
      decoration: const BoxDecoration(
        color: Colors.deepOrange,
        borderRadius: BorderRadius.all(
          Radius.elliptical(10, 10),
        ),
      ),
      child: !widget.isLoading
          // ignore: deprecated_member_use
          ? RaisedButton(
              onPressed: widget.onPressed,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.elliptical(10, 10),
                ),
              ),
              padding: const EdgeInsets.all(0.0),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.deepOrange,
                  borderRadius: BorderRadius.all(
                    Radius.elliptical(10, 10),
                  ),
                ),
                child: Container(
                  constraints: BoxConstraints(
                    minWidth: screenSize.width,
                    minHeight: 50.0,
                  ),
                  alignment: Alignment.center,
                  child: const Text(
                    "Enregistrer",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          : const Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.deepOrange,
                strokeWidth: 5,
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.white,
                ),
              ),
            ),
    );
  }
}
