// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prompt_history_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$promptHistoryControllerHash() =>
    r'f4fa3f560e3601d70dfc8c5105c6cead611248ab';

/// See also [PromptHistoryController].
@ProviderFor(PromptHistoryController)
final promptHistoryControllerProvider =
    AsyncNotifierProvider<PromptHistoryController, List<String>>.internal(
  PromptHistoryController.new,
  name: r'promptHistoryControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$promptHistoryControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$PromptHistoryController = AsyncNotifier<List<String>>;
String _$currentPromptControllerHash() =>
    r'7e906fefaa1ba5eb4065af1d8bfedce3e714e8a8';

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
