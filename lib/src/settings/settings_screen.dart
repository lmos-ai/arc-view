/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'dart:convert';

import 'package:arc_view/src/conversation/conversation_notifier.dart';
import 'package:arc_view/src/core/extensions.dart';
import 'package:arc_view/src/core/gaps.dart';
import 'package:arc_view/src/settings/context_field.dart';
import 'package:arc_view/src/settings/settings_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, _) {
      final conversation = ref.read(conversationNotifierProvider);
      const JsonEncoder encoder = JsonEncoder.withIndent('  ');

      return Scaffold(
        appBar: AppBar(title: 'Settings'.txt),
        floatingActionButton: Consumer(builder: (context, ref, _) {
          final changed = ref.watchSettingsChanged();

          return 'Save'.onButtonPressed(() {
            if (!_formKey.currentState!.validate()) return;
            _formKey.currentState!.save();
            ref.commitSettings();
          }, disabled: !changed);
        }),
        body: Form(
          key: _formKey,
          child: ListView(
            children: [
              ContextField(
                'User Context',
                encoder.convert(conversation.userContext.toJson()),
                onChanged: (value) {
                  ref.read(settingsNotifierProvider.notifier).updateChanged();
                },
                onSave: (value) {
                  ref
                      .read(settingsNotifierProvider.notifier)
                      .updateUserContext(value);
                },
              ).padding(16),
              const VGap(),
              ContextField(
                'System Context',
                encoder.convert(conversation.systemContext.toJson()),
                onChanged: (value) {
                  ref.read(settingsNotifierProvider.notifier).updateChanged();
                },
                onSave: (value) {
                  ref
                      .read(settingsNotifierProvider.notifier)
                      .updateSystemContext(value);
                },
              ).padding(16),
            ],
          ),
        ),
      );
    });
  }
}
