// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'expression_entity.dart';

/// Loads and saves a List of Items using a text file stored on the device.
///
/// Note: This class has no direct dependencies on any Flutter dependencies.
/// Instead, the `getDirectory` method should be injected. This allows for
/// testing.
class FileStorage {
  final Duration debugDelay = const Duration(milliseconds: 3000);

  final String tag;
  final Future<Directory> Function() getDirectory;

  const FileStorage(
    this.tag,
    this.getDirectory,
  );

  Future<FileSystemEntity> clean() async {
    final file = await _getLocalFile();

    return file.delete();
  }

  Future<List<ExpressionEntity>> loadItems() async {
    final file = await _getLocalFile();
    final string = await file.readAsString();
    final json = JsonDecoder().convert(string);
    final items = (json['items'])
        .map<ExpressionEntity>(
            (calcExpression) => ExpressionEntity.fromJson(calcExpression))
        .toList();
    return Future.delayed(debugDelay, () => items);
  }

  Future<File> saveItems(List<ExpressionEntity> items) async {
    final file = await _getLocalFile();

    return file.writeAsString(JsonEncoder().convert({
      'items': items.map((calcExpression) => calcExpression.toJson()).toList(),
    }));
  }

  Future<File> _getLocalFile() async {
    final dir = await getDirectory();

    return File('${dir.path}/ArchSampleStorage__$tag.json');
  }
}
