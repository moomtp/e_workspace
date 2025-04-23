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

為前端 to 後端的請求

後端範例
```
data = request.args.get("max", None)
```

get的第二個參數是default值


### flask 中的response

response 是 後端to前端的方式

###### 舉例
- 直接 return字串
` return "hello"`
- 回傳json字典(dumps會把dic轉成str)
```
字典 = {key1 : val1,
		key2 : val2
		}
return json.dumps(字典)

```
- 重新導向
```
from flase import redirect

# 導向到特定網址
return redirect(網址)
# 導至主頁面的的分頁下
return redirect("/分頁/")

```

###### 補充
json.dumps(ensure_ascii=False)
不用ascii而改成使用UTF-8編碼

### Template engine(樣版引擎)

template engine也是response的一種

優點
- 方便撰寫複雜的前端城市
- 方便在回應中動態代入需要的資料

樣版檔案都在templates子資料夾下
當要retrun的時候會使用
`render_templates(檔案路徑)`

利用{{動態資料名稱}}的方式回傳需要的資料

templates裡面通常都是放前端的東西

用這樣的方式可以有效decouple
###### 範例
```
templates\index_info

<h3> 您好,{{name}} </h3>

```

```
app.py

from flask import render_template

@app.route("/")
def index():
	return render_template("index", name="小明")
```

這樣就可以在後端回傳時動態帶入資料
並將前端的資料渲染完後傳給使用者

### 超連結與圖片
為前後端互動的一種

網址是前後端互動的關鍵，使用超連結可以讓使用者與網站的互動變好(不用輸入網址)

呈現網站圖片也是使用連結的方式傳送(放在static_folder裡面的？)

超連結跟圖片的範例
```
**templates/index.html**

<!DOCTYPE html>
<html>
<head>
	 <title>hello </title>
</head>
<body>
	<h3> main page </h3>
	<a  href="http://127.0.0.1:3000/page"> 完整路徑連結</a> 
	<a  href="/page"> 相對路徑連結</a> 
	<br/>
	<img src="/pic.png" />
	
</body>
</html>

```


```
app.py

@app.route("/")
def index():
	return render_template("index.html")

@app.route("/page")
	return render_template("page.html")



```

可以用F12的開發人員工具(Network)看到網頁使用第二次互動，用url的方式載入網頁中的pic.png

### 前後端互動-表單(form)

表單 ： 使用者可以輸入資料，並送到後端的介面, 跟網址與超連結不同

通常前端會寫成
```
<from action = "網址路徑">
<input type="text" name="data" />
<button> Btn </button>
</from>
```
點擊就會把字串資料就會送到後端了

後端對應的:
```
@app.route("網址路徑")
def handle():
	input=req.args.get("data","")
	retrun render_template("result.html", data=data)
	
```

### 連線方法 ： GET, POST

如果使用POST連線到後端的話, 後端要設定method=["POST"]

使用POST的話, 前端的data不會放在網址中, 要使用request.form["data"]的方式取得資料

POST會比GET安全 , 如帳號密碼等建議用POST傳


前端
```
<form action="/cal" method=POST>
	btn <input type="text"  name="max" />
</form>
```

後端
```
@app.route("/cal", methods=["POST"])
def calculate():
	maxNum = request.form["max"]
	maxNum = int(maxNum)
	ret = 1 + maxNum

	return render_template("result.html, data=ret)
	

```


用瀏覽器的 dev tools可以看請求類別(在header裡面)


### 使用者狀態管理(Session)

每次連線之間都是完全獨立的

因此需要管理使用者狀態
-> 讓後端可以記住使用者狀態

後端會建立seesion來保存資料, 之後後端可以從session取得資料

前端:
```

```

後端：
```
from flask import session
app.secret_key="a;ow9gj09j1"

@app.route("/hello")
def hello():
	name = req.args.get("name","")
	session["username"] = name
	return "hello" + name

@app.rout("/other_url", "")
def hi():
	return 又是你 + session["username"]
```


### 資料庫簡介 DBMS

將所有資料進行中心化, 標準化 , 程式化的資料管理系統讓不同使用者可以用不同的中介程式(Java, python, ...)來獲取資料庫的資料

關聯式資料庫 : SQL, mySQL

非關聯式資料庫 : MongeDB, BigTable, Cassandra

資料庫是有限資源，後端要負責接受第一線海量的前端請求

### MongoDB簡介

