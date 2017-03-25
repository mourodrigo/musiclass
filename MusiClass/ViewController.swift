//
//  ViewController.swift
//  MusiClass
//
//  Created by Rodrigo Bueno Tomiosso on 25/03/17.
//  Copyright © 2017 mourodrigo. All rights reserved.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {
    var player: AVAudioPlayer?
    
    let keys = ["a","b","bb","c","c1","d","e","eb","f","f1","g","g1"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NotificationCenter.default.addObserver(self, selector: #selector(deviceOrientationDidChange), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        self.addButtons()
    }
    
    func addButtons(){
        let width = self.view.frame.width
        let buttonSize = CGSize.init(width: width/CGFloat(keys.count), height: width/CGFloat(keys.count))

        var index = 0
        for key in self.keys {
            let keyButton = UIButton.init()
            keyButton.setTitle(key, for: .normal)
            keyButton.frame = CGRect.init(x: self.view.frame.minX+(CGFloat(index) * buttonSize.width), y: self.view.center.y, width: buttonSize.width, height: buttonSize.height)
            keyButton.tag = index
            index = index+1
            keyButton.setTitleColor(UIColor.gray, for: .normal)

            keyButton.addTarget(self, action: #selector(didPressKey(_:)), for: .touchDown)
            
            self.view.addSubview(keyButton)
            
        }
    }
    
    @IBAction func didPressKey(_ sender: Any) {
        playSound(key: self.keys[(sender as AnyObject).tag])
    }
    
    
    func playSound(key:String) {

        let url = Bundle.main.url(forResource: "piano-\(key)", withExtension: "wav")!
        
        do {
            self.player = try AVAudioPlayer(contentsOf: url)
            guard let player = self.player else { return }
            
            player.prepareToPlay()
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }

    }
    
  
    
    func deviceOrientationDidChange(_ notification: Notification) {
        let orientation = UIDevice.current.orientation
        print(orientation)
        
        for view in self.view.subviews{
            view.removeFromSuperview()
        }
        self.addButtons()
        
    }
    
}

