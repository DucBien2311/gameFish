//
//  ViewController.swift
//  fishingGame
//
//  Created by NguyenDucBien on 12/17/16.
//  Copyright © 2016 NguyenDucBien. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    
    var audioPlayer = AVAudioPlayer()
    var gameManager : GameManager?
    var timeFish = NSTimer()
    
    @IBOutlet weak var lblLevel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playSong()
        self.gameManager = GameManager()
        self.view.addSubview((self.gameManager?.hookView)!)
        self.gameManager?.addFishToViewController(self, width: Int(self.view.bounds.width))
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(ViewController.tapHandle(_:))))
        NSTimer.scheduledTimerWithTimeInterval(0.025, target: self.gameManager!, selector: Selector("updateMove"), userInfo: nil, repeats: true)
        
        timeFish = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: #selector(ViewController.addNewFish), userInfo: nil, repeats: true)
    }
    
    func tapHandle(sender: UIGestureRecognizer) {
        let tapPoint = sender.locationInView(self.view)
        self.gameManager?.dropHookerAtX(Int(tapPoint.x))
    }
    
    @IBAction func reset(sender: AnyObject) {
        self.gameManager?.fishViews?.removeAllObjects()
        for object in self.view.subviews
        {
            if (object .isKindOfClass(FishView))
            {
                object .removeFromSuperview()
            }
        }
        
        self.gameManager?.addFishToViewController(self, width: Int(self.view.bounds.width))
    }
    
    func addNewFish() {
        self.gameManager?.addFishToViewController(self, width: Int(self.view.bounds.width))
    }
    
    func playSong()
    {
        let filePath = NSBundle.mainBundle().pathForResource("music 1", ofType: ".mp3")
        let url = NSURL(fileURLWithPath: filePath!)
        audioPlayer = try! AVAudioPlayer(contentsOfURL: url)
        audioPlayer.prepareToPlay()
        audioPlayer.play()
    }
    
}

