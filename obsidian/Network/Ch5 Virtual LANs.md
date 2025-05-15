### 5A

without VLAN, layer 2 switchs/bridges will forward received **boardcast** and **muticast** frames to all ports
-> Bandwidth wasting issue
->Security issue

solution -> logicl group of stations(VLANs)

VLANs can dymamicly add and remove member in VLANs

Traffic between VLANs  is firewalled




### 5B
##### features of VLANs
- shared and P2P media
- VLANs has their ID(VID)
- comapatiblity with coexit bridges, switchs and stations
- plug and play

forwarding and flitering DB need to midify to spport VBLANs

#### VLAN arch ： 
1. Configuration
2. Distribution/Resolution
3. Relay

### 5C

#### Configuration
- Port based VLAN (IEEE 802.1q)
- MAX based VLAN
- IP subnet based VLAN
- layrer-3 protocol basedVLAN


### 5D
#### Distribution
- Distriube VLAN membership info for bridges
- GARP(Generic Attributes Register Portocol)

#### Relay
- procedure, modigy tags frame or untage frame
- Ingress rules : mapping recived frame
- Forwarding rules : where received frames should be forwarding
- Egress rules : mapping frames for output ports and format(tag or untag)

in port-based, each port has their port ID(PID)

implicit tagging : non-tag for VLAN, classified tag by MAC addr, layer3 portocol ID, or reviced port

explicit tagging : add VLAN ID in frame

### 5F
##### Port-base VLAN (Definiation) : 
- different type of know/unknow  VLAN (ware/unware) device
- access link is a LAN segment used for unware device
- frames on access link are **implicitly tagged**
- no VLAN tagged frames on an access link
- access link be show at the edge of the network
- can attached to BLAN

 Trunk link : all device connect to Trunk link must be VLAN aware(explicityly tagged)

Hybrid link : both implicitly and explicitly tagged can used 
(from unware LAN -> all implicity, vice versa. )


### 5G

spanning tree and VLAN : 
- Porvide the routing path for any pair of nodes
- All VLANs are aligned along the sapnning tree
- A VLAN is defined by a subset of the sapnning tree
- each VLAN should sperate each other or overlay on different segments
- topology of VLAN is dynamic

for each VLAN, bridges should keeps : 
-  member set
- untagged set

edge host : untag set, member set
switch to switch : member set, tagged set

### 5H
SVL(shared VLAN learning) : use  same VLAN DB 
IVL(independent VLAN learning)

filitering DB should be IVL

if SVL used for different VLAN, frame could miss or in loop


### 5I
##### format of VLAN DB

types of VLAN DB : 
- static filtering entry
- static VLAN registration  entry
- dynamic filtering entry
- dynamic VLAN registration  entry

static : setup manuallly
dynamic : setup in run time

each MAC has : 
- VLAN ID
- control element : 
	- record for frame forward or filited
	- tag or untag


### 5J

##### VLAN tag format :
- TPID(Tag Protocol IDentifier)
- TCI(Tag Control Information):
	- priority
	- VID(VLAN ID)
	- Canonical Format Indicator

TPID has : 
- SNAP header
- SNAP PID
- Tag type

SNAP(SubNetwork Access Protocol) is a standard in 802

## Summary
- VLAN is designed to logical group of stations
- The member of a VLAN can be removed and added dymamicly
- Without VLAN, the boradcast and multicast frames will be forwarded to all ports
	-> Bandwidth & security issue
	
- Directly communication bewteen VLAN have to forward by router
- IEEE 802.1Q defines port-based VLAN

- VLAN is a Three-pahse model:
	1. VLAN configuration
	2. VLAN membership(declaration/distribution)
	3. Frame relay

- VLAN ID is 12 bits (up to 4096 VLANs)

- Three types of links:
	1. access link(all frame are untagged)
	2. hybird link
	3. trunk link (all frame are tagged)

- Foreach LAN, the bridge needs to keep:
	- Member set(port ID) -> port belong to which VLAN
	- Untagged set(port ID)
