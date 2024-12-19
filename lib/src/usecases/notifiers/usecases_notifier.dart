/*
 * SPDX-FileCopyrightText: 2024 Deutsche Telekom AG
 *
 * SPDX-License-Identifier: Apache-2.0
 */

import 'package:arc_view/src/usecases/models/use_cases.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'usecases_notifier.g.dart';

@Riverpod(keepAlive: true)
class UseCasesNotifier extends _$UseCasesNotifier {
  final String useCases = '''
 
  
  ## Use Cases
  #### Description
  a text.
  
  
  ## Use Cases
  #### Description
  a text.
  
  
  ## Use Cases
  #### Description
  a text.
  
  
  ## Use Cases
  #### Description
  a text.
  
  
  ## Use Cases
  #### Description
  a text.
  
  
  ## Use Cases
  #### Description
  a text.
  
  
  ## Use Cases
  #### Description
  a text.
  
  
  ## Use Cases
  #### Description
  a text.
  
  
  ## Use Cases
  #### Description
  a text.
  
  
  ## Use Cases
  #### Description
  a text.
  
  
  ## Use Cases
  #### Description
  a text.
  
  
  ## Use Cases
  #### Description
  a text.
  
  
  ## Use Cases
  #### Description
  a text.
  
  
  ## Use Cases
  #### Description
  a text.
  
  
  ## Use Cases
  #### Description
  a text.
  
  
  ## Use Cases
  #### Description
  a text.
  
  
  ## Use Cases
  #### Description
  a text.
  
  
  ## Use Cases
  #### Description
  a text.
  
  
  ## Use Cases
  #### Description
  a text.
  
  
  ## Use Cases
  #### Description
  a text.
  
  
  ## Use Cases
  #### Description
  a text.
  
  
  ''';

  @override
  Future<UseCases> build() async {
    return UseCases(
      selected: 0,
      cases: [
        UseCase(
          name: 'Use Case 1',
          content: useCases,
        ),
        UseCase(
          name: 'Use Case 2',
          content: useCases,
        ),
        UseCase(
          name: 'Use Case 3',
          content: 'Content 3',
        )
      ],
    );
  }

  setSelected(int index) {
    final useCases = state.valueOrNull;
    if (useCases != null) {
      state = AsyncData(useCases.copyWith(selected: index));
    }
  }
}
