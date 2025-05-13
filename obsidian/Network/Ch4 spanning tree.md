### 4a

mac layer = layer 2

local LAN can connect each other by bridge(as one logicl LAN)

Bridge : 
- frame forwarding and filtering
- addr learning
- resolving possible **loops** in the topology
- Congestion control
- static filtering
- translation(multi-bridge)
- Routing
- Segmentation

BLAN(Bridged LANs):
- Reliability
- Performance
- Security
- Geography

### 4b
loop problem in BLANs

AP in BLANs should not broadcast for consideration in secutiy and bandwidth 

Use the DMAC(destanation MAC addr) to forward data frame

###### Addr Learning
AP use the source MAC addr(SMAC) and DMAC to update their database

FDB(forwarding database)
### 4c

Learning algo:
```
frame f from Port x

// forwarding part
if(DMAC in FDB && Belong to Port x){
	filter_frame()
}
else if(! DMAC in FDB){
	forward_to_all_port()
}
else forward_to_belonging_port()


// learning part
if(SMAC in FDB){
	change_to_port_X()
	reset_timer()
}
else{
	FDB.add_SMAC(SMAC)
	FDB.add_timer(o)
}


```

### 4d

learing FDB main concept : reduce bandwidth usage in VLANs

### 4e
###### Loop
- provide network reliability
- make frames duplication
- wrong addr learning

-> spanning tree algo can solve loop problem

block some links until BLANs become a spanning tree



### 4f

spanning tree algo. :
- each bridge is assigned a unique ID(8 octets, priority(2 octets)  + addr(6 octets))
- A special group MAC for boardcast all the bridge in BLAN
- spanning tree is a driect graph

defination in spanning tree:
- root has the lowest ID
- Path cost ,transmission cost(TC) : the cost transmit frame to LAN
- Root port : 
- Root path cost : cost to root
- Designated bridge : bridge has the min cost to LAN 
- 


### 4g

for every bridge, find their root port the path connect without root port will be blocked in spanning tree algo.

##### step in spanning tree algo. : 
1. determine the root bridge
2. determine the root port on all other bridges
3. dtermine the designated port on each LAN







### 4h

##### BPDU(Bridge Protocol Data Unit)
- Root bridge ID(8 Bytes)
- RPC(4) : root path cost(cost to root)
- Bridge ID(8)
- RootPort ID(2)


Topology change BPDU : 
change topology if some bridge disable in BLANs



### 4i

root spanning tree isn't mininum cost spanning(sum to cost in edge is mininum)

root spanning tree : mininum cost to one specific node(root)



### 4j

##### spanning tree maintenace : 
The root will periodically issue a configuration BPDU on all LANs

case if some bridge disabled
-> TCN (Topology change Notification) will be issued from root

root wil set topology change flag in all configutaion messages

### 4k

if LAN broken, a new root will be set in disconnected BLANs

#### summnary
- bridge is layer2 device
- bridge makes the physical LANs as one logcial LAN
- function of bridge : 
	- Frame forwarding and filtering
	- address learning
	- resolving loops problem
- for each bridge, should define their RPC(Root Path Cost)
- for each LAN, find their root bridge
- BLAN is predictable or deterministic
- spanning tree algo. can handling bridge faults and LAN faults