//
//  HookerView.swift
//  fishingGame
//
//  Created by NguyenDucBien on 12/19/16.
//  Copyright © 2016 NguyenDucBien. All rights reserved.
//

import UIKit

class HookerView : UIImageView {
    let PREPARE = 0 // co the keo
    let DROPING = 1 // dang keo xuong
    let DRAWINGUP = 2 // keo len
    let CAUGHT = 3 // bat duoc ca
    var status : Int?
    var widthFrame : Int?
    var heightFrame : Int?
    var fishViews : FishView?
    var small: Int = 10
    var bigest: Int = 2
    var medium: Int = 5
    var big: Int = 3
    var size : Int?
    
    

    
    override init(frame: CGRect) {
        self.widthFrame = Int(frame.width)
        self.heightFrame = Int(frame.height)
        super.init(frame: frame)
        self.image = UIImage(named: "hook")
        self.status = PREPARE
    }
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateMove() {
        if (self.status == DROPING)
        {
            self.center = CGPointMake(self.center.x, self.center.y + 10)
            if (self.frame.origin.y + self.frame.height > CGFloat(heightFrame!))
            {
                self.status = DRAWINGUP
            }
        }
        else if (self.status == DRAWINGUP)
        {
            self.center = CGPointMake(self.center.x, self.center.y - 20)
            if (self.frame.origin.y + self.frame.size.height < 0)
            {
                self.status = PREPARE
            }
        }
        else if (self.status == CAUGHT)
        {
                self.center = CGPointMake(self.center.x, self.center.y - CGFloat((self.size)!))
        }
        if (self.frame.origin.y + self.frame.height < 0)
        {
            self.status = PREPARE
        }
    }
    
    func dropDownAtX(x: Int)
    {
        if (self.status == PREPARE)
        {
            self.center = CGPointMake(CGFloat(x), self.center.y)
            self.status = DROPING
        }
    }
    
    
}
