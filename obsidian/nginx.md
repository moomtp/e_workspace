查看配置文件位置
```
nginx -V
```

檢查配置文件語法
```
nginx -t
```


```
nginx -s reload  // 重新加載配置
nginx -s quit  // 停止nginx
```

## 用docker建立nginx服務

```
docker pull nginx
docker run --name my-nginx -d -p 80:80 nginx
```

创建一个本地目录存放 Nginx 配置文件：
```
mkdir -p ~/my-nginx/conf
```

将默认的 Nginx 配置文件复制到本地目录：
```
docker run --name temp-nginx -d nginx
docker cp temp-nginx:/etc/nginx/nginx.conf ~/my-nginx/conf/
docker cp temp-nginx:/etc/nginx/conf.d ~/my-nginx/conf/
docker rm -f temp-nginx

```

將修改完的配置文件放到鏡像中
```
docker run --name my-nginx -d \
  -p 80:80 \
  -v ~/my-nginx/conf/nginx.conf:/etc/nginx/nginx.conf \
  -v ~/my-nginx/conf/conf.d:/etc/nginx/conf.d \
nginx
```


```
docker run --name my-nginx -d \
  -p 80:80 \
  -v ~/my-nginx/conf/nginx.conf:/etc/nginx/nginx.conf \
  -v ~/my-nginx/sites-enabled:/etc/nginx/sites-enabled \
  -v ~/my-nginx/sites-available:/etc/nginx/sites-available \
  nginx
```

#### 配置SSL文件

生成ssl所需文件
```
# 生成private key
openssl genrsa -out ssl.key 2048
# 根據private key的內容生成證書請求文件(Certificate Signing Request, csr)
openssl req -new -key private.key -out cert.csr
# 使用p_key對證書申請逕行簽名並生成證書文件
openssl x509 -req -in cert.csr -out cacert.pem -signkey private.key
```

修改nginx的配置
```

```
