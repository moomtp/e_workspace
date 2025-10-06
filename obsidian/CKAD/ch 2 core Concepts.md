##### intro.

章節 : 
- K8s Arch
- K8s Config
- Muti-Container Pos
- Probes, Monitoring, Logging, and Debugging
- Workloads and Scheduling
- Scheduling Jobs and Cron Jobs
- Networking
- Persistent Storage with Persisitent Volumes

#### Archtecture of K8s

k8s使用node來運行container
node中有master node來控制其他的worker nodes


##### Components
- API server : 作為集群的frontend, 讓其他使用者(或master本身)可以透過設定好的介面控制集群
- etcd : 使用key-value的方式儲存管理node的相關資訊(logs等)
- kubelet : agent for確保node是正常運行的
- container runtime : 原生的容器運行裝置, 會實際運行映像檔(k8s的其他東西都可以看成是包在外面的), 如 docker
- controller : 集群的大腦, 負責決定components狀態發生改變時會有什麼行為
- scheduler : 控制集群中的node, e.g. 在新的container要被運行時放入node中

##### master vs worker : 
worker node通常具有
- Container Runtime : 運行容器的服務
- kubelet : 管理容器, 通常會跟master node的apiserver做溝通

master node通常具有 : 
- apiserver : 接收和傳送worker的kubelet的相關資訊
- etcd : key-value的結構儲存
- controller
- scheduler

##### kubectl
用來管理cluster的CLI 工具

```
kubectl run hello-minikube
kubectl cluster-info
kubectl get nodes
```

docker與其他container對於k8s的交互方式略有不同, 一般的container runtime是透過CRI(Container Runtime Interface)來交互的

Open Container Intiative(OCI)
- imagespec : how image should be bulid
- runtimespec : how any container runtime should be deploy

dockershim(in old version) : k8s用來跟docker交互的介面, 而docker則是透過containerD在透過CRI跟k8s交互


``
![[tempFileForShare_20250727-070249.jpg]]

如上圖所示docker提供了許多高階的CLI與API工具, 而containerd為docker較為底層的container runtime, 只留下如管理image, volume, network, 執行容器等功能

```
Docker CLI
    ↓
Docker Daemon
    ↓
containerd
    ↓
runc
    ↓
Linux kernel (namespaces, cgroups, etc.)
```
#### containerd
ctr : 
- a debug tool for containerd
- not very user friendly
- only supports limited user

```
ctr images pull docker.io/
```

nerdctl : 
- supports docker compos
- provides a Docker-like CLI for containerD
- supports newest features in containerd
	- Encrypted container images
	- Lazy Pulling 
	- P2P image distrubution
	- image signing and verifying
	- Namespaces in k8s

nerdctl提供了跟docker極為相似的使用方法, 使用者可以不用再額外學習dubugger相關的指令                                     
```

// e.g.
docker run --name redis:alpine
nerdctl run --name redis:alpine

```


crictl
- provides a CLI for CRI compatible container runtimes
- installed separately
- Used to inspect and begub container runtimes
- works across dofferent rumtimes
- Not to create contaimers ideally

```
crictl pull busybox
crictl ps -a
crictl images
crictl pods
```


containerd的比較
- ctr : 老舊, 比較少維護, 
- nerdctl : CLI的使用方式接近docker, gneral purpose, docker like containerd
- crictl : from k8s community, user for debugging, work with all CRI compatible Runtimes

##### what not docker in k8s(11)
docker有大部分的高階功能都可以透過k8s來實現像是
- CLI
- API
- BUIILD
- VOLUMES
- AUTH
- SECURITY

而k8s需要使用containerd來實現容器化並使用CRI跟containerd進行交互就好了


##### Pods(12)

worker node裡面包含了Pod來運行服務

每個pod原則上僅運行一個服務, 如果要先增一個新的instent, 則需要創建新的pod(可以在同個worker或其他worker node)

如果容器間的相異性太強, 單個pod也可以運行多個container, 如需要另外一個服務來對主要服務進行預處理等, 這種服務稱為helper container 

e.g. help container in docker
```
docker run python-app
docker run python-app
docker run python-app
docker run python-app
docker run helper -link app1
docker run helper -link app2
docker run helper -link app3
docker run helper -link app4
```


e.g. help container in k8s pod
```
// v.s
kubectl run nginx --image nginx
kubectl get pods

```


##### YAML in k8s


e.g.
```pod-definition.yml
apiVersion: v1
kind: Pod
metadata:
	name: myapp-pod
	labels:
		app: myapp
		tyype: front-end
spec:
	containers:
	- name: nginx-container
	  image: nginx

```



apiVersion: v1, apps/v1

kind : 
- pod, Service, ReplicaSet, Deployment

metadata : 
dic的結構必須要至少一個縮排, 同層結構要對齊
- name : 
- labels:
	- app: name's of your app
	- type: front-end, back-end, database..etc

sepc : 
- containers:  (list/array)
	- name:  
	- image: 


how to use it
```

kubectl create -f pod-definition.yml

kubectl get pods

kubectl describe pod myapp-pod
```


another example
```
apiVersion: v1

kind: Pod

metadata:
	name: myapp-pod
	labels:
		app: myapp
		constcenter: amer
		location: NA

spec:
	containers:
		- name: nginx-container
		  image: nginx
		- name: backend-container
		  image: redis
```

containers是一個list, 可以用-分隔不同container

pychram對yml結構的有更好的解構能力


##### pods cmd(21)

