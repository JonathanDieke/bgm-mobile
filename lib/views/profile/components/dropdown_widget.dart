import 'package:flutter/material.dart';

class DropdownWidget extends StatefulWidget {
  final String label;
  final List<DropdownMenuItem<String>> items;
  // final Icon icon ;
  final String initialValue;
  final ValueChanged<String?> onChanged;

  const DropdownWidget({
    Key? key,
    required this.label,
    required this.initialValue,
    required this.items,
    // required this.icon,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  @override
  Widget build(BuildContext context) {
    print("\n\n\n\n\n\nintial value : ${widget.initialValue} -- \n\n\n\n\n\n");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField(
          isExpanded: true,
          elevation: 3,
          // icon: widget.icon ?? null,
          value: widget.initialValue,
          items: widget.items,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onChanged: widget.onChanged,
        )
      ],
    );
  }
}
