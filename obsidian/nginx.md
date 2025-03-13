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
docker run --name my-nginx -d -p 80:80 -p 443:443 nginx
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

###### 完整版
```
docker run --name my-nginx -d \
  -p 80:80 \
  -p 443:443 \
  -v ~/my-nginx/conf/nginx.conf:/etc/nginx/nginx.conf \
  -v ~/my-nginx/conf/sites-enabled:/etc/nginx/sites-enabled \
  -v ~/my-nginx/conf/sites-available:/etc/nginx/sites-available \
  -v ~/my-nginx/ssl_pems:/etc/nginx/ssl_pems \
  nginx
```

#### 配置SSL文件

##### 本機生成ssl檔案
生成ssl所需文件
```
# 生成private key
openssl genrsa -out ssl.key 2048
# 根據private key的內容生成證書請求文件(Certificate Signing Request, csr)
openssl req -new -key private.key -out cert.csr
# 使用p_key對證書申請逕行簽名並生成證書文件
openssl x509 -req -in cert.csr -out cacert.pem -signkey private.key
```

##### 用let's Encrypt 生成ssl

###### 安裝
```
sudo apt update
sudo apt install certbot python3-certbot-nginx  # 如果使用 Nginx
```

###### 自動套用
```
sudo certbot --nginx  # 如果使用 Nginx
sudo certbot certificates
sudo certbot renew --dry-run
```

###### 手動套用
``` (/etc/letsencrypt/live/example.com/)
// 通常
sudo certbot certonly --manual --preferred-challenges dns -d "example.com"
 
// 通配符(wildcard)版本
sudo certbot certonly --manual --preferred-challenges dns -d "*.example.com" -d "example.com" 

```
修改nginx的配置
```
server {
	listen 443 ssl;
	#listen	127.0.0.1:443;
	#server_name	localhost;
	server_name	_ ehome.zapto.org;

	##
	# SSL config
	##

	ssl_certificate /etc/nginx/ssl_pems/fullchain3.pem;
	ssl_certificate_key /etc/nginx/ssl_pems/privkey3.pem;

	ssl_session_timeout 5m;
	ssl_protocols TLSv1 TLSv1.1 TLSv1.2 TLSv1.3;
	ssl_ciphers 'TLS_AES_128_GCM_SHA256:TLS_AES_256_GCM_SHA384:ECDHE-RSA-AES128-GCM-SHA256:ECDHE-RSA-AES256-GCM-SHA384';
	ssl_prefer_server_ciphers on;
}
```


### 建立反向代理

###### 更改sites-available的default

```
upstream jenkins {
	server localhost:8080;
}
server {
	location /jenkins{
		proxy_pass http://jenkins;
	}
}
```

如果是網頁

```
server {
	location /login{
		proxy_pass http://192.168.1.106:30030;
		proxy_http_version 1.1;
		proxy_set_header Upgrade $http_upgrade;
		proxy_set_header Connection "Upgrade";
		proxy_set_header Host $host;
		proxy_set_header X-Real-IP $remote_addr;
		proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
	}
}
```