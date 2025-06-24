# Class Scope Testing

The Purpose is to test the interactions of the methods in the class.

## Class Modalities

Classification of classes based on their reaction to method call sequences.

### Message sequence constraints

Message sequence constraints mean that the class will reject some sequences of messages based on finite states of object. e.g., a Timer cannot be stopped if it is not started.

Represented by states in a finite state machine.

<img src="Imagens/5 - Message sequence constraints.png">

### Domain constraints

Domain constraints mean that the class will reject some messages depending on the current content of the object. e.g., a debit cannot be made on an Account with balance < amount.

Represented by constraints on state transitions.

<img src="Imagens/5 - Domain constraints.png">

### Types of class modality

- Non-modal class: No constraint on the message sequences
  - An object of class `DateTime` accepts any interleaving of set/get messages.
- Uni-modal class: The constraints on the message sequences are independent of the content of the object. Constraints based solely on history.
  - An object of class `TrafficSignal` accepts message `setRedLightOn` only after `setYellowLightOn`.
- Quasi-modal class: The constraints on the message sequence are related to the contents of the object, but not necessarily history.
  - An object of class `Stack` rejects a `push` message if the stack is full, but accept it otherwise.
- Modal class: The constraints are related to both history and content of the object.
  - An object of class `Account` does not accept a withdrawal message if balance is < amount (domain constraint).
  - A message to freeze the object is accepted if account is not closed and not frozen (sequence constraint).

# Class Scope Test Patterns

## Invariant boundaries

Identify test cases for complex domains.

The intent is to select test-efficient test value combinations for classes, interfaces, and components composed of complex and primitive data types.

### Fault model

- Bugs in implementation of constraints needed to define and enforce a domain formed by several complex boundaries.

### Strategy

Test model:
1. Define the class invariant, responsibility-based assertions.
2. Develop on points and off points for each condition in the invariant using the 1x1 selection criteria of domain model.
3. Complete the test suite by developing in points for the variables not referenced in a condition.
4. Represent the results in a domain matrix.

### Example

```java
class ClientProfile {
    Account account = new Account();
    Money creditLimit = new Money();
    short trCounter;
    ...
}
```

Money is a scalar type with two precision digits.

Account abstract states:
- open: balance >= 0, inactive <= 499, !isClosed
- debit: balance < 0, inactive <= 499, !isClosed
- close: isClosed, balance = 0
- idle: inactive >= 500, !isClosed

Class Invariant: assert((trCounter >= 0) && (trCounter <= 500) &&  (creditLimit <= trCounter * 10 + 10) && !account.isClosed());

| Condition | On Point | Off Point |
| --------- | -------- | --------- |
| trCounter >= 0  | 0  | -1  |
| trCounter <= 500    | 500      | 501               |
| creditLimit <= trCounter * 10 + 10 | 2510           | 2510.01         |
| !account.isClosed() (isOpen()) | close (0, 499, closed)  | close (0, i <= 499, closed) |
| !account.isClosed() (isIdle()) | close (0, i <= 499, closed) | idle (0, 500, open) |
| !account.isClosed() (isDebit()) | open (0, i <= 499, open) | debit (-0.01, i <= 499, open) |

On and Off points for creditLimit consider trCounter = 250 and a two-digit precision.
The minimal number of (On, Off) pair points for condition account.isClosed() is 1.

<img src="Imagens/5 - Invariant boundaries example.png">

Test cases 9 and 10 are not mandatory

### Entry and Exit Criteria

Entry Criteria:
- A validated invariant exists or can be developed for the IUT.
- If this pattern is used with another pattern, the entry criteria for that pattern will also apply.

Exit Criteria:
- A complete set of domain tests has been developed.
- The coverage considerations of the other pattern will apply.

### Consequences

- All domain bugs should be revealed.
- Does not provide extensive checking of input/output correctness, control logic and sequencial constraints.
- Developping the invariant can be time consuming.

## Non-modal Class Test

Design a test suite for a class without sequential constraints.

### Fault Model

- A legal sequence is rejected
- A legal sequence produces an incorrect value
- An accessor method has an incorrect side effect that alters or corrupts object state.
- A legitimate modifier message is rejected.
- An illegal modifier message is accepted, resulting a corrupt state.
- An incorrect computation causes the class invariant to be violated.

### Strategy

Test model: Class invariant

Nonmodal bugs found with this test pattern:

