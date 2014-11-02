//
//  ViewController.swift
//  NewsSearcher
//
//  Created by Shohei Michiwaki on 2014/11/02.
//  Copyright (c) 2014年 Shohei Michiwaki. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UISearchBarDelegate,ConnectionResult {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsSearchBar.delegate = self;
        
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

    @IBOutlet var button : UIButton!
    @IBOutlet var htmlLabel: UILabel!
    @IBOutlet var newsSearchBar: UISearchBar!
    @IBOutlet var tableView :UITableView!
    
    
    var connection : Connection!
    
    // touch up inside@storyboard
    @IBAction func btnClick(sender: AnyObject) {
        // インスタンス化とデリゲートのセット
        connection = Connection(urlStr: "http://umegusa.hatenablog.jp/entry/2014/09/05/005536")
        connection.delegate = self
        connection.doConnect()
    }
    
    @IBAction func clearHtml(sender: UIButton) {
        htmlLabel.text = "Cleared";
    }
    
    
    // delegate
    // 実際に処理を行う
    func showResult(resultMessage: String?) -> Void {
        htmlLabel.text = resultMessage
    }
    
    @IBAction func buttonNext(sender: UIButton) {
        self.performSegueWithIdentifier("SegueNextNews", sender: self)
    }
    
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        tableView = UITableView();
    }
    @IBAction func linkSpeedSensorView(sender: UIButton) {
        self.performSegueWithIdentifier("SegueSpeedSensor", sender: self)
    }
    @IBAction func linkTakeMovieView(sender: UIButton) {
        self.performSegueWithIdentifier("SegueTakeMovie", sender: self)
    }
}