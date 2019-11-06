// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:graph_calc/helper/ui_utils.dart';
import 'package:graph_calc/view/screens/calculator/model/calc_expression.dart';
import 'package:graph_calc/view/screens/history/views/history_list_item.dart';
import 'package:graph_calc/view/screens/history/views/history_loading.dart';
import 'package:graph_calc/view/screens/history/views/view_list_empty.dart';
import 'package:graph_calc/view/screens/plotting/func_plotter.dart';
import 'package:graph_calc/view/screens/settings/app_settings.dart';
import 'package:graph_calc/view/screens/settings/prefs.dart';
import 'package:graph_calc/view/screens/webview/wolfram_func_plotter.dart';

import '../../../../res/localization.dart';
import 'loading_indicator.dart';

class HistoryList extends StatelessWidget {
  final List<CalcExpression> calcExpressions;
  final Function() onRemove;

  HistoryList(
      {Key key, @required this.onRemove, @required this.calcExpressions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final localizations = GraphLocalizations.of(context);
    final _scaffoldKey = GlobalKey<ScaffoldState>();

    PopupMenuItem<String> _buildMenuItem(String label, context) {
      return PopupMenuItem<String>(
        value: label,
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 0.0),
            ),
            Text(
              label,
              style: TextStyle(fontSize: getFontSize(context)),
            ),
          ],
        ),
      );
    }

    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(localizations.screenTitleHistory),
          actions: [
            IconButton(
              tooltip: localizations.commandCleanAll,
              icon: Icon(Icons.delete),
              onPressed: () {
                onRemove();
              },
            ),
            PopupMenuButton<String>(
              onSelected: (String value) => {
                print("onMenuItemSelected $value"),
                if (value == localizations.commandSettings)
                  {showSettings(context)}
              },
              itemBuilder: (BuildContext context) => <PopupMenuItem<String>>[
                _buildMenuItem(localizations.commandSettings, context),
              ],
            ),
          ],
          backgroundColor: Theme.of(context).canvasColor,
          elevation: 0.0,
        ),
        body: HistoryLoading(builder: (context, loading) {
          if (loading) {
            return LoadingIndicator();
          } else {
            if (calcExpressions.isNotEmpty) {
              return _buildListView();
            } else {
              return ListEmpty();
            }
          }
        }));
  }

  ListView _buildListView() {
    return ListView.builder(
      itemCount: calcExpressions.length,
      itemBuilder: (BuildContext context, int index) {
        final calcExpression = calcExpressions[index];
        return HistoryListItem(
          calcExpression: calcExpression,
          onTap: () => _onHistoryItemClicked(context, calcExpression),
        );
      },
    );
  }

  Future _onHistoryItemClicked(
      BuildContext context, CalcExpression calcExpression) async {
    bool showWolframView = await getBool(KEY_USE_WOLFRAM_API);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          if (showWolframView) {
            return WolframFuncPlotter(calcExpression);
          } else {
            return FuncPlotter(calcExpression);
          }
        },
      ),
    );
  }

  showSettings(context) {
    final _mockPage = AppSettings(); //workaround for focus lost bug
    Navigator.push(context, MaterialPageRoute(builder: (context) => _mockPage));
  }
}
