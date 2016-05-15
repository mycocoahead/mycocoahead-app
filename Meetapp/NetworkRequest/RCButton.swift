//
//  RCButton.swift
//  MyEventApp
//
//  Created by Hijazi on 18/4/16.
//  Copyright © 2016 iReka Soft. All rights reserved.
//

import UIKit

class RCButton : UIButton {
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    layer.borderWidth = 1.0
    layer.borderColor = tintColor.CGColor
    layer.cornerRadius = 5.0
    clipsToBounds = true
    contentEdgeInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    setTitleColor(tintColor, forState: .Normal)
    setTitleColor(UIColor.whiteColor(), forState: .Highlighted)
//    setBackgroundImage(UIImage(color: tintColor), forState: .Highlighted)
  }
  
}
