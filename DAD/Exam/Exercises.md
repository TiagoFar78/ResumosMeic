# Paxos

# 1.

It will answer that it can't accept because it has already promised to p2.

# 2.

Yes it can, if it uses a_1 as one of the acceptors to reach a majority with a_3.

# 3.

Yes it can, if it uses a_2 as one of the acceptors to reach a majority with a_3.

# 4.

No it can't, a_1 and a_2 belong to a majority and it will adopt one of those values.

# 5.

Yes, because if it uses a_1 to the majority it will know that value A was accepted and will

# 6.

Yes if the majority is formed with a_2 and a_3.

# 7.

Proposer p1 will receive a message saying the acceptors can't promise that value because there is already a promise of a value with a higher timestamp.

# 8.

When doing a prepare it will receive messages <3, <2, B>> from a_2 and a_3 when some of that is selected to the majority. It will continue to phase 2 and end up accepting the same value.

# 9.

Proposer 2 will do the phase one just once, receiving all the information about previous instances. And then on it will execute phase 2 directly. This allows it to avoid one loop of messages for each paxos instance.

# 10.

4 communication steps. Which is O(n^2)

# 11.

2 communication steps. It avoid the the 2 communication steps from phase1

# 12.

<12, F, 2>
<13, noop, 2>
<14, I, 2>
<15, G, 2>
<16, H, 2>

# Coordination Services

# 13

Chubby lock mechanism will remove the lock from x_1 and will allow other nodes to become the primary.

# 14

x_5 will invalidate its own cache if it is not able to renew the lease before it expires.

# 15

The Chubby server works with Paxos below. So even if a server crashes, Paxos will ensure consistency.

# 16.

When it updates it needs to be in sync with the leader. This means that it will force the replicat to have up-to-date information. And performing a "null" update won't change the actual state of the system.

# 17.

Chubby offers both. ZooKeeper only linearizable updates.

# 18.

Just the primary.

# 19.

From any replica, but there is a change the value read is not the most up-to-date.

# 20.

Chubby works with locks, if the client owning the lock fails to renew the lease, it sets as elected the next one to try to get the lock.

# 21.

Run 1, because B is only seen the middle replica after the view line. And Run 2 because of E.

# 22.

Run 3, because A and C are delivered to p3 but not delivered to p1 and p2.

# 23.

Run 1 and Run 2, there are inconsistent states for p1 and p2 in V1, because of messages B and C respectively.

# 25.

No because there may exist a reconfig command between 0 and n.

# 26.

Yes as long it learned n - 5 instance and lower ones.

# 27.

<12, F, 2>
<13, G, 2>
<14, stop, 2>

# 28.

<12, F, 5>
<13, noop, 5>
<14, G, 5>
<15, stop, 5>

# 29.

Processes can not execute instance n + 1 without learning the value of instance n. This limits performance.

# 30.

1 -> b
2 -> c
3 -> b
4 -> a
5 -> a

# 31.

2 configurations -> for ballot 4 and for ballot 3.

# 32.

3 configurations -> ballot 4, ballot 3 and ballot 2

# 33.

yes

# 34.

read configuration 3, read configuration 4, send accept D

# 35.

?

# 36.

Learn what was done in the previous configuration. Write in a majority of C2.

# 37.

leader 1 wins the election for term 1.
it is suspected to be dead and leader 2 wins the election for term 2.
It is suspected to be dead but no one wins the election for term 3 and 4.
It recovers and wins the election for term 5.

# 38.

term 1 -> p5
term 2 -> p3
term 3 -> none
term 4 -> p1
term 5 -> p4

# 39.

p1 with help of p3 and p5
p2 with help of any except p4
p4 with help of any

# 40.

p4 would be elected as the leader with votes from p1 and p5.

# 41.

If p3 was elected, with votes from p1 and p2, for example. It would propagate H(4) after B(1) and F(2) would not be considered.

# 43.

R1 -> Start TA  -> Exec TA  -> Exec TA  -> Exec TA  -> Certify TB   -> Commit TB    -> Certify TA -> Abort TA
R2 -> -         -> Start TB -> Exec TB  -> -        -> Certify TB   -> Commit TB    -> Certify TA -> Abort TA
R3 -> -         -> -        -> -        -> -        -> Certify TB   -> Commit TB    -> Certify TA -> Abort TA
network -> -    -> -        -> -        -> TOB (TB) -> TOB (TA)     -> -            -> -

