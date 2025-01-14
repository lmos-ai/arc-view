/*
 * SPDX-FileCopyrightText: 2025 Deutsche Telekom AG and others
 *
 * SPDX-License-Identifier: Apache-2.0
 */

///
/// Template for a new use case definition.
///
const useCaseTemplate = '''
### UseCase: ambiguous_question
#### Description
Customer is making an ambiguous statement or asking a question that is not clear.

#### Solution
Kindly ask the customer to provide more information or clarify their question.

#### Alternative Solution
Kindly tell the customer that you are still unable to understand their question and provide some examples
of use cases that you can help with.

#### Fallback Solution
Reply with 'NO_ANSWER'.

----

### UseCase: agent_handover
#### Description
Customer is requesting to speak to customer service or a real person.

#### Solution
Reply with 'AGENT_HANDOVER', but only connect them if they agree.

----

### UseCase: password_forgotten
#### Description
The customer has forgotten their password.

#### Steps
- If not clear from the conversation, ask the customer if they remember their previous password.

#### Solution 
If the customer remembers their previous password, inform them that they can use that.
Otherwise, ask them to visit https://telekom.de/password_forgotten.

----

''';

const addUseCaseTemplate = '''
### UseCase: usecase_id
#### Description
TODO

#### Solution
Todo

----

''';
