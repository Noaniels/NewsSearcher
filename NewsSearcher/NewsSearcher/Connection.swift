//
//  Connection.swift
//  SwiftHackathon1
//
//  Created by Shohei Michiwaki on 2014/11/02.
//  Copyright (c) 2014年 Shohei Michiwaki. All rights reserved.
//

import Foundation

// プロトコル
protocol ConnectionResult{
    func showResult(resultMessage: String?) -> Void
}

public class Connection : NSObject{
    
    // 参考:
    // NSURLConnection ttp://stackoverflow.com/questions/24176362/ios-swift-and-nsurlconnection
    // Delegate, Protocol ttp://qiita.com/mochizukikotaro/items/a5bc60d92aa2d6fe52ca
    
    // nilが入ってるなんてあり得ない！
    var urlStr : String
    var data : NSMutableData? = nil
    var delegate : ConnectionResult!
    
    // コンストラクタ
    public init(urlStr: String) {
        self.data = NSMutableData()
        self.urlStr = urlStr
    }
    
    // アクセス
    public func doConnect() -> Void{
        var url : NSURL = NSURL(string: urlStr)
        // キャッシュを無視
        var request : NSURLRequest = NSURLRequest(URL: url, cachePolicy:NSURLRequestCachePolicy.ReloadIgnoringLocalCacheData, timeoutInterval: 10.0)
        
        var connect : NSURLConnection = NSURLConnection(request: request, delegate: self, startImmediately: true)
        // 接続開始
        connect.start()
    }
    
    // サーバからレスポンスを受け取ったときのデリゲート
    func connection(didReceiveResponse: NSURLConnection!, didReceiveResponse response: NSURLResponse!) {
        // Recieved a new request, clear out the data object
        self.data! = NSMutableData()
    }
    
    // サーバからデータが送られてきたときのデリゲート
    func connection(connection: NSURLConnection!, didReceiveData data: NSData!){
        self.data!.appendData(data)
    }
    
    // データロードが完了したときのデリゲート
    func connectionDidFinishLoading(connection: NSURLConnection!){
        // バイナリデータが発行される
        let html : String = NSString(data: self.data!, encoding: NSUTF8StringEncoding)
        // コンソールに出力
        println(html)
        
        // 処理を呼び出すだけ
        self.delegate.showResult("success!")
    }
}