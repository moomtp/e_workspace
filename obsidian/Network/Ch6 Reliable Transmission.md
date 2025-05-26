### 6A
CRC(hash for data frame) is used for detect error

Ack & timeout are used in reliable transmission

ARQ(Automatic Repeat reQuest) : a tech rely on ack & timeout (Stop and Wait Protocol)




### 6B

Retransmition problem : duplicate copeis of frames will be delivered
->Use 1 bit seq number solve it

stop & wait protocol isn't effcience for bandwidth usage

### 6C

#### sliding window Protocol
sender will send data frame in seq, sender is no need to wait ack for resending frame

##### features : 
- SeqNum for each frame
- SWS(Sending Window Size) : how many frames could sender send data before receive data
- LAR(Last Ack Received)
- LFS(Last Frame Send)

**LFS - LAR <= SWS**

in receiver : 

**LAF - LFR <= RWS**



### 6D

/* */

### 6E

if reciver ack the receipt of SeqNumToAck if high-numbered packets haver receivce
-> this ack is said to be cumulative





### 6F



### 6G

##### Timeout is costly
timeout occurs -> sender resend loss packet

loss occurs -> pipeline should stop for sliding windows trap by loss packet

how to imporve:
- Negative ack : if recived packet disable, send negative ACK 
- Additional ack : duplicate ACK as a clue of for frame loss
- selective ack : receiver tag ACK for only receiver receive

##### window size issue

SWS -> Delay * Bandwidth (possible upper bound)

RWS -> 1, or RWS=SWS
- 1 -> only if all frame in order
- SWS -> frame can be send out of ourder



### 6H

##### seq num in frames

seq num is also finine, constrain by addr bits

SWS + 1 <= MaxSeqNum

! duplicate frame could resend 

### 6I

##### avoid duplicate frame problem

constrain RWS and SWS  to (MaxSeqNum+1) / 2

##### for now we make sure our protocol
- Reliabe Transmission
- Preserve the order
- Flow control

## Summary

Features of Sliding window portocol : 
- Reliable Transmission
- Preserve the order
- Flow control 

we provide reliabe transmission by
- Ack
- Timeout

Stop-and-wait is reliable -> but naive
- only one outstanding frame
- duplicated frames

###### sliding window tech
- keep pipe full
- sender : 
	- SWS = delay * bandwidth
	- LAR(Last Ack Received)
	- LFS(Last Frame Sent)
- reciver : 
	- RWS
	- LAF(Largest Acceptable Frame)
	- LFR


SWS < (MaxSeqNum + 1) / 2

 ACK mechenism : 
- NAK
- Cumulative Ack

