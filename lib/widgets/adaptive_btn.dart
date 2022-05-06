import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveFltBtn extends StatelessWidget {
  final Function handler;
  AdaptiveFltBtn(this.handler);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child: Text(
              "Choose Date",
            ),
            onPressed: () => handler)
        : TextButton(
            style: ButtonStyle(
                foregroundColor:
                    MaterialStateProperty.all(Theme.of(context).accentColor)),
            onPressed: () => handler,
            child: Text(
              "Choose Date",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          );
  }
}
