// Copyright 2018 The Flutter Architecture Sample Authors. All rights reserved.
// Use of this source code is governed by the MIT license that can be found
// in the LICENSE file.

import 'package:graph_calc/models/models.dart';

import 'calculator/model/calc_expression.dart';

typedef TodoAdder(CalcExpression calcExpression);

typedef TodoRemover(String id);

typedef TodoUpdater(String id, CalcExpression calcExpression);
