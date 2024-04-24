import 'package:flutter/material.dart';
import 'package:storyapp/ui/widgets/text_view.dart';

class NoDataView extends StatelessWidget {
  String? noDataText;

  NoDataView({super.key, this.noDataText}) {
    noDataText ??= 'No data found';
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          width: double.maxFinite,
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: TextView(noDataText!,
              fontSize: 24,
              textColor: Colors.grey[350],
              fontWeight: FontWeight.w600,
              textAlign: TextAlign.center),
        ),
        const SizedBox(
          height: 50,
        ),
      ],
    );
  }
}
