//
//  SpeedSensorViiewController.swift
//  NewsSearcher
//
//  Created by Shohei Michiwaki on 2014/11/02.
//  Copyright (c) 2014年 Shohei Michiwaki. All rights reserved.
//


import UIKit
import CoreMotion

class SpeedSensorViewController: UIViewController {
    
    var myMotionManager: CMMotionManager!
    
    private var maxX:Double = -100
    private var maxY:Double = -100
    private var maxZ:Double = -100
    
    @IBOutlet var labelMax_x: UILabel!
    @IBOutlet var labelMax_y: UILabel!
    @IBOutlet var labelMax_z: UILabel!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Labelを作成.
        let myXLabel: UILabel = UILabel(frame: CGRectMake(0,0,200,50))
        myXLabel.backgroundColor = UIColor.blueColor()
        myXLabel.layer.masksToBounds = true
        myXLabel.layer.cornerRadius = 10.0
        myXLabel.textColor = UIColor.whiteColor()
        myXLabel.shadowColor = UIColor.grayColor()
        myXLabel.textAlignment = NSTextAlignment.Center
        myXLabel.layer.position = CGPoint(x: self.view.bounds.width/2,y: 200)
        
        let myYLabel: UILabel = UILabel(frame: CGRectMake(0,0,200,50))
        myYLabel.backgroundColor = UIColor.orangeColor()
        myYLabel.layer.masksToBounds = true
        myYLabel.layer.cornerRadius = 10.0
        myYLabel.textColor = UIColor.whiteColor()
        myYLabel.shadowColor = UIColor.grayColor()
        myYLabel.textAlignment = NSTextAlignment.Center
        myYLabel.layer.position = CGPoint(x: self.view.bounds.width/2,y: 280)
        
        let myZLabel: UILabel = UILabel(frame: CGRectMake(0,0,200,50))
        myZLabel.backgroundColor = UIColor.redColor()
        myZLabel.layer.masksToBounds = true
        myZLabel.layer.cornerRadius = 10.0
        myZLabel.textColor = UIColor.whiteColor()
        myZLabel.shadowColor = UIColor.grayColor()
        myZLabel.textAlignment = NSTextAlignment.Center
        myZLabel.layer.position = CGPoint(x: self.view.bounds.width/2,y: 360)
        
        
        // 最大値ラベル初期化
        labelMax_x.text = maxX.toString();
        labelMax_y.text = maxY.toString();
        labelMax_z.text = maxZ.toString();
        
        
        // Viewの背景色を青にする.
        self.view.backgroundColor = UIColor.cyanColor()
        
        // ViewにLabelを追加.
        self.view.addSubview(myXLabel)
        self.view.addSubview(myYLabel)
        self.view.addSubview(myZLabel)
        
        // MotionManagerを生成.
        myMotionManager = CMMotionManager()
        
        // 更新周期を設定.
        myMotionManager.accelerometerUpdateInterval = 0.1
        
        // 加速度の取得を開始.
        myMotionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler: {(accelerometerData:CMAccelerometerData!, error:NSError!) -> Void in
            
            var currentX = self.kirisute(accelerometerData.acceleration.x);
            
            var currentY = self.kirisute(accelerometerData.acceleration.y);
            
            var currentZ = self.kirisute(accelerometerData.acceleration.z);
            
            
            
            myXLabel.text = "x=\(currentX)"
            myYLabel.text = "y=\(currentY)"
            myZLabel.text = "z=\(currentZ)"

            if(currentX > self.maxX){
                self.maxX = currentX;
            }
            if(currentY > self.maxY){
                self.maxY = currentY;
            }
            if(currentZ > self.maxZ){
                self.maxZ = currentZ;
            }
            
            self.labelMax_x.text = self.maxX.toString();
            self.labelMax_y.text = self.maxY.toString();
            self.labelMax_z.text = self.maxZ.toString();
        })
        
    }
    
    
    //小数点第3以下を切り捨てる
    func kirisute(d: Double) -> Double{
        return Double(Int(d * 100.0)) / 100.0
    }
    
    
    
}

//拡張メソッド
extension Double {
    func toString() -> String {
        return String(format: "%.1f",self)
    }
}