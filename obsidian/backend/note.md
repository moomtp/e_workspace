### 網址的組成與運作

https://google.com/search?q=test
網址可以拆成
協定 ： https
主機名 ： google.com
埠號 : https的443
路徑/路由 : /search
要求字串 : q=test

後端會根據 '路徑'與'要求字串' 決定要採取得動作並回應給前端

基本範例
```
app=Flask(__name__)
app.run(port=3000)
```
### 路由

在flask中可以使用decorator的方式來指定路由
```
@app.route('/data')
```


##### 動態路由
```
@app.route('/user/<name>')
def getUser(name):
	return "Hello" + name
```

可以將直接把其變為變量


### 靜態檔案處理

不執行程式，直接傳檔案到前端, 不需要設定額外的app.route就可以執行
如 ： 圖片, 影片, 靜態網頁

flask會預設抓根目錄下的static資料夾

可以用動態路由的方式去抓檔案
```
127.0.0.1/static/<檔案名稱>
```

flask 可以更改靜態資料夾的位置與對應的路由
```
Flask(__name__, 
	static_folder="LOCATION",
	static_url_path="STATIC_URL_PATH"
	)
```



### HTTPS request

接收前端的請求並處理相關資訊（request）
###### request基本的資訊 :
- method : 請求方法
- scheme : 通訊協定
- host : 主機名稱
- path: 路徑
- url : 完整網址
###### request header常見的資訊
- user-agent : 使用者瀏覽器跟作業系統
- accept-language : 使用者使用的語言(語言偏好)
- referrer : 如果有從其他網站轉來的，母網址會放這(引薦網址)
(header不一定必要也可以連線

拆解request物件
```
from flask import request

@app.route("/")
def index():
	print("請求方法", request.method)
	print("通訊協定", request.scheme)
	print("通訊協定", request.headers.get("user-agent"))
	lang = request.headers.get("accept-language")
	if lang.startswith("en"):
		print("is en user")
	
```

語言偏好可以在瀏覽器裡面設定

### 要求字串query string

在網址最後放的
?q=test&fr=yfp-search-sb

格式為
?參數名稱1=資料1＆參數名稱2=資料2



