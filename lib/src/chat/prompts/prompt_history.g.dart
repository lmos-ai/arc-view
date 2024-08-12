// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prompt_history.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$promptHistoryHash() => r'c6cfee820082c5d88f13c0f909c7325d3a6c0b00';

/// See also [PromptHistory].
@ProviderFor(PromptHistory)
final promptHistoryProvider =
    AsyncNotifierProvider<PromptHistory, List<String>>.internal(
  PromptHistory.new,
  name: r'promptHistoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$promptHistoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PromptHistory = AsyncNotifier<List<String>>;
String _$currentPromptControllerHash() =>
    r'cf82dec3172ffd02ba13ea4ce4b82508e4c9dabd';

/// See also [CurrentPromptController].
@ProviderFor(CurrentPromptController)
final currentPromptControllerProvider =
    AutoDisposeNotifierProvider<CurrentPromptController, String>.internal(
  CurrentPromptController.new,
  name: r'currentPromptControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentPromptControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentPromptController = AutoDisposeNotifier<String>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
