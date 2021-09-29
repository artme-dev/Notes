//
//  UIColorExtension.swift
//  Notes
//
//  Created by Артём on 28.09.2021.
//

import UIKit

extension UIColor {
    static var accent: UIColor {
        return UIColor.init(named: "AccentColor")!
    }
    
    static var notes: UIColor {
        return UIColor(named: "NoteColor")!
    }
    
    static var noteCurl: UIColor {
        return UIColor(named: "NoteCurlColor")!
    }
    
    static var primaryText: UIColor {
        return UIColor(named: "PrimaryTextColor")!
    }
    
    static var secondaryText: UIColor {
        return UIColor(named: "SecondaryTextColor")!
    }
    
    static var tertiaryText: UIColor {
        return UIColor(named: "TertiaryTextColor")!
    }
    
    static var background: UIColor {
        return UIColor(named: "BackgroundColor")!
    }
}
