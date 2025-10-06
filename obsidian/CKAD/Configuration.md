#### docker

###### commands in docker : 
`docker ps  // 現在有在run的 container`
`docker ps -a  // 所有container`

``` Dockerfile
FROM IMAGE  // 選擇image

ENTRYPOINT []  // ENTRYPOINT可以放在cmd之前  
CMD ["command", "param1" ...]  // 最後要用CMD啟動服務
```

`docker run --entrypoint sleep2.0 ubuntu-sleeper 10`

`docker images`
看現在的映像

`docker run -p 1234:8080 nginx`
運行nginx並把8080port曝露到本機的1234

`docker build -t nginx . `
使用本地的dockerfile建立名為nginx的container


#### docker config in k8s

```
apiVersion: v1
kind : pod
matadata:
	name: ubuntu-sleeper-pod
spec:
	container:
		-name : ubuntu-sleeper
		 image : ubuntu-sleeper
		 command: ["sleep2.0"]
		 args:["10"]
```
對應到dockerfile會是
```Dockerfile
FROM ubuntu-sleeper
ENTRYPOINT ["sleep2.0"]
CMD ["10"]
```

對應到docker指令會是
```bash
docker run --name ubuntu-sleeper \
	--entrypoint sleep
	ubuntu-sleeper 10
```

