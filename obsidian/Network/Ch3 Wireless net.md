### 1A

wireless net couldn't detect  collision

MAC arch in wireless : CSMA/CA


##### IEEE 802.11 (Wi-Fi)
is designed for a limited geographical area
- the signals propagating through space
feature : 
- Power management 
- Security mechanisms

##### Physical layer in 802.11
two standard
- frequency hopping
-using different freq bandwiths
- direct sequence
-using 11-bit chipping sequence

### 3B

802.11b : up to 11Mbps
802.11g : up to 54 Mbps (using OFDM)
802.11n up to 108Mbps(MIMO tec)


#### issue in 802.11

A-B-C-D

###### hidden node problem
assume each of four node is able to send and receive signals that reach just the nodes to its immediate left and right
-> only the node in both field could commute each other

A and C are hidden from each other, but theris signals can collide at B.
-> there is not way to avoid collision

###### exposed node problem
B is sending to A, Node C is aware of the communication because it hears B's transmission


### 3C

#### CSMA/CA
CSMA/CA : Carrier Sense Multiple Access with Collision Aoivdance

- sender and reciver **exchage control frame** 
- control frame : how long the transmit cost in time and who will recived it.

control frame is a pair of RTS/CTS(  request to send /clear to send)

Any node that sees the CTS frame
- cannot transmit for the periiod of time specified in the CTS frame

Both is RTS send but not recive CTS -> it may collision(or device failed...etc)
RTS/CTS also used **exponetial backoff algo**

##### 802.11 using ACK frame in CSMA/CA
ACK frame should send to sender if data is completely sended

### 3D

##### Distrubution system
node are free to move, to deal with mobility and partial connectibity, 802.11 should define the different node on network
1.  node are allowed to roam (client device)
2. wired network infra -> AP(access point), DS(distrubution system)


DS connect many APs, and the distrubution network runs at layer 2 (MAC protocol)

DS : APs can connect each other even they are hidden nodes

how do the nodes select their APs
-> scanning
- the node sends a **Probe** frame
- All APs within reach reply with a **Probe Response** frame
- The node selects one of the APs and sends that AP an **Association Request** frame
- The AP replies with an **Association Response** frame


### 3E
##### connection between node & AP
Active scanning:
node will send probe frames, scanning the AP which has the most strong singnal in DS

Passive scanning:
APs also periodically send a **Beacon frame** these include the transmission rate info, A node can change to this AP base on the **Beacon frame** by sending it an **Association Request frame** back to the AP

### 3F

##### Frame format
MAC header -> Frame Control(2byte)
To DS(1bit) : if 0 mean reciever isn't in DS
From DS : 

MAC header -> addr 1(6byte), addr2, addr3, addr4

address is 48 bits
data : up to 2312 bytes
CRC: 32 bits
Control field : 16 bits

the transmit in 802.11 is long. So it is import to check these is no collide by using CTS(clear to send) or RTS.

Frames contains four addresses, if this frame needs to cross to DS(To DS=1 & From DS=1), 4 adderss would be used(if no, only three addr would be used)

BSSID is MAC address of an AP

##### from large sys to end
DS -> AP -> node

cross DS event is mostly apper between AP and DS

### 3G
##### MAC arch

include these two sub arch : 
Distributed Coordiantion Funcion(DCF)
Point Coordiantion Funcion(DCF)

async MAC service : DCF
RTS MAC service : PCF + DCF

features : 
- DCF :
	1. CSMA/CA
	2. implemented in all **stations** and **APs**
	3. Ad hoc(not across DS)
	4. infrastructured(has DS)
	5. nodes should fight with each other to access AP
- PCF:
	1. implemented on top of DFC
	2. point coordinator(polling master)
	3. each nodes has access prioirty mechanism
	4. different values of IFS(Inter-Frame Space)
	5. decision of using bandwith is in AP

PCF : 
- Shall use a Point IFS < Distributed IFS
- contention-free
- priority access and allows the point coordinator to size control


PCF + DCF : 
superframe has comtaplabe frame and non comtapable frame