```
kubectl get pods // get pods info
kubectl get pods -o wide // get more pods info

kubetctl run --help // doc for run

kubectl run nginx --image=nginx

kubectl descirbe pod {{pods name}}

kubectl delete pod {{pod name}}

kubetctl run redis --image=redis123 --dry-run -i yaml  // this will output a yaml file based on your cmd

kubectl edit pods {{pod name}}




```



#### replicaset(23)

in old version -> repolication controller

charstatic of replicaset : 
- High aviability :  replicaset 可以提供多個instent(pod) 即使pod臨時fail也可以補上
- Load balancing : replicaset可以跨node的方式提供相同服務, 達到load blancing

example of replicaset
``` rc-definition.yml
apiVersion: apps/v1

kind: ReplicaSet
metadata:
	name: myapp-rc
	labels:
		app: myapp
		type: front-end
spec:
	template:
		metadata:
			name: myapp-rc
			labels:
				app: myapp
				type: front-end
		spec:
			template:
				
			containers:
				- name: nginx-container
				  image: nginx
replicas: 3
selector: 
	matchLables:
		type: front-end
```

在定義replicaset裡面的pods時是使用nesting的結構


replicas用來指定pod的總數

selector 用來指定replicaset監視的Pods(通常使用label來關聯)

#### ReplicaSet cmd



```
kubectl get replicaset

kubectl delete rs {{replicaset name}}

kubectl scale rs {{replicaset name}} --replicas=5 // 

kubectl edit rs {{replicaset name}}
```


#### Deployments(26)

情況 ： 當今天有新版本上線, 不可能一次把所有instent替換, 而是需要一次更換一個instent, 才不會造成online環境壞掉




``` deployment-definition.yml
apiVersion: apps/v1

kind: Deployment
metadata:
	name: myapp-rc
	labels:
		app: myapp
		type: front-end
spec:
	template:
		metadata:
			name: myapp-rc
			labels:
				app: myapp
				type: front-end
		spec:
			template:
				
			containers:
				- name: nginx-container
				  image: nginx
replicas: 3
selector: 
	matchLables:
		type: front-end
```


#### Namespace(30)

特色 ： 
-  namespace有效管理不同環境, 分開不同使用者的權限
- 分開不同的環境, 讓dev 跟prod不會互相干擾
- 在分隔環境的同時, 這些服務又可以使用相同的資源讓資源做最大話使用


a DNS of k8s address : 
**service.dev.svc.cluster.local**

cluster.local -> domain
svc -> Service
dev -> namespace
service -> service name


``` namespace.yml
apiVersion: v1
kind: Namespace
metadata: 
	name: dev
```

```
kubectl get pods --namespace=dev
kubectl get pods --namespace=prod
```

切換到dev的namespace
```
kubectl config set-context $(kubectl config current-context) --namespace=dev
```



###### resource quota

```
apiVersion: v1
kind: ResourceQuota
metadata: 
	name: compute-quota
	namespace: dev
spce:
	hard:
		pods: "10"
		requests.cpu: "4"
		requests.memory: 5Gi
		limits.cpu: "10"
		limits.memory: 10Gi
```

#### Imperative Commands(33)

使用create指令時加入
`--dry-run=client`   
與
`-o yaml`
讓create不會直接運行, 但會輸出format的格式方便客製化修改
e.g.
`kubectl run nginx --image=nginx --dry-run=client -o yaml > nginx-pod.yaml`

###### POD
` kubectl ruin nginx --image=nginx  // 快速創建pod `

Generate POD Manifest YAML file (-o yaml). Don't create it(--dry-run)
`kubectl run nginx --image=nginx --dry-run=client -o yaml`



###### Deployment
Create a deployment
`kubectl create deployment --image=nginx nginx`



Generate Deployment YAML file (-o yaml). Don't create it(--dry-run)
`kubectl create deployment --image=nginx nginx --dry-run -o yaml`



Generate Deployment with 4 Replicas
`kubectl create deployment nginx --image=nginx --replicas=4`



You can also scale deployment using the kubectl scale command.
`kubectl scale deployment nginx --replicas=4`



Another way to do this is to save the YAML definition to a file and modify
`kubectl create deployment nginx --image=nginx--dry-run=client -o yaml > nginx-deployment.yaml`



You can then update the YAML file with the replicas or any other field before creating the deployment.

###### Service
將pod的端口用port 6379暴露(一樣用dry-run), (This will automatically use the pod's labels as selectors)
`kubectl expose pod redis --port=6379 --name redis-service --dry-run=client -o yaml`
或是
`kubectl create service clusterip redix --tcp=6379:6379 --dry-run=client -o yaml`
(This will not use the pods' labels as selectors; instead it will assume selectors as app=redis. You cannot pass in selectors as an option. So it does not work well if your pod has a different label set. So generate the file and modify the selectors before creating the service)


創建service, 名為nginx且類別為NodePort來暴露pod的port 80 連結到node的端口
`kubectl expose pod nginx --port=80 --name nginx-service --type=NodePort --dry-run=client -yaml`
(This will automatically use the pod's labels as selectors, but you cannot specify the node port. You have to generate a definition file and then add the node port in manually before creating the service with the pod.)
或是
`kubectl create service nodeport nginx --tcp=80:80 --node-port=30080 --dry-run=client -o yaml`
(This will not use the pods' labels as selectors, 但會連結到node的30080端口)

Both the above commands have their own challenges. While one of it cannot accept a selector the other cannot accept a node port. I would recommend going with the `kubectl expose` command. If you need to specify a node port, generate a definition file using the same command and manually input the nodeport before creating the service.

