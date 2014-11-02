//
//  ViewController.swift
//  NewsSearcher
//
//  Created by Shohei Michiwaki on 2014/11/02.
//  Copyright (c) 2014年 Shohei Michiwaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController,ConnectionResult {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // プロトコルを継承する
    
    // !マークは値が必ず入っていることが保証されるOptional型
    // 値が入っていないとエラーになる
    // この場合はStroyboardからひもづけているので必ずついていなければならない
    // reference outlet@storyboard
    @IBOutlet var label: UILabel!
    @IBOutlet var button : UIButton!
    var connection : Connection!
    
    
    // touch up inside@storyboard
    @IBAction func btnClick(sender: AnyObject) {
        // インスタンス化とデリゲートのセット
        connection = Connection(urlStr: "http://umegusa.hatenablog.jp/entry/2014/09/05/005536")
        connection.delegate = self
        connection.doConnect()
    }
    
    // delegate
    // 実際に処理を行う
    func showResult(resultMessage: String?) -> Void {
        label.text = resultMessage
    }
    
}