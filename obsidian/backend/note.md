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





