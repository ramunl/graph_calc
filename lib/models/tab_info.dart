import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:graph_calc/view/localization.dart';

import 'ArchSampleKeys.dart';
import 'app_tab.dart';

/**
 * Main widget tab model
 */
class TabInfo {
  String title;
  Key key;
  IconData icon;

  TabInfo({this.title, this.key, this.icon});

  static getTabInfo(BuildContext context, AppTab tab) {
    var res;
    switch (tab) {
      case AppTab.todos:
        res = TabInfo(
            title: ArchSampleLocalizations.of(context).todos,
            key: ArchSampleKeys.todoTab,
            icon: Icons.list);
        break;
      case AppTab.calculator:
        res = TabInfo(
            title: ArchSampleLocalizations.of(context).calculator,
            key: ArchSampleKeys.calcTab,
            icon: Icons.functions);
        break;
      case AppTab.stats:
        res = TabInfo(
            title: ArchSampleLocalizations.of(context).stats,
            key: ArchSampleKeys.statsTab,
            icon: Icons.show_chart);
        break;
    }
    return res;
  }
}
