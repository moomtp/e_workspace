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



### 8E
### 8F
### 8G
### 8H
### 8I
### 8JK
