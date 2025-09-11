# Consensus

### The problem

- Set of N processess where each process proposes an input value.
- All correct processes output the same value.
- The output value must be one of the values proposed. This prevents a trivial solution, where all processes always output some default value.
- The output may be any of the proposed values. It does not have to be the most frequent value. All input values are equally good.

### Properties

- Termination: all correct processes eventually terminate.
- Uniform agreement: if two processes decide, they decide the same value.
- Integrity: the vallue decided has been proposed by a correct process.

### Example

Assume that you have a uniform reliable broadcast (URB) primitive with the following interface and properties:
- `broadcast(m)` to send a message.
- `deliver(m)` to deliver the message to the application, aka receives a message.
- Validity: if a correct process broadcasts `m` every correct process delivers `m`.
- No duplication: no message is delivered more than once.
- No creation: if a process delivers `m`, `m` was broadcast by some process.
- Agreement: if a process delivers `m` every correct process delivers `m`.

## Consensus attempt

### Bogus consensus

```
When propose(value)
    URB.broadcast(value)

When URB.deliver(value)
    setOfValues = setOfValues + value

When |setOfValues| == N
    decide(MIN(setOfValues));
```

Problem: If a process fails (and never broadcast its value) all process will block.

### Still bogus with a perfect failure detection

```
alive = {p1, p2, p3, ...}

When fail(px)
    alive = alive - px

When propose(value)
    URB.broadcast(value)

When URB.deliver(value)
    setOfValues = setOfValues + value

When |setOfValues| == |alive|
    decide(MIN(setOfValues));
```

Problem: Say that the process that proposes the minimum value, `valueMin`, fails while URB is still executing. One process may receive `valueMin` before it detects the failure. Another process may detect the failure before it receives `valueMin`. These processes will output a different value.

### TRB with consensus and URB and a perfect failure detector

In terminating reliable broadcast (TRB), there is a single distinguished process, the sender, that starts the broadcast with a message `m`. All other processes participate by waiting for the outcome. The goal is that eventually every correct process outputs the same value: either the message `m` if the sender is correct, or a special null value if the sender fails before completing the broadcast.

The algorithm below achieves this by combining uniform reliable broadcast (URB), a perfect failure detector, and consensus. When the sender calls `TRB.send(m)`, it uses URB to broadcast `m`. The other processes call `TRB.wait()`, meaning they are ready to participate in this instance and eventually produce an output.

If a process receives `m` via URB before it has proposed anything to consensus, it proposes `m`. On the other hand, if it detects that the sender has crashed before receiving a message, it proposes `null` instead. Each process only makes one proposal. Because consensus ensures agreement, all correct processes will decide on the same value: if the sender was correct, everyone agrees on the broadcast message; if it crashed too early, everyone agrees on null. Finally, once consensus terminates and produces a decision, each process outputs that value as the result of the TRB instance.

```
proposed = false;

When TRB.wait()
    do nothing

When TRB.send(m)
    URB.broadcast(m)

When URB.deliver(m) && !proposed
    consensus.propose(m)
    proposed = true
    
When fail(sender) and !proposed
    consensus.propose(null)
    proposed = true

When consensus.decide(v)
    TRB.output(v)
```

# Leader based consensus with P

The algorithm works in epochs, where in each epoch there is a different leader. The algorithm assumes a perfect failure detector that is able to keep track of which processes are correct and which processes have failed. In epoch 1 the leader is process p1, in epoch n the leader is process pn. Processes start to execute epoch n only if all leaders from epochs 1 to n-1 have failed.

Execution of the leader in epoch n:
- The leader sends its value to all other processes.
- When another process receives the value form the leader it adopts that value (and forgets any old value it had adopted in the past). It then sends back an acknowledgement to the leader.
- The leader waits until it receives an acknowledgement from every correct process. At this point, all correct processes have adopted the same value (the value proposed by leader n).
- The leader then sends a second message that commits its proposed value.
- When the commit message is received, a process outputs the that value as the valued decided by consensus.

This seems to work but a perfect failure detector is very hard to implement in the general setting. If processes may suffer arbitrary delays, it may be impossible to distinguish a failed process fom a slow process.

# Proof of the impossibility of consensus

- By contradiction, let's consider that there exists an algorithm that solves consensus.
- We consider three different executions of that algorithm, with varying network conditions. Note that any behavior from the network is possible in an asynchronous system.
- The two processes executing consensus are called A and B.

### Execution #1

1. Both processes propose 0 initially.
2. Process B crashes as soon as the execution starts.
3. By the validity condition of the specification, process A must decide 0.
4. And by the termination property it must eventually decide 0 let's say it decides at some instant t1.

### Execution #2

1. Both processes propose 1 initially.
2. Process A crashes as soon as the execution starts.
3. By the validity condition of the specification, process B must decide 1.
4. And by the termination property it must eventually decide 1, let's say it decides at some instant t2.

### Execution #3

1. Process A proposes 0 and process B proposes 1 initially
2. Messages between A and B (in both directions) are delayed such that they are never delivered before max(t1,t2).
3. Process A decides 0 by t1, since its execution is indistinguishable from execution #1.
4. Process B decides 1 by t2, since its execution is indistinguishable from execution #2.

We found a contradiction. We assumed that our algorithm could solve consensus, but in execution #3 processes A and B decide on different values.

# From P to Paxos

Challenge 1: Leader cannot wait an acknowledgement from every correct process.
- Solution: Leader should be able to make progress with a majority of replies.

Challenge 2: When a leader fails, and a new leader starts, the new leader may have been excluded from the majority used by the previous leader.
- Solution: New leader must enquire the other processes to check what the previous leader or leaders have done. This should be also possible to do using majorities.

Challenge 3: Two leaders may start working in parallel. This may happen if a new leader suspects another leader died but that leader is still working.
- Solution: ???