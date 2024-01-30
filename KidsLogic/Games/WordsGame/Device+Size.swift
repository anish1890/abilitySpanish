//
//  Created by HashMob on 06/07/19.
//  Copyright © 2021 HashMob. All rights reserved.
//

import Foundation
import UIKit

let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
let SCREEN_WIDTH = UIScreen.main.bounds.size.width

//Check IsiPhone Device
func IS_IPHONE_DEVICE()->Bool{
    let deviceType = UIDevice.current.userInterfaceIdiom == .phone
    return deviceType
}

//Check IsiPad Device
func IS_IPAD_DEVICE()->Bool{
    let deviceType = UIDevice.current.userInterfaceIdiom == .pad
    return deviceType
}


//MARK: - iPhone 4 OR 4S
func IS_IPHONE_4_OR_4S()->Bool{
    let SCREEN_HEIGHT_TO_CHECK_AGAINST:CGFloat = 480
    var device:Bool = false
    
    if(SCREEN_HEIGHT_TO_CHECK_AGAINST == SCREEN_HEIGHT)    {
        device = true
    }
    return device
}

//MARK: - iPhone 5 OR OR 5C OR 4S
func IS_IPHONE_5_OR_5S()->Bool{
    let SCREEN_HEIGHT_TO_CHECK_AGAINST:CGFloat = 568
    var device:Bool = false
    if(SCREEN_HEIGHT_TO_CHECK_AGAINST == SCREEN_HEIGHT)    {
        device = true
    }
    return device
}

//MARK: - iPhone 6 OR 6S
func IS_IPHONE_6_OR_6S()->Bool{
    let SCREEN_HEIGHT_TO_CHECK_AGAINST:CGFloat = 667
    var device:Bool = false
    
    if(SCREEN_HEIGHT_TO_CHECK_AGAINST == SCREEN_HEIGHT)    {
        device = true
    }
    return device
}

//MARK: - iPhone 6Plus OR 6SPlus
func IS_IPHONE_6P_OR_6SP()->Bool{
    let SCREEN_HEIGHT_TO_CHECK_AGAINST:CGFloat = 736
    var device:Bool = false
    
    if(SCREEN_HEIGHT_TO_CHECK_AGAINST == SCREEN_HEIGHT)    {
        device = true
    }
    return device
}

func IS_IPHONE_11P()->Bool{
    let SCREEN_HEIGHT_TO_CHECK_AGAINST:CGFloat = 812
    var device:Bool = false
    
    if(SCREEN_HEIGHT_TO_CHECK_AGAINST == SCREEN_HEIGHT)    {
        device = true
    }
    return device
}


func IS_IPHONE_11_OR_11PROMAX()->Bool{
    let SCREEN_HEIGHT_TO_CHECK_AGAINST:CGFloat = 896
    var device:Bool = false
    
    if(SCREEN_HEIGHT_TO_CHECK_AGAINST == SCREEN_HEIGHT)    {
        device = true
    }
    return device
}

func IS_IPHONE_12_OR_12PRO()->Bool{
    let SCREEN_HEIGHT_TO_CHECK_AGAINST:CGFloat = 844
    var device:Bool = false
    
    if(SCREEN_HEIGHT_TO_CHECK_AGAINST == SCREEN_HEIGHT)    {
        device = true
    }
    return device
}

func IS_IPHONE_12MINI()->Bool{
    let SCREEN_HEIGHT_TO_CHECK_AGAINST:CGFloat = 780
    var device:Bool = false
    
    if(SCREEN_HEIGHT_TO_CHECK_AGAINST == SCREEN_HEIGHT)    {
        device = true
    }
    return device
}

func IS_IPHONE_12ProMAX()->Bool{
    let SCREEN_HEIGHT_TO_CHECK_AGAINST:CGFloat = 926
    var device:Bool = false
    
    if(SCREEN_HEIGHT_TO_CHECK_AGAINST == SCREEN_HEIGHT)    {
        device = true
    }
    return device
}

//MARK: - DEVICE ORIENTATION CHECK
func IS_DEVICE_PORTRAIT() -> Bool {
    return UIDevice.current.orientation.isPortrait
}

func IS_DEVICE_LANDSCAPE() -> Bool {
    return UIDevice.current.orientation.isLandscape
}
