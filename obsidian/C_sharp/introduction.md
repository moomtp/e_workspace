
C# 跟java一樣具有 GC

##### dot net平台跟C#的關係
dot net是一個平台, C#是可以在平台上跑的語言
透過編譯器可以把C#轉成 IL（中間語言）
在運行的時候才把IL轉換成mechine code
性能相對C/C++比較低


##### .net的由來
.net平台可以接受不同語言(C#, java, f# ...等)
但目前C#使用比較多

.net目前的版本 ： .NET framework 1.0~4.8, .NET core. 1.0~5.0 , MONO
framework只能在windows運行, .net core跟mono 可以在不同平台上運行 (在遊戲開發很方便)



簡單範例
```
using System;

namespace MySpace
{
	class Program
	{
		static void Main(string[] args){
			Console.WriteLine("Hello world!!");
			Console.ReadKey();
			
		}
	}
}
```