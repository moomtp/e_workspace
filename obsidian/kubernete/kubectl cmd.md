資源創建與運行
```



# 建立並運行指定的映像

kubectl run NAME --image=image [params...]

# 範例：建立並運行一個名為 nginx 的 Pod

kubectl run nginx --image=nginx

# 根據 YAML 配置文件或標準輸入建立資源

kubectl create RESOURCE

# 範例：

# 根據 nginx.yaml 配置文件建立資源

kubectl create -f nginx.yaml

# 根據 URL 建立資源

kubectl create -f [https://k8s.io/examples/application/deployment.yaml](https://k8s.io/examples/application/deployment.yaml)

# 根據目錄下的所有配置文件建立資源

kubectl create -f ./dir

# 通過文件名或標準輸入配置資源

kubectl apply -f (-k DIRECTORY | -f FILENAME | stdin)

# 範例：

# 根據 nginx.yaml 配置文件配置資源

kubectl apply -f nginx.yaml
```

查看info
```
# 查看集群中某一類型的資源

kubectl get RESOURCE

# 其中，RESOURCE 可以是以下類型：

kubectl get pods / po # 查看 Pod 
kubectl get svc # 查看 Service 
kubectl get deploy # 查看 Deployment 
kubectl get rs # 查看 ReplicaSet 
kubectl get cm # 查看 ConfigMap 
kubectl get secret # 查看 Secret 
kubectl get ing # 查看 Ingress 
kubectl get pv # 查看 PersistentVolume 
kubectl get pvc # 查看 PersistentVolumeClaim 
kubectl get ns # 查看 Namespace 
kubectl get node # 查看 Node 
kubectl get all # 查看所有資源

# 可加上 -o wide 參數以查看更多資訊

kubectl get pods -o wide

# 查看某一類型資源的詳細資訊

kubectl describe RESOURCE NAME

# 範例：查看名為 nginx 的 Pod 的詳細資訊

kubectl describe pod nginx

```

資源管理
```
# 更新某個資源的標籤

kubectl label RESOURCE NAME KEY_1=VALUE_1 ... KEY_N=VALUE_N

# 範例：更新名為 nginx 的 Pod 的標籤

kubectl label pod nginx app=nginx

# 刪除某個資源

kubectl delete RESOURCE NAME

# 範例：刪除名為 nginx 的 Pod

kubectl delete pod nginx

# 刪除某類資源的所有實例

kubectl delete RESOURCE --all

# 範例：刪除所有 Pod

kubectl delete pod --all

# 根據 YAML 配置文件刪除資源

kubectl delete -f FILENAME

# 範例：根據 nginx.yaml 配置文件刪除資源

kubectl delete -f nginx.yaml

# 設定某個資源的副本數量

kubectl scale --replicas=COUNT RESOURCE NAME

# 範例：將名為 nginx 的 Deployment 副本數設定為 3

kubectl scale --replicas=3 deployment/nginx

# 根據配置文件或標準輸入替換某個資源

kubectl replace -f FILENAME

# 範例：根據 nginx.yaml 配置文件替換名為 nginx 的 Deployment

kubectl replace -f nginx.yaml

```

Debug與交互
```
# 進入某個 Pod 的容器中

kubectl exec [-it] POD [-c CONTAINER] -- COMMAND [args...]

# 範例：進入名為 nginx 的 Pod 的容器中，並執行 /bin/bash 命令

kubectl exec -it nginx -- /bin/bash

# 查看某個 Pod 的日誌

kubectl logs [-f] [-p] [-c CONTAINER] POD [-n NAMESPACE]

# 範例：查看名為 nginx 的 Pod 的日誌

kubectl logs nginx

# 將某個 Pod 的端口轉發到本地

kubectl port-forward POD [LOCAL_PORT:]REMOTE_PORT [...[LOCAL_PORT_N:]REMOTE_PORT_N]

# 範例：將名為 nginx 的 Pod 的 80 端口轉發到本地的 8080 端口

kubectl port-forward nginx 8080:80

# 連接到現有的某個 Pod（將某個 Pod 的標準輸入輸出轉發到本地）

kubectl attach POD -c CONTAINER

# 範例：將名為 nginx 的 Pod 的標準輸入輸出轉發到本地

kubectl attach nginx

# 執行某個 Pod 的命令

kubectl run NAME --image=image -- COMMAND [args...]

# 範例：執行名為 nginx 的 Pod

kubectl run nginx --image=nginx -- /bin/bash
```