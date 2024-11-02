/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:flutter/material.dart';

Color color(String conversationId) {
  final hash = conversationId.hashCode;
  return Color(hash).withOpacity(0.8);
}