特點 ： 
JSON格式友善
簡潔的文件模型
容易水平擴展


流程 ： 
1. 註冊
2. 建立組織
3. 建立專案
4. 建立存取權限
5. 建立叢集
6. test (用python連線到mongoDB)

安裝時使用
` pip install pymonge[srv] `
安裝mangoDB

連線前要去cluster裡面使用connect to MyDB來設定使用的程式語言, 他會給範例直接paste到code中就好

連線範例
```
import pymongo

連線到mangoDB
client=pymonge.MongoClient("mongodb+srv://DB_USER:DB_PASSWD@)

# 選擇資料庫
db = client.myDB

# 選擇集合(users)
collection=db.users 

# 把新資料放到集合中(json格式)
collection.insert_one({
	"name" : "我",
	"gender" : "男"
})
print("資料新增成功")

```

完成後可以到mangoDB的collections看資料有沒有被新增


###  資料庫結構

MangoDB分三層
- Database : 不同的database, 可用於分類不同來源的資料(不同網站)
- Colletion : 資料分類(會員資料, 文章資料..等)
- Document : 最終資料的存放形式

```
# 選擇db
db = client.DB1
# 選擇collection
collection=db.users
# 插入document
collection.insert_one(JSON_DATA)
```

### 新增資料

##### 新增單筆方法
集合.insert_one(資料)

新增並取得新增的資料的id
```
collection=db.website
result=collection.insert_one({
	"email" : "test@test.com"
	"password" : "test"
})
print(result.inserted_id)
```


##### 新增多筆方法
集合.insert_many([資料1, 資料2, ...])


### mongoDB取得資料

##### 取得單一文件資料
集合.find_one()

```

collection=db.website
# 取得第一筆資料
data=collection.find_one()
print(data)
```


```
from bson.objectid import ObjectId

# 取得對應的資料
collection=db.website
data=collection.find_one(ObjectId(編號))

print(data)
```

##### 取得欄位資料
文件資料["欄位名稱"]
```
data = collection.find_one()
print(data["name"])
```


##### 取得所有文件資料
集合.find()

```
cursor=collection.find()
print(cursor) # cursor物件的敘述

for doc in cursor:
	print(doc)
```


### mongoDB 更新資料

##### 更新一筆
集合.update_one(條件, 更新的資訊)

```
collection=db.website
collection.update_one({
	"email":"test@com"
	},
	{
		"$set":{
			"password":"testtest"
		}
	}

)
```

##### 更新多筆資料
集合.update_many(條件,更新資訊)

##### 更新的方式
使用$set 覆蓋/新增欄位

使用$inc加減數字欄位
```
collection.update_one({
	"email":"test@com"
	},
	{
		"$inc":{
			"level":"4"
		}
	}

)
```

使用$mul乘除數字欄位

清除欄位 : $unset
```

collection.update_one({
	"email":"test@com"
	},
	{
		"$unset":{
			"level":"4"
		}
	}

)
```


##### 取得更新的結果

```

collection=db.website

res = collection.update_one({
	"email":"test@com"
	},
	{
		"$set":{
			"password":"testtest"
		}
	}

# print有幾筆符合條件
print(res.matched_count)
# print有幾筆被修改了
print(res.modified_count)
```


### mongodb刪除資料


##### 刪除單筆
集合.delete_one(篩選條件)

```
collection.delete_one({
	"level":1
})
```


##### 刪除多筆
集合.delete_many(篩選條件)

取得被刪除資料的資訊
```
ret = collection.delete_many({
	"level":1
})

# 有幾筆被刪除
print(ret.deleted_count)

```


### mongodb 篩選, 排序資料


##### 篩選多筆
集合.find(篩選條件)
```
cursor=collection.find({
	"level":3
})

print(cursor)

for doc in cursor:
	print(doc)
```

##### 複合篩選條件
使用$and結合多個條件來篩選
```

cursor=collection.find({

	"$and":[
		{"email": "test@test.com"},
		{"passwd": "123456"},
	]
})

for doc in cursor:
	print(doc)
```

使用$or則其一條件滿足即可

##### 排序篩選結果
集合.find(篩選條件, sort=排序方式)

找所有資料, 由小到大排序
```
cursor=collection.find({}, sort=[
	("level", pymongo.ASCENDING)
])

for doc in cursor:
	print(doc)
```

pymonge.DESCENDING則會就大到小的方式排序


# 會員系統

