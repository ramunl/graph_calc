// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:graph_calc/mapper/expression_entity_mapper.dart';

class ExpressionEntity {
  final String id;
  final List<dynamic> tokenList;
  final num maxVal;
  final num minVal;

  ExpressionEntity(this.id, this.tokenList, this.minVal, this.maxVal);

  ExpressionEntity.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        tokenList = json['tokenList'],
        minVal = json['minVal'],
        maxVal = json['maxVal'];

  ExpressionEntity.withDefaultId(
      this.tokenList, this.minVal, this.maxVal)
      : this.id = generateEntityId();

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
          other is ExpressionEntity &&
              runtimeType == other.runtimeType &&
              id == other.id &&
              tokenList == other.tokenList &&
              maxVal == other.maxVal &&
              minVal == other.minVal;

  Map<String, dynamic> toJson() =>
      {
        'id': id,
        'tokenList': tokenList,
        'maxVal': maxVal,
        'minVal': minVal,
      };

  @override
  int get hashCode =>
      id.hashCode ^
      tokenList.hashCode ^
      maxVal.hashCode ^
      minVal.hashCode;

}