| Test | Behavior Tested | Pass | No Pass |
| ---- | --------------- | ---- | ------- |
| Define-operation | Define operation accepts valid input | On point is accepted (assuming On satisfies invariant) | On point is rejected |
| Define-exception | Define operation rejects invalid input | Off point is rejected (assuming Off invalidates invariant) | Off point is accepted |
| Define-exception-corruption | Define exception changes state | No change in state after an exception | State is corrupted after an exception |
| Use-exception | Use operation does not throw an exception | Operation returns normally | An exception is thrown |
| Use-correct-return | Use operation returns same value as input to the define operation | Use and define values are the same | Use and define values are not the same |
| Use-corruption | Use operation does not corrupt the state of OUT | OUT's state unchanged after a use operation | OUT's state is changed after a use operation |

Test procedure:
1. Find class invariant
2. Develop set of test cases using Invariant Boundaries.
3. Select a message sequence strategy.
    - E.g., define-use or suspect.
4. Set the OUT to a test case from the domain matrix.
    - Use a modifier/define method.
5. Send all accessor messages and verify that the returned values are consistent with the defining value.
6. Repeat steps 3 and 4 until all cases of the domain matrix have been exercised.

Sequences may be selected in several ways:
- Define-use sequence: Consists of a definition method followed by all the use methods.
- Random sequence: The sequence of use and modifier calls is assigned randomly.
- Suspect sequence: If a sequence is suspect for any reason, try it.
  - We may suspect that DataTime operations involving a leap year of Feb 29 may fail.

The best is to mix define-use with random.

### Example

