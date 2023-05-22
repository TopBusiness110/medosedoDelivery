import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medosedoDelivery/utill/dimensions.dart';
import 'package:medosedoDelivery/utill/styles.dart';


class SearchField extends StatefulWidget {
  final TextEditingController controller;
  final String hint;
  final IconData suffixIcon;
  final Function iconPressed;
  final Function onSubmit;
  final Function onChanged;
  const SearchField({Key key, @required this.controller, @required this.hint, @required this.suffixIcon, @required this.iconPressed, this.onSubmit, this.onChanged}) : super(key: key);

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [BoxShadow(color: Colors.grey[Get.isDarkMode ? 800 : 200], spreadRadius: 1, blurRadius: 5)],
      ),
      child: TextField(
        controller: widget.controller,
        textInputAction: TextInputAction.search,
        decoration: InputDecoration(
          hintText: widget.hint,
          hintStyle: rubikRegular.copyWith(fontSize: Dimensions.fontSizeSmall, color: Theme.of(context).disabledColor),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall), borderSide: BorderSide.none),
          filled: true, fillColor: Theme.of(context).cardColor,
          isDense: true,
          suffixIcon: IconButton(
            onPressed: widget.iconPressed,
            icon: Icon(widget.suffixIcon),
          ),
        ),
        onSubmitted: widget.onSubmit,
        onChanged: widget.onChanged,
      ),
    );
  }
}
