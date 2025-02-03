根據 Dockerfile 建立映像檔
```
docker build -t <username>/<repository>:<tag> .
```

推送指定映像檔到docker hub
```
docker push <username>/<repository>:<tag>
```

查看當前在local端的映像檔
```
docker ps
```

運行
```
docker run -p 5000:5000 <app-name>
```

運行時使用不同變數來覆蓋原本的全域變數

```
docker run -e GLOBAL_VAR=new.global.var
```


### 多平台映像檔建構(buildx)

多平台建構範例
```
docker buildx build --platform linux/amd64,linux/arm64 -t moomtp/res-assi-server:latest --push .

```

啟用服務
```
docker buildx install
docker buildx --user
```

安裝buildx
```
wget https://github.com/docker/buildx/releases/download/v0.13.1/buildx-v0.13.1.linux-amd64
mkdir -p ~/.docker/cli-plugins
mv buildx-v0.13.1.linux-amd64 ~/.docker/cli-plugins/docker-buildx
chmod +x ~/.docker/cli-plugins/docker-buildx
```