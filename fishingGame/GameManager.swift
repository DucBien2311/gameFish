//
//  GameManager.swift
//  fishingGame
//
//  Created by NguyenDucBien on 12/19/16.
//  Copyright © 2016 NguyenDucBien. All rights reserved.
//

import UIKit

class GameManager: NSObject {
    var fishViews : NSMutableArray?
    var hookView : HookerView?
    
    
    override init()
    {
        self.fishViews = NSMutableArray()
        self.hookView = HookerView(frame: CGRectMake(0, -490, 20, 490))
    }
    func addFishToViewController(viewcontroller: UIViewController, width: Int) {
        let fishView = FishView(frame: CGRectMake(0, 0, 40, 30))
        let randomFish = Int(arc4random_uniform(4))
        if randomFish == 0 {
            fishView.generateFish(width, name: "fish1")
            
        }
        else if randomFish == 1
        {
            fishView.generateFish(width, name: "fish2")
            
        }
        else if randomFish == 2
        {
            fishView.generateFish(width, name: "fish3")
            
        }
        else
        {
            fishView.generateFish(width, name: "fish4")
            
        }
        self.fishViews?.addObject(fishView)
        viewcontroller.view.addSubview(fishView)
    }
    
    func bite(fishView: FishView) {
        if (fishView.status != fishView.CAUGHT && self.hookView?.status == self.hookView?.DROPING)
        {
            fishView.caught()
            fishView.center = CGPointMake(self.hookView!.center.x, self.hookView!.frame.origin.y + self.hookView!.frame.height + fishView.frame.width/2)
            self.hookView?.status = self.hookView?.CAUGHT // thay doi trang thai hook
            self.hookView?.size = fishView.size //thay doi trang thai fish theo hook
        }
    }
    
    
    func updateMove() {
        self.hookView?.updateMove()
        for fishView in self.fishViews!
        {
            fishView.updateMove()
            if (CGRectContainsPoint(fishView.frame, CGPointMake((self.hookView?.center.x)!, (self.hookView?.center.y)! + (self.hookView?.bounds.height)!/2)))
            {
                bite (fishView as! FishView)
            }
        }
    }
    
    func dropHookerAtX(x: Int) {
        self.hookView?.dropDownAtX(x)
    }
    
    
    
}
