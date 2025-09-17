# From Paxos to State Machine Replication

In State Machine Replication we need to order many commands. Thus we need to run multiple instances of consensus, one after the other.

We could use a different set of proposers and acceptors for each consensus but that would be very inefficient. Image the scenario where a client would send the request to the proposers of instance 1, but if the request would not be accepted. The client would need to send it again to the proposers of instance 2.

Because of this we keep the same proposers and acceptors for multiple instances. Proposers pick one request from a client and propose it to instance 1 of consensus. If this request is not selected as the output of consensus the proposer can re-submit it to the next instance without further interaction with the clients. Proposers should be learners, to avoid proposers from proposing values that have already been accepted in other instances.

## Otimizations

### Otimization 1

A proposer can start a new instance of consensus while the other is still executing.

This may create some weird executions, specially is channels are not FIFO. For instance, decision for command 10 may become known while decision for command 9 is still being agreed.

### Otimization 2

Leader executes step 1 of consensus for multiple instances in parallel. Then the leader just needs to execute step 1, when new commands are received from clients.

If something went wrong the worst that can happen is that we have to discard all of the information we already got. But since that's not what happens most of the time is a fair price to pay for this otimization.

## Leader change

Assume that proposer 1 fails and the state of the learners is has follows.

| Consensus instance | Learner 1 | Learner 2 | Learner 3 |
| ------------------ | --------- | --------- | --------- |
| 1 | F | F | F |
| 2 | D | | D |
| 3 | | |
| 4 | A | A | A |
| 5 | H | | |
| 6 | | | |

Now assume that proposer 2, that is also learner 2, becomes the leader. It needs to find out what the previous leader has proposed for instances 2, 3, 5, 6, ...

Assume that we have 3 acceptors and their state is the following. 

| Consensus instance | Acceptor 1 | Acceptor 2 | Acceptor 3 |
| ------------------ | ---------- | ---------- | ---------- |
| 1 | <F, 1 ,1> | <F, 1, 1> | <F, 1, 1> |
| 2 | <D, 1, 1> | <null, 0, 0> | <D, 1, 1> |
| 3 | <null, 0, 0> | <null, 0, 0> | <null, 0, 0> |
| 4 | <A, 1, 1> | <A, 1, 1> | <A,1, 1> |
| 5 | <H, 1, 1> | <null, 0, 0> | <null, 0, 0> |
| 6 | <null, 0, 0> | <null, 0, 0> | <null, 0, 0> |

Leader 2 will send a `prepare(2)` message for instances 2, 3, 5, 6.
- In instance 2, it will learn and adopt the value D.
- In instance 3, it will learn that no value has been accepted.
- In instance 5, it may learn H or learn learn that no value has been accepted (depending on the replies it receives).
- In instance 6, it will learn that no value has been accepted.

For the instance 3, the new leader is free to propose any value it may want. It may also propose a special "no-operation" value and propose new values just in instance 6 and above.

After "clean-up", leader 2 will propose values for instance 6 and above.