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
