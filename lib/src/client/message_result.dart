/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/client/message.dart';

typedef MessageResult = ({
  List<Message> messages,
  double? responseTime,
  String agent,
  String? error
});
