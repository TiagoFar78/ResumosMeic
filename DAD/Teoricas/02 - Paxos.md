# Paxos

## Objective

Paxos ensures that no two nodes ever decide on different values and if enough nodes are alive and can communicate, eventually some value is chosen.

## Roles

- Proposer: Suggests values, something like a leader.
- Acceptor: Votes on proposals.
- Learner: Finds out the chosen value.

Every node is both a acceptor and a learner, but only one is supposed to be the proposer. Paxos assumes that there is a mechanism that is able to detect when a new proposer must be selected. The better is mechanism works, the better paxos works.

Usually it looks like this for three nodes (0, 1 and 2):
- Config 0: {(0, PAL),(1, AL),(2, AL)}.
- Config 1: {(0, AL),(1, PAL),(2, AL)}.
- Config 2: {(0, AL),(1, AL),(2, PAL)}.
- Config 3: {(0, PAL),(1, AL),(2, AL)}.
- Config 4: {(0, AL),(1, PAL),(2, AL)}.
- Config 5: {(0, AL),(1, AL),(2, PAL)}
- Config 6: {(0, PAL),(1, AL),(2, AL)}.

Config 1 will only be used if the leader from config 0 is thought to be dead. Config 2 will only be used if the leader from config 1 is thought to be dead. And so on.

## Protocol

Phase 1: Read (Only proposers work)
1. A Proposer picks a unique proposal number $n$ (for example, the id of the config) and sends a `read(n)` request to the Acceptors.

2. Each Acceptor responds: If $n$ is higher than any proposal number they've seen, they store that $n$, and return the value from the highest $n$ they have accepted or their default value if they haven't accepted any proposal.

Phase 2: Accept

3. If the Proposer receives a message from a majority of Acceptors, it sends an `Accept(n, value)` request. The value chosen is either: the value of the highest-numbered proposal reported by Acceptors, or a new value, if none have been accepted yet.
4. Acceptors accept this proposal unless they've already received a higher number and send an ack to the Proposer.
5. When the Proposer receives a majority of ack's then sends a `Decide(v)` to all the Learners.

## Example

![Paxos](Imagens/Paxos%20example.png)

B starts with value n = 2 because A would start with value n = 1, and B was the second one to become a proposer.