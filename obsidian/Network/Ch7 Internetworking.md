### 7A
Intro
- IP routing
- IP Subnetting
- Classless Addressing
- Routing protocols
- Distance Vector portocol
- Link State protocol

internetworking -> how to connect different network

IP?
- a internet protocol
- host to host connetion
- scalable
- hetrogeneous
- all route/host should follow this 
- logical internetwork position
- Connectionless model
- Best-effort delivery(unreliable)



### 7B

##### how layer3 (router) work

router has :
- forwarding table -> store and forward to next device(another router or host device)
- IP/MAC mapping table(IP to MAC port)

the bottleneck of router is base on how fast router lookup IP to MAC -> keep lowest time of frame store in router



### 7C

IP head has :
- destenation IP  
- source IP  
- Identification(use on data fragment to frame)
- Fragment Offset(fragment position in frame)
- Time to Live(discard frame if it live too long)
- Version(IPv4, IPv6)
- Flags : 
	- DF(Don't Fragment bit)
	- MF(More Fragment bit)
- Total Length
- Header Checksum(hash for header)
- Type of Service : 
	- Precedence(3 bits)
	- Delay bit
	- Reliablity bit
	- Through bit

IPv4 addr : 
- 32 bits addr
- Class A type(7bits for Network)
- Class B type(14bits for Network)
- Class C type(21bits for Network)
- Dot notation (192.168.1.1)

### 7D

##### ip forwarding

> fragment data frame could deliver by different way to target host


Stratege of IP forwarding
- if directly connect dest network then forward to host, 
- if non-directly connect host,  forward to some router(record in lookup table)
- each host has a default router


### 7E

##### IP fragmentation

MTU (Maximum Transmission Unit) in defferent network, e.g
- Ethernet(1518 bytes)
- IEEE 802.11 wireless(2312bytes)

Strategy
- Fragmentation should fit for different MTU
- Reassembly is done in host
- All fragments carry the same ID
- Fragments are self-contained datagrams


fragmented packet format
- ID
- offset
- has_more_fragment_bit
- data bytes
### 7F
##### features of Router
- network layer device
- filter MAC broadcast and multicast packets
- easy to support mixed media(eth, wireless...)
- packets fragmentation and reassembly
- filtering on network(IP) addresses and information(Access Control List)
- accounting

##### words for router
- Highly configurable and hard to get right
- Handle speed mismatch
- Congestion control and avoidance

### 7G
##### Routing Protocols : 
Determine which route to take
 - Static routing
- Dynamic routing
	- RIP(Routing Inforation Protocol)
	- OSPF : Open Shortest Path Firts
- Provides reliablility with alternate routes

Bridge vs Routers
- Layer
- Protocol dependance
- what to do for MAC addr
- Cost
- Security
- Transparent
- Network scope
- Segment/Reassembly
- algo. for create DB
- Configure manual / plug and play




### 7H


##### IP subnetting
for Class B address(16bits for network num, 16 bits for Host number)
if we set Subnet Mask(255.255.255.0)
in this class B addr, subnet num will contain 8bit, another 8 bits for host number 
-> Network num(16 bits) + Subnet(8bits) + Host(8 bits)




### 7I
each entry of forwarding algo. table : 
SubnetNum, SubnetMask, NextHop

SubnetNum = SubnetMask AND IP





### 7J

##### Classless Addr
CIDR(Classes Inter-Domain Routing):
A tech that addr two scaling concerns in the internet
the growth of backbone routing table is too much to store them
> class B net work numbers is exhausted

Classless addr aim to slove is usage of Class C/ Class B usage problem

##### CIDR 
- uses aggreagete router
-  a single entry to reach a lot of different newtorks
- router only need to store prefix
- reduce entry numbers in DB

 192.4.16/20
  subnet ip / prefix len

### 7K
##### forwarding table

prefix len : 2~32 

larger means host device is more close to router

22 means this forward subnet connect at most 4 devices

router will pick the logest prefix match in forwaring DB


### 7LMN

##### ARP(Address Resolution Protocol)
- map IP addr into MAC addr
- connect remote IP addr, MAC addr will store info of next  forwarding router
- broadcast req if IP addr not in table
- table entries are discarded if not refreashed

Format in ARP : 
- TargetProtocolAddr(4 bytes) : ip addr
- TargetHardwareAddr(6 bytes) : MAC addr
- Operation : data or response

MAC addr is soild in host device, IP addr is dynamic -> user should set IP configuration while using OS
##### DHCP(Dynamic Host Configuration Protocol)

- DHCP server can providing configuration info to hosts
- host sends DHCP DISCOVER message to a special IP addr(255.255.255.255)
- once DHCP server recive, server will send an IP to host
- DHCP server usually local in 192.168.0.1

##### ICMP(Internet Control Message Protocol)
- send mes back to sender, told sender prev packet is fail to reach reciver
- Situations
	- Dest node is unreachable
	- Reassembly process failed
	- TTL reached to 0(may have cycle in net)
	- IP header checksum failed
- ICMP-redirect : told send here has a better way to reach reciever node


### 7OP
##### Routing Protocol
>Routing vs Forwarding : 
>process to build routing table / 
>select output port by dest addr and routing table

>Routing table vs Forwarding table : 
>map network to next hops / 
>map network number(prefix of IP addr) to a port(interface and MAC addr)


Routing is aim to find the lowest cost between two nodes -> how? : 
1. Distance Vector
2. Link State







### 7Q
##### Distance Vector
- one dimensional array(a vector)
- record distance to all other nodes
- node will distributes vector to its immediate neighbors
- each router will sends its routing table to its neighbors
- features : 
	- fast response to good news
	- slow response to bad news
	- too many messages to update
	
### 7R
Distance vector count-to-infinity problem
- router will tell each other target is reachable even unreachable
- the direction depend on timing of bad news happen

how to solve it : record the nodes on path to the target (split horizon)





### 7S
##### link state routing
different from distance vector, link state routing tell all router the connection of its neighbor

LSP(Link State Packet)
- ID of node
- Cost to neighbor
- Sequence number(SEQNO)
- Time to Live(TTL)

Reliable Flooding
- Store most recent LSP from each node(keep newest news)
- Forward LSP to all nodes but one that sent it 
- Generte new LSP periodically
- Start DEQNO at 0 when reboot
- discard when TTL=0

OSPF(Open Shourtest Path First) : using Dijkstra's algorithm










### 7T

#### Summary
Internet Protocol(IP)
- Connectionless model
- Best-effort delivery
	- unreliable
	- packet may delivered out of order
	- duplicate copies are delivered
	- packets may delayed for long time
- Routing Table lookup(most time cost)

Class of IPs : Class A, B, C

IP subnetting
- Subnetmask
- SubnetNum
- CIDR(Classless Inter-Domain ROuting)
	- Routes aggregated to reduce table size
	- store prefix and prefix len(192.4.16/21)
- DHCP(Dynamic Host Configuration Protocol) : DHCP server send IP info to host device
- ICMP(Internet Control Message Protocol) : told the error info of unreach packet to sender 

Routing protocols
- Distance Vector
	- vector about node's neighbor
	- bad news & good news
	- Count-to-infinite problem
	- split horizon to solve problem
	- RIP(Routing Information Protocol)
- Link state
	- Send to all nodes about directly connected links
	- Reliable broadcating LSPs is must
	- All node has topology of the AS
	- Cal the Shorest path to other
	- Dijkstra's algo.