# 44.

R1 -> Start TA  -> Exec TA  -> Exec TA  -> Exec TA  -> -            -> -                -> Commit TB    -> Certify TA   -> Abort TA
R2 -> -         -> Start TB -> Exec TB  -> -        -> Certify TB   -> Commit TB        -> -            -> -            -> -                -> Abort TA
R3 -> -         ->                      -> -        -> -            -> -                -> Commit TB    -> -            -> -                -> Abort TA
network -> -    -> -        -> -        -> TOB (TB) -> TOB (TA)     -> URB (Commit TB)  -> -            -> -            -> URB (Abort TA)

# 45.

Each table from Spanner has a Paxos running below. So paxos will take care of the blocking.

# 46.

Linearizability means that when a transaction T1 happened before a transaction T2 in real time, then T1 timestamp < T2 timestamp. Serializability is the ability to restore the contents of an object in another execution of a program.

# 47.

TrueTime

# 48.

A

# 49.

B

# 50.

Read will block, if it takes too long it will return B, if it returns fast maybe it will return C.

# 51.

No, only when DC3 have info on timestamp 7 for shard 1 and shard 3.

# 52.

[2, 8, 1]

# 53.

No, it needs to receive T6 from DC2 for shard 1.

# 54.

Cure advocates the user of Conflict-free Replicated Datatypes

# 55.

1 -> y
2 -> n
3 -> y
4 -> n
5 -> y
6 -> y
7 -> n
8 -> y
9 -> n
10 -> y

# 56.

<K1, 20>, <K4, 10>

# 57

1 -> 2
8 -> 12
9 -> 12
13 -> 14

# 58

[3, 7, 7, 12]

# 59

1 -> 2
4 -> 6
11 -> 11
15 -> 2

# 60

[6, 6, 11, 12]

# 61

[144, 144, 144, 144, 144, 144, 174, 24]

# 62

35 e 55

# 63

24A3

# 64

2118

# 65

214F

# 66

Line p=2

# 67

A2BB because second line p=3 starts with the same 3 chars as A2BB and none of the others matches.

# 68

3456

# 69

A3CC

# 70

third line p=2

# Exam

# 1

It will refuse to accept because there a propose with a higher ballot.

# 2

Yes, if it makes a majority with a2 and a3.

# 3

Yes, if it makes a majority with a1 and a2.

# 4

<1, A, 4>
<2, C, 4>
<3, E, 4>
<4, D, 4>

# 5

Chubby provides lineralizability consistency model. While Zookeper only ensures total order.

# 6

It must execute a write with a "null" value.

# 7

Run 1, and Run 2 violate view synchrony because in the view line two replicas are in differnt states.

# 8

term 1 -> p2
term 2 -> p1
term 3 -> none
term 4 -> p5
term 5 -> p4

# 9

No it isn't. If p4 is elected, since everyone would vote for him. p4 would be able to propagate F(5), replacing C(4) from delivered instances.

# 10

1 -> c
2 -> a
3 -> b
4 -> a
5 -> a

# 11

2

# 12

4

# 13

r1 -> -         -> Start TA -> Exec TA  -> -        -> Commit TA    -> -        -> Commit TB
r2 -> -         -> -        -> -        -> -        -> Commit TA    -> -        -> Commit TB
r3 -> Start TB  -> Exec TB  -> Exec TB  -> Exec TB  -> Exec TB      -> Commit TA-> Commit TB
network -> -    -> -        -> -        -> TOB (TA) -> -            -> TOB (TB) -> -

# 14

# 15

B

# 16

It will wait for an answer. The answer can be B or C.

# 17

Check if there aren't any other instructions to commit before 300 and if not commit. If there are it should commit them before.

# 22

2 -> 4
5 -> 5
10 -> 14
15 -> 4

# 23

[9, 9, 9, 14]

# 25

1 -> 3122
2 -> 3110

# 26

1 -> 3122
2 -> 3110