[Pratica 4, Exercicio 2](../Praticas/Pratica%204/Pratica%204.md#2)

### Entry and Exit Criteria

Entry Criteria: Alpha-omega cycle on the CUT

Exit Criteria:
- All define-use method pairs have been exercised, and an object of CUT has taken on the values in each test case at least once.
- Achieve at least branch coverage on each method in the CUT.

## FSM based testing

Behavior of SUT modeled by a finite state machine.

FSM - Finite State Machine - is 5-tuple $M = (S, I, O, \delta, \lambda)$
- $S$ is a finite set of states.
- $I$ is a finite set of inputs.
- $O$ is a finite set of outputs.
- $\delta : S \times I \rightarrow S$ is the a transfer function
- $\lambda : S \times I \rightarrow O$ is the output function

### Fault Model

- Output fault
- Transition fault
- Extra or missing state
- Sneak path - Allows a message to be accepted when it should have been rejected or transition ignoring a condition.

### Conformance Testing

Conformance testing is used to check if the implementation behaves in accordance with the specification.

We need to have one test per transition in FSM.

### Non-conformance Testing

Checks that invalid paths are not followed. We have to guarantee that the state is not changed.

## Modal Class Test

Develop a class scope test suite for a class that has fixed constraints on message sequence.

### Test model

- Missing transition - a message is rejected in a valid state.
- Incorrect action - the wrong response is selected for accepting state and method.
- Invalid resultant state - the method produces a wrong state for this transition.
- A corrupt state is produced - i.e. violation of class invariant.
- Sneak path - allows a message to be accepted when it should have been rejected.

### Strategy

1. Develop state model for CUT.
2. Elaborate the state model with a full expansion of conditional transition variants.
3. Generate transition tree.
4. Tabulate events and actions along each path to form message sequences.
5. Develop test data for each path using Invariant Boundaries pattern for events, messages and actions.
6. Execute conformance test suite until all tests pass.
7. Develop a sneak path test suite. Add all forbidden transitions in all states and define the expected exception.
8. Execute sneak path test suite until all tests pass.

### Example - Account class

States:
- Open
- Overdrawn
- Closed
- Frozen
- Inactive

Operations:
- open
- balance
- credit
- debit
- freeze
- unfreeze
- settle
- close

#### 1. Develop state model for CUT

<img src="Imagens/5 - account class state model.png">

#### 2. Elaborate the state model with a full expansion of conditional transition variants

We must develop a truth table for each conditional transition.

| State | Message | Condition | Next | State |
| ----- | ------- | --------- | ---- | ----- |
| Overdrawn | credit | Post: balance < 0.00 | Overdrawn |
| Overdrawn | credit | Post: balance >= 0.00 | Open |
| Open | debit | Post: balance < 0.00 | Overdrawn |
| Open | debit | Post: balance >= 0.00 | Open |
| Open | - | Post: currentYear - lastYear > 5 | Inactive |
| Open | close | Pre: balance == 0.00 | Closed |
| Overdrawn | debit | Pre: !customer | Overdrawn |

- close() in Open generates an additional transition when balance > 0
- debit() in Overdrawn generates an additional transition when customer == true

<img src="Imagens/5 - account class state model updated.png">

#### 3. Generate transition tree

The initial state is the root node of the tree.

<img src="Imagens/5 - account class transition tree root.png">

From that we look at the state model and we represent all the transitions.

<img src="Imagens/5 - account class transition tree first expansion.png">

For all the new nodes we explore only the ones whose state hasn't been explored yet.

<img src="Imagens/5 - account class transition tree final.png">

#### 4. Tabulate events and actions along each path to form message sequences

| Run | Test Run/Event Path | Expected Terminal State |
| --- | ------------------- | ----------------------- |
| 1 | new | open |
| 2 | new -> balance | open |
| 3 | new -> credit | open |
| 4 | new -> debit [b >= 0.0] | open |
| 5 | new -> debit [b < 0.0] | overdrawn |
| 6 | new -> debit [b < 0.0] -> [customer]debit/error | overdrawn |
| 7 | new -> debit [b < 0.0] -> [!customer] debit | overdrawn |
| 8 | new -> debit [b < 0.0] -> balance | overdrawn |
| 9 | new -> debit [b < 0.0] -> credit[b > 0.0] | overdrawn |
| 10 | new -> debit [b < 0.0] -> credit[b >= 0.0] | open |
| 11 | new -> freeze | frozen |
| 12 | new -> freeze -> balance | frozen |
| 13 | new -> freeze -> unfreeze | open |
| 14 | new -> [currentY - lastY > 5] | inactive |
| 15 | new -> [currentY - lastY > 5] -> balance | inactive |
| 16 | new -> [currentY - lastY > 5] -> settle | closed |
| 17 | new -> [b!=0.0] close/error | open |
| 18 | new -> [b==0.0] close | closed |

#### 5. Develop test data for each path using Invariant Boundaries pattern for events, messages and actions

debit in Open

| Condition | On Point | Off Point |
| --------- | -------- | --------- |
| [b >= 0]  | $0$      | $-0,01$   |
| [b < 0]   | $0$      | $-0.01$   |

close in Open

| Condition | On Point | Off Point |
| --------- | -------- | --------- |
| [b > 0]   | $0$      | $0,01$    |
| [b == 0]  | $0$      | $0.01$    |

The value -0.01 for close() is impossible

credit in Overdrawn

| Condition | On Point | Off Point |
| --------- | -------- | --------- |
| [b >= 0]  | $0$      | $-0,01$   |
| [b < 0]   | $0$      | $-0.01$   |

Note:
- Do not repeat test cases with same input values
- Add at least one test case for each identified cases

#### 7. Develop a sneak path test suite. Add all forbidden transitions in all states and define the expected exception

VT = Valid Transition, PSP = Possible sneak path, ? = Conditional Transition

| Events \ State | Open | Overdrawn | Frozen | Inactive | Closed |
| -------------- | ---- | --------- | ------ | -------- | ------ |
| credit | VT | ? | PSP | PSP | PSP |
| debit | ? | ? | PSP | PSP | PSP |
| balance | VT | VT | VT | VT | PSP |
| freeze | VT | PSP | PSP | PSP | PSP |
| unfreeze | PSP | PSP | VT | PSP | PSP |
| settle | PSP | PSP | PSP | VT | PSP |
| 5 years | VT | PSP | PSP | PSP | PSP |
| close | ? | PSP | PSP | PSP | PSP |

Add PSP to the transition tree

| Run | Test Run/Event Path | Expected Terminal State | Exception |
| --- | ------------------- | ----------------------- | --------- |
| 19 | new -> unfreeze | open | throw |
| 20 | new -> settle | open | throw |
| 21 | new -> debit [b < 0.0] -> freeze | overdrawn | throw |
| 22 | new -> debit [b < 0.0] -> unfreeze | overdrawn | throw |
| ...

### Entry and Exit Criteria

Entry Criteria: Alpha - omega cycle

Exit Criteria:
- Achieve branch coverage on each method in the Class Under Test
- Provide N+ coverage
  - A test for each root-to-leaf path in the expanded transition tree and a full set of sneak path cases.

## Quasi-modal Class Test

This one is basical the same as [Modal Class Test](#modal-class-test) with the addition of a nineth step: Run class specific operation-pairs.