//
//  ViewController.swift
//  SlideshowApp
//
//  Created by Junichi Takemura on 2018/06/18.
//  Copyright © 2018年 Junichi Takemura. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    //一定の間隔で処理を行うためのタイマー
    var timer : Timer!
    var timer_sec: Float = 0
    
    @IBOutlet weak var displayImage: UIImageView!
   
    @IBOutlet weak var nextButton: UIButton!
    
    
    @IBOutlet weak var backButton: UIButton!
    
    @IBOutlet weak var playButton: UIButton!
    // 表示している画像の番号
    var displayImageNo = 0
    let imageNameArray = [
        "soccer1.jpeg",
        "soccer2.jpeg",
        "soccer3.jpeg"]
    
    //表示している画像の番号をもとに画像を表示する
    func setImage(){
        
        
        if displayImageNo < 0 {
            displayImageNo = imageNameArray.count - 1
        }
        
        if displayImageNo > imageNameArray.count - 1 {
            displayImageNo = 0
        }
        let name = imageNameArray [displayImageNo]
        
        let image = UIImage(named: name)
        
        displayImage.image = image
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        displayImage.image = UIImage(named: imageNameArray[displayImageNo])
        // Do any additional setup after loading the view, typically from a nib.
         displayImage.isUserInteractionEnabled = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewController = segue.destination as! ResultViewController
        viewController.imageName = imageNameArray[displayImageNo]
        
        if self.timer != nil {
            self.timer.invalidate()
            self.timer = nil
            nextButton.isEnabled = true
            backButton.isEnabled = true
            playButton.setTitle("再生", for: .normal)
            
        }
           
        
    }
    @IBAction func slideshowForth(_ sender: Any) {
        //進むボタンを押すと一つ先の画像を表示
        displayImageNo += 1
        setImage()
    }
    
    
    @IBAction func slideshowBack(_ sender: Any) {
        //戻るボタンを押すと一つ前の画像を表示
        displayImageNo -= 1
        setImage()
        
    }
    
    
    
    @IBAction func slideshowStartandStop(_ sender: Any) {
        //再生ボタンを押すと自動送りが始動
        if timer == nil {
            timer = Timer.scheduledTimer (timeInterval:2, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            nextButton.isEnabled = false
            backButton.isEnabled = false
            playButton.setTitle("停止", for: .normal)
            
        }else {
            self.timer.invalidate()
            self.timer = nil
            nextButton.isEnabled = true
            backButton.isEnabled = true
            playButton.setTitle("再生", for: .normal)
        }
    }
    
    @objc func updateTimer(timer: Timer){
        displayImageNo += 1
        setImage()
    }
    @IBAction func unwind(_ segue: UIStoryboardSegue) {
        // 他の画面から segue を使って戻ってきた時に呼ばれる
    }
}

