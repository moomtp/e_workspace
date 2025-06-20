### 8A

tranport layer is p2p protocol
- Guarateed message delivery
- Messages sent in same order
- Most one copy of each message
- Arbitrarily large messages
- Sync
- allow receiver flow control
- multipple app in one host(vedio, HTTP, ...etc)

but IP is best-effort service -> Unreliable service
- Drop mes
- Unordered mes
- duplicate copies
- finite size
- long delay(since network is dynamic)

UDP : extend host to host into process to process
UPD adds a level of demultiplexing allows process commute each other

Port Number - process ID

### 8B

##### TCP
- Reliable
- Connection oriented
- Byte-stream service

- Flow control : preveting senders from overflow the capacity of reciever

- Congetsion control : preventing routers/switches overloaded





### 8C

TCP runs over the internet rather than a point to point(link layer)

##### end to end issues 
- TCP supports logical connections
- unlike link layer,  RTT(Round Trip Time) in TCP layer have widely different
- need to reorder packet
- learn what resource the other side offers to the connection(flow control)
- learn the capacity of network(congestion control)


##### TCP segment
- TCP is byte foramting 
- sender writes byte into TCP / receiver reads bytes out
- TCP buffers enough bytes from the sending process
- TCP puts packet into receive buffer
- the unit of TCP send call -> Segment





### 8D
##### TCP header : 
- Source Port : application id
- Destianation port
- Sequence Number : byte offset in Data
- Ack Number : same as seqNum, but for ack
- Flags : 
	- SYN : 1 for sync reqest
	- FIN : 1 for finish connection
	- ACK : 0 for ackNum is non-sence
	- RST : 1 for force to reset connection
	- PSH : 1 for push cur packet(non have to wait packet full)
	- URG : 1 for data is urgent
- Urgent Pointer : position of urgent data
- Advertise window : credit cnt of how mush sender can send(flow control)
- checkSum







### 8E

#### TCP connection management

Client : connection initiator
```
Socket clientSocket = new Socket("hostname", "port number");
```
Server : contatced by client
```
Socket connectionSocket = welcomeSocket.accept();
```

##### Three-way handshake
1. Client sends TCP SYN segment to server(only seqNum, no data)
2. Server receives SYN, replies SYN/ACK segment(server allocates buffers with seqNum)
3. client receives SYN/ACK, replies with ACK segment, could contain data

##### Closing a connection:
clientSocket.close();
1. Client sends TCP FIN segment
2. Server receives FIN replies with ACK, 
3. Client receives FIN, replies with ACK(enters "timed wait" state)
4. Server receives ACK. Connection closed



### 8F

##### Timeout value for Retransmission

Algo.

-  Measure SampleRTT for each segment/ACK pair
- Compute weighted average of RTT 
$$
 EstRTT = \alpha * EstRTT + (1-\alpha) * SampleRTT
$$
alpha between 0.8 and 0.9
- Set timeout based on EstRTT(TimeOut = 2 * EstRTT)


protential problem:
ACK should be associated with the first or the second transmission for calculating RTTs

##### Karn/Partridge Algo.
- Do not sample RTT when retransmiitting
- Double timeout after each retransmitting
- timeout is related to congestion
- algo. take variance of SampleRTTs
- EstimetedRTT for small variance
- not coupled to the Estimated RTT for large variance

##### Jacobson/Karels Algo
- consider different between averge and last RTT
- Difference  = SampleRTT - EstimatedRTT
$$
EstRTT = EstRTT + (\delta * diff)
$$
$$
Deviation = Deviation + \delta(|Diff| = Deviation)
$$
\delta is a factor between 0~1

> $$
TimeOut = \mu * EstRTT + \phi * Deviation
 $$

\mu = 1 and \phi = 4, based on expoerience

in Large variance, domain by Deviation, otherwise doamin by EstRTT

### 8G

##### TCP retransmission scenarios

Fast retransmit
- different from accumilate ACK, receiver responds with an ACK for each packet
- packet may out of order, 
- second transmission of the same ACK is called a duplicate ACK
- when reciever sees duplicate ACK, an earlier packet might lost
- in this protocol, **three ACK** would be treat as it was lost




### 8H

#### Congestion control
detect how much capacity is available in the network

TCP is said to be self-clocking by using ACKs

##### AIMD(Additive Increase Muliplicative Decrease)
- CongestionWindow: how much sender can send packet
- congestionWindow <-> flow control's advertised window
- ture output = min(congestionWindow, advertisedWindow)
- Transmission rate
$$
Rate = CongestionWindow / RTT
$$
- TCP source is allowed to send no faster than the slowest component -> network, or dest host

how to cal CongestionWindow
-> based on client observed

if 3-duplicate ACK happen(packet lost), set CongetionWindow to half

if all packets sent out has ACK, add CongetionWindow for 1 packet



### 8I

increments CongentionWindow by a little for each ACK

Increments = MSS * (MSS/CongentionWindow)
CongentionWindow += Increments

1->2->3->4->5 ....


### 8J

##### Slow start
increase the congestion window rapidly from a cold start
- Slow start effectively increases the congestion window **exponentially**
- initial rate is slow
- TCP add 1 to CongestionWindow if sender received ACK
- different from AIMD's 1/MSS

1->2->4->8 ....

3 dup ACK -> cut CongWin in half

But timeout event -> CongWin set to 1
- Cause in timeout event, condition of network is really 
- after timeout happen, set CongWin/2 as threshold
- when CongWin over threshold, add CongWin by linear



### 8KL

TCP throughput = W/RTT
loss happen-> W/2RTT

Average throughout : 0.75W/RTT

## Summary

- TCP is process-to-process potocol(add port num info)
- UDP for unreliable transmission
- TCP is reliable, base on
	- 3-way hadshaking
	- connection state disgram
	- seqNum for packet and ACK
	- timeout value cal -> Kran algo. / Jacboson algo.
	- retrasmission senario -> accumulative ACK
	- fast retransmission -> three duplicate ACK, timeout
	- TCP congestion Control -> slow start, AIMD


