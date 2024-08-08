// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$conversationIdHash() => r'06429dcc8dc29a85432cf41aabaa23575134b218';

/// See also [conversationId].
@ProviderFor(conversationId)
final conversationIdProvider = AutoDisposeProvider<String>.internal(
  conversationId,
  name: r'conversationIdProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$conversationIdHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ConversationIdRef = AutoDisposeProviderRef<String>;
String _$agentsHash() => r'1fda4b72a9e2228cfc54079b2f1a69269d4b55ee';

/// See also [agents].
@ProviderFor(agents)
final agentsProvider = AutoDisposeFutureProvider<String>.internal(
  agents,
  name: r'agentsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$agentsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AgentsRef = AutoDisposeFutureProviderRef<String>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, inference_failure_on_uninitialized_variable, inference_failure_on_function_return_type, inference_failure_on_untyped_parameter, deprecated_member_use_from_same_package
