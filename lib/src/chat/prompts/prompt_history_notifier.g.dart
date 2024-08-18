/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prompt_history_notifier.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$promptHistoryNotifierHash() =>
    r'8dd86c8209fa0e83551637f877d3c2379d134c60';

/// See also [PromptHistoryNotifier].
@ProviderFor(PromptHistoryNotifier)
final promptHistoryNotifierProvider =
    AsyncNotifierProvider<PromptHistoryNotifier, List<String>>.internal(
  PromptHistoryNotifier.new,
  name: r'promptHistoryNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$promptHistoryNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PromptHistoryNotifier = AsyncNotifier<List<String>>;
String _$currentPromptNotifierHash() =>
    r'c2c7c3393fea992130d39206fc6e070490d54fa2';

/// See also [CurrentPromptNotifier].
@ProviderFor(CurrentPromptNotifier)
final currentPromptNotifierProvider =
    AutoDisposeNotifierProvider<CurrentPromptNotifier, String>.internal(
  CurrentPromptNotifier.new,
  name: r'currentPromptNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentPromptNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentPromptNotifier = AutoDisposeNotifier<String>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
