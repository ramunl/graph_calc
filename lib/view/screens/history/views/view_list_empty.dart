// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:graph_calc/helper/ui_utils.dart';

class ListEmpty extends StatelessWidget {
  ListEmpty({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text("No expressions found",
            style: TextStyle(fontSize: getFontSize(context))));
  }
}
