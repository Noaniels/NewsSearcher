//
//  TakeMovieViewController.swift
//  NewsSearcher
//
//  Created by Shohei Michiwaki on 2014/11/02.
//  Copyright (c) 2014年 Shohei Michiwaki. All rights reserved.
//

import UIKit
import AVFoundation
import AssetsLibrary

class TakeMovieViewController: UIViewController, AVCaptureFileOutputRecordingDelegate {
    
    // セッション.
    var mySession : AVCaptureSession!
    // デバイス.
    var myDevice : AVCaptureDevice!
    // 画像のアウトプット.
    var myImageOutput : AVCaptureStillImageOutput!
    // ビデオのアウトプット.
    var myVideoOutput : AVCaptureMovieFileOutput!
    // スタートボタン.
    var myButtonStart : UIButton!
    // ストップボタン.
    var myButtonStop : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // セッションの作成.
        mySession = AVCaptureSession()
        
        // デバイス一覧の取得.
        let devices = AVCaptureDevice.devices()
        
        // バックライトをmyDeviceに格納.
        for device in devices{
            if(device.position == AVCaptureDevicePosition.Back){
                myDevice = device as AVCaptureDevice
            }
        }
        
        // バックカメラを取得.
        let videoInput = AVCaptureDeviceInput.deviceInputWithDevice(myDevice, error: nil) as AVCaptureDeviceInput
        
        // ビデオをセッションのInputに追加.
        mySession.addInput(videoInput)
        
        // マイクを取得.
        let audioCaptureDevice = AVCaptureDevice.devicesWithMediaType(AVMediaTypeAudio)
        
        // マイクをセッションのInputに追加.
        let audioInput = AVCaptureDeviceInput.deviceInputWithDevice(audioCaptureDevice[0] as AVCaptureDevice, error: nil)  as AVCaptureInput
        
        // オーディオをセッションに追加.
        mySession.addInput(audioInput);
        
        // 出力先を生成.
        myImageOutput = AVCaptureStillImageOutput()
        
        // セッションに追加.
        mySession.addOutput(myImageOutput)
        
        // 動画の保存.
        myVideoOutput = AVCaptureMovieFileOutput()
        
        // ビデオ出力をOutputに追加.
        mySession.addOutput(myVideoOutput)
        
        // 画像を表示するレイヤーを生成.
        let myVideoLayer : AVCaptureVideoPreviewLayer = AVCaptureVideoPreviewLayer.layerWithSession(mySession) as AVCaptureVideoPreviewLayer
        myVideoLayer.frame = self.view.bounds
        myVideoLayer.videoGravity = AVLayerVideoGravityResizeAspectFill
        
        // Viewに追加.
        self.view.layer.addSublayer(myVideoLayer)
        
        // セッション開始.
        mySession.startRunning()
        
        // UIボタンを作成.
        myButtonStart = UIButton(frame: CGRectMake(0,0,120,50))
        myButtonStop = UIButton(frame: CGRectMake(0,0,120,50))
        
        // 背景色を設定.
        myButtonStart.backgroundColor = UIColor.greenColor();
        myButtonStop.backgroundColor = UIColor.grayColor();
        
        // 枠を丸くする.
        myButtonStart.layer.masksToBounds = true
        myButtonStop.layer.masksToBounds = true
        
        // タイトルを設定.
        myButtonStart.setTitle("撮影", forState: .Normal)
        myButtonStop.setTitle("停止", forState: .Normal)
        
        // コーナーの半径.
        myButtonStart.layer.cornerRadius = 20.0
        myButtonStop.layer.cornerRadius = 20.0
        
        // ボタンの位置を指定.
        myButtonStart.layer.position = CGPoint(x: self.view.bounds.width/2 - 70, y:self.view.bounds.height-50)
        myButtonStop.layer.position = CGPoint(x: self.view.bounds.width/2 + 70, y:self.view.bounds.height-50)
        
        
        // イベントを追加.
        myButtonStart.addTarget(self, action: "onClickMyButton:", forControlEvents: .TouchUpInside)
        myButtonStop.addTarget(self, action: "onClickMyButton:", forControlEvents: .TouchUpInside)
        
        // UIボタンをViewに追加.
        self.view.addSubview(myButtonStart);
        self.view.addSubview(myButtonStop);
        
    }
    
    // ボタンイベント.
    func onClickMyButton(sender: UIButton){
        if( sender == myButtonStart ){
            if(myButtonStart.backgroundColor == UIColor.grayColor()){
                return;
            }
            
            let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
            
            // フォルダ.
            let documentsDirectory = paths[0] as String
            
            // ファイル名.
            let filePath : String? = "\(documentsDirectory)/test.mp4"
            
            // URL.
            let fileURL : NSURL = NSURL(fileURLWithPath: filePath!)!
            
            // 録画開始.
            myVideoOutput.startRecordingToOutputFileURL(fileURL, recordingDelegate: self)
            
            // ボタンの色を変える
            self.myButtonStart.backgroundColor = UIColor.grayColor();
            self.myButtonStop.backgroundColor = UIColor.redColor();
            
        } else if ( sender == myButtonStop ){
            
            if(myButtonStart.backgroundColor == UIColor.greenColor()){
                return;
            }
            
            //ボタンの色を変える
            myButtonStart.backgroundColor = UIColor.greenColor();
            myButtonStop.backgroundColor = UIColor.grayColor();

            
            // 録画終了
            myVideoOutput.stopRecording()
            
            //通知
            var alertView = UIAlertView();
 
            alertView.message = "動画を保存しました";
            alertView.addButtonWithTitle("OK");
            alertView.show();
        }
    }
    
    //動画のキャプチャーが終わった時に呼ばれるメソッド.
    func captureOutput(captureOutput: AVCaptureFileOutput!, didFinishRecordingToOutputFileAtURL outputFileURL: NSURL!, fromConnections connections: [AnyObject]!, error: NSError!) {
        
        //AssetsLibraryを生成する.
        let assetsLib = ALAssetsLibrary()
        
        //動画のパスから動画をフォトライブラリに保存する.
        assetsLib.writeVideoAtPathToSavedPhotosAlbum(outputFileURL, completionBlock: nil)
        
    }
    
}
