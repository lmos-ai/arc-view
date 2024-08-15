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

      return Scaffold(
        appBar: AppBar(title: 'Settings'.txt),
        body: Form(
          key: _formKey,
          child: ListView(
            children: [
              Consumer(builder: (context, ref, _) {
                final changed = ref
                    .watch(settingsNotifierProvider.select((s) => s.changed));
                if (changed) {
                  return 'Update'
                      .onButtonPressed(() {
                        if (!_formKey.currentState!.validate()) return;
                        _formKey.currentState!.save();
                        ref.read(settingsNotifierProvider.notifier).commit();
                      })
                      .toRight()
                      .padding();
                }
                return const VGap.medium();
              }),
              ContextField(
                'User Context',
                jsonEncode(conversation.userContext.toJson()),
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
                jsonEncode(conversation.systemContext.toJson()),
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
