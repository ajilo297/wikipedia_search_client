import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  final ValueChanged<String> onChanged;

  SearchBarWidget({this.onChanged});

  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  bool showClearButton = false;
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      maxLines: 1,
      decoration: InputDecoration(
        hintText: 'Search',
        hintStyle: TextStyle(color: borderColor),
        border: border,
        focusedBorder: border,
        enabledBorder: border,
        suffixIcon: !showClearButton
            ? null
            : IconButton(
                icon: Icon(
                  Icons.close,
                  color: borderColor,
                ),
                onPressed: () {
                  setState(() {
                    this.showClearButton = false;
                  });
                  if (this.widget.onChanged == null) return;
                  widget.onChanged('');
                  controller.text = '';
                  FocusScope.of(context).unfocus();
                },
              ),
      ),
      onChanged: (query) {},
      onSubmitted: (query) {
        if (this.widget.onChanged == null) return;
        if (query.length < 3) return;
        setState(() {
          this.showClearButton = true;
        });
        widget.onChanged(query);
      },
    );
  }

  InputBorder get border {
    return UnderlineInputBorder(
      borderSide: BorderSide(color: borderColor),
    );
  }

  Color get borderColor => Colors.white;
}
