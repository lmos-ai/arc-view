/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:flutter/material.dart';

Color color(String conversationId) {
  final hash = conversationId.hashCode;
  return Color(hash).withOpacity(0.8);
}
