// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:graph_calc/mapper/expression_entity_mapper.dart';

class ExpressionEntity {
  final String id;
  final List<dynamic> tokenList;

  ExpressionEntity(this.id, this.tokenList);

  ExpressionEntity.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        tokenList = json['tokenList'];

  ExpressionEntity.withDefaultId(List<String> tokenList)
      : this.id = generateEntityId(),
        this.tokenList = tokenList;

  @override
  int get hashCode => id.hashCode ^ tokenList.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpressionEntity &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          tokenList == other.tokenList;

  Map<String, dynamic> toJson() => {
        'id': id,
        'tokenList': tokenList,
      };

  @override
  String toString() {
    return 'ExpressionEntity{id: $id, tokenList: $tokenList}';
  }
}
