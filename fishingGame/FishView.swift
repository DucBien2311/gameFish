//
//  FishView.swift
//  fishingGame
//
//  Created by NguyenDucBien on 12/19/16.
//  Copyright © 2016 NguyenDucBien. All rights reserved.
//

import UIKit

class FishView: UIImageView {
    var status : Int? // Trang thai cua ca, boi, chay, da bi bat...
    var speed: Int? // Luu lai toc do cua ca
    var vy : Int? // Luu xem ca boi chieu nao -1 0 1
    var widthFrame : Int? // Chieu dai frame hien tai
    var heightFrame : Int? // Chieu cao frame hien tai
    var widthFish : Int? // Chieu dai con ca
    var heightFish : Int? // Chieu cao con ca
    let MOVING : Int = 0 // di chuyen
    let CAUGHT : Int = 1 //  bi bat
    var point : Int?
    
    var small: Int = 10
    var bigest: Int = 2
    var medium: Int = 5
    var big: Int = 3
    var size : Int?
    
    
    override init(frame: CGRect) {
        self.widthFish = Int(frame.width)
        self.heightFish = Int(frame.height)
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder){
        fatalError("init(coder:) has not been implemented")
    }
    
    func generateFish(width: Int, name: String) { // Sinh ra con ca
        self.widthFrame = width; // Luu lai chieu dai man hinh thiet bi
        self.vy = Int(arc4random_uniform(3)) - 1 // random chieu ca boi
        let y : Float = Float(arc4random_uniform(240)) + 80 // vi tri ca xuat hien tren man hinh
        self.status = MOVING // ca di chuyen
        self.speed = (Int)(arc4random_uniform(5)) + 2 // toc do cua ca
        
        if (Int(self.center.x) <= -Int(self.widthFish!/2)) { // ca ra ngoai man hinh tu phai qua trai
            self.transform = CGAffineTransformIdentity
            self.image = UIImage(named: name)
            switch name {
            case "fish1": self.size = small
            case "fish2": self.size = bigest
            case "fish3": self.size = medium
            case "fish4": self.size = big
            default:
                break
            }
            self.frame = CGRectMake(-CGFloat(self.widthFish!), CGFloat(y), CGFloat(self.widthFish!), CGFloat(self.heightFish!))
        }
        else
        {
            self.transform = CGAffineTransformIdentity // ca ra ngoai man hinh chieu tu trai qua phai
            self.image = UIImage(CGImage: UIImage(named: name)!.CGImage!, scale: 1.0, orientation: UIImageOrientation.UpMirrored)// quay dau con ca
            switch name {
            case "fish1": self.size = small
            case "fish2": self.size = bigest
            case "fish3": self.size = medium
            case "fish4": self.size = big
            default:
                break
            }
            self.frame = CGRectMake(CGFloat(self.widthFrame! + self.widthFish!), CGFloat(y), CGFloat(self.widthFish!), CGFloat(self.heightFish!))
            self.speed = -Int(self.speed!)
        }
        
    }
    
    func updateMove()
        
    {
        if(self.status == MOVING)
        {
            self.center = CGPointMake(self.center.x + CGFloat(self.speed!), self.center.y + CGFloat(self.vy!))
            if (Int(self.center.y) < -Int(self.heightFish!) || Int(self.center.y) > self.heightFish! + 550)
            {
                
                self.vy = -self.vy!
            }
            if ((Int(self.center.x) > self.widthFrame! && self.speed! > 0) || (Int(self.center.x) < -self.widthFish! && self.speed! < 0))
            {
                let rdFish = Int(arc4random_uniform(4))
                if rdFish == 0
                {
                    self.size = small
                    generateFish(self.widthFrame!, name: "fish1")
                    
                }
                else if rdFish == 1
                {
                    self.size = bigest
                    generateFish(self.widthFrame!, name: "fish2")
                    
                }
                else if rdFish == 2
                {
                    self.size = medium
                    generateFish(self.widthFrame!, name: "fish3")
                }
                else
                {
                    self.size = big
                    generateFish(self.widthFrame!, name: "fish4")
                    
                }
            }
        }
        else if (self.status == CAUGHT)
        {
            if self.size == small
            {
                self.center = CGPointMake(self.center.x, self.center.y - CGFloat(self.size!))
            }
            if self.size == medium
            {
                self.center = CGPointMake(self.center.x, self.center.y - CGFloat(self.size!))
            }
            if self.size == big
            {
                self.center = CGPointMake(self.center.x, self.center.y - CGFloat(self.size!))
            }
            if self.size == bigest
            {
                self.center = CGPointMake(self.center.x, self.center.y - CGFloat(self.size!))
            }
            
        }
        
    }
    
    
    func caught () {
        if (self.status == MOVING) {
            self.status = CAUGHT
            if (self.speed > 0)
            {
                self.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI_2))
            }
            else
            {
                self.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
            }
        }
    }
    
    
    
    
}