### 3H
#### DCF
- CSMA/CA + random backoff time
- all traffic uses immediate positibe **ACK frame**
- revicer should send ACK frame **immediately**when revice data, if sender hasn't recived ack mean this data could miss
- Carrirer sense shall be performed both through **physical** and **virtual mechanisms** (RTS or CTS)
- RTS / CTS prefix is for long data exchange
- RTS / CTS will also use the bandwidth resource 
- Virtual Carrier Sense Mechanism named Net Allocation Vector(NAV), which maintains a perdiction of future event(include RTS / CTS)
- should be acknoledged with an ACK : 
	- Data
	- Polling
	- Request
	- Response

##### Inter Frame Space(IFS)
- Priority level
- Short-IFS (SIFS)
	- delay time only for
		- an ACK frame,
		- a CTS frame,
##### PCF-IFS(PIFS)
- used only be PCF
- Contention Free Period

##### DCF-IFS(DIFS)
- async
- ACK waiting time is longer than others
- DCF-Random backoff time `Backoff time = INT(CW*Random()) * Slot time`
	-  CW(Contention Window ) = CWmin ~ CWmax(been set before)
	- Slot Time = Transmitter turn-on delay + medium propagation delay + medium busy detect response time


### 3I

##### DCF access procedure

only if sender recive ack time(DIFS), sender can process

in Contention window, all other node can compated the resource

SIFS -> ack frame (has highest priority)
PIFS -> at the middle of SIFS and DIFS
DIFS -> after waiting DIFS that node will in Contention window(wait for other potantail user using resource)

The backoff timer shall be frozen while the medium is sensed busy( free period > DIFS)

### 3J
#### NAV(network allocation vector)

Setting the NAV thourgh use of RTS/CTS frames

From the end of the RTS or CTS frame until the end of the ACK frame

NAV is a virtual busy signal, node which isn't sender or reciver will raise up NAV until data sended completely


### 3K

if ack is not sent by reciver, other node will not update their NAV
(NAV from Fragmet1 has expired)

long data frame(cut to many fragment)
RTS -- SIFS -- CTS  -- SIFS-- data1 -- SIFS -- ack -- SIFS -- data2 -- SIFS -- ack ... DIFS --- ramdom backoff time

sender must wait until the NAV fragmet expired

RTS_threshold, setting for long data frame

for short data frame, RTS/CTS is not necessnary, also time between data frame and ack would be set as SIFS

short data frame : 
DIFS -- data -- SIFS -- ACK

###  3l

#### PCF(point corrdination function)

Point corrdination(PC) will be seleted in DS (station level)

PC will generates Superframe(SF), which consistes of a Contention Free(CF) Period and a Contention Period

SuperFrame : 
non-compete ---  compete needed

non-compete ： PC select other AP
compete needed : AP compete resource

at the beginning of the SF, the PC shall sense the medium.
If it is free, the PC shall wait a PIFS time and transmit

CF-Poll subtype bit set, to the next station on the polling list
CF-End frame, if a null CF period 

### 3M

stations shall respond to the CF-pool immediately

this results in a burst of Contention Free traffic

For serivces that require MAC level ack

PIFS -- CF_D1 -- SIFS -- CF_U1 -- SIFS -- CF_D2 -- SIFS -- CF_U2 -- (if no ack(data complete or error)) -- PIFS -- CF_D3 ....

### 3O

#### feature of 802.11
Hidden node problem
- Two node who didn't know each ohter, but may have colltion problem
Exposed node problem
- Two nodes who know each other but they can send to different recievier

802.11 wireless commutiocation have no collision detection

Use RTS/CTS frames to reserve the channel for larget frames
- A duration field in the RTS/CTS frames

Use ACK frame to fconfirem the correct frame

Two ways to sense the carrier
- Physical
- Virtual(NAV) duration field

CAMA/CA (Collision Avoidance), sense the carrier
- Idle, wait a DIFS then transmit
- Busy, wait channel to idle + wait a DIFS + wait random back off time, then transmit

Three Prioiry levels (lower is higher)
- SIFS < PIFS < DIFS

Superframe : 
- A contention-free burst occurs at the beginning, follow by a contention period

The PCF protocol is based on a polling scheme controlled by the Point corrdinator






