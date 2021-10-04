//
//  UIFontToggleStyle.swift
//  Notes
//
//  Created by Артём on 02.10.2021.
//

import UIKit

extension UIFont {
    private func withToggledTraits(_ targetTrait: UIFontDescriptor.SymbolicTraits) -> UIFont? {
        let currentTraits = fontDescriptor.symbolicTraits
        let resultTraits = currentTraits.symmetricDifference(targetTrait)
        let descriptor = fontDescriptor.withSymbolicTraits(resultTraits)
        guard let descriptor = descriptor else { return nil }
        return UIFont(descriptor: descriptor, size: 0)
    }
    
    func withToggledBoldStyle() -> UIFont? {
        let targetTrait: UIFontDescriptor.SymbolicTraits = .traitBold
        return withToggledTraits(targetTrait)
    }
    
    func withToggledItalicStyle() -> UIFont? {
        let targetTrait: UIFontDescriptor.SymbolicTraits = .traitItalic
        return withToggledTraits(targetTrait)
    }
}
