import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  final ValueChanged<String> onChanged;

  SearchBarWidget({this.onChanged});

  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget>
    with SingleTickerProviderStateMixin {
  bool showClearButton = false;
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            maxLines: 1,
            decoration: InputDecoration(
              hintText: 'Search',
              isDense: true,
            ),
            onChanged: (query) {
              if (this.widget.onChanged == null) return;
              setState(() {
                if (query.isEmpty) {
                  this.showClearButton = false;
                } else {
                  this.showClearButton = true;
                }
              });
            },
            onSubmitted: (query) {
              if (this.widget.onChanged == null) return;
              if (query.isEmpty) return;
              widget.onChanged(query);
            },
          ),
        ),
        AnimatedSize(
          vsync: this,
          duration: Duration(milliseconds: 1000),
          curve: Curves.elasticOut,
          child: Offstage(
            offstage: !showClearButton,
            child: IconButton(
              color: Theme.of(context).accentColor,
              icon: Icon(Icons.search),
              onPressed: () {
                if (this.widget.onChanged == null) return;
                if (controller.text.isEmpty) return;
                widget.onChanged(controller.text);
                FocusScope.of(context).unfocus();
              },
            ),
          ),
        )
      ],
    );
  }
}
