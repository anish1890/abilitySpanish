//
//  UIFont+Extension.swift
//  SEStatus
//
//  Created by Jaydeep on 03/06/19.
//  Copyright © 2019 Jaydeep. All rights reserved.
//

import Foundation
import UIKit

enum themeFonts : String
{
    case regular = "Poppins-Regular"
    case semibold = "Poppins-SemiBold"
    case bold = "Poppins-Bold"
    case light = "Poppins-Light"
    case medium = "Poppins-Medium"
}

extension UIFont
{
    
}

func themeFont(size : Float,fontname : themeFonts) -> UIFont
{
    if UIScreen.main.bounds.width <= 320
    {
        return UIFont(name: fontname.rawValue, size: CGFloat(size) - 2.0)!
    }
    else
    {
        return UIFont(name: fontname.rawValue, size: CGFloat(size))!
    }
    
}
