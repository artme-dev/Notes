//
//  TextHighlighter.swift
//  Notes
//
//  Created by Артём on 30.09.2021.
//

import UIKit

extension UITextView {
    
    private func setAttributesForSelectedText(_ attributes: [NSAttributedString.Key: Any]) {
        guard
            let attributedText = attributedText,
            selectedRange.length != 0
        else {
            return
        }
        
        let userSelectedRange = selectedRange
        let mutableAttributedText = NSMutableAttributedString(attributedString: attributedText)
        mutableAttributedText.addAttributes(attributes, range: userSelectedRange)
        self.attributedText = mutableAttributedText
        selectedRange = userSelectedRange
    }
    
    private func removeAttributesForSelectedText(_ attributeKey: NSAttributedString.Key) {
        guard
            let attributedText = attributedText,
            selectedRange.length != 0
        else {
            return
        }
        
        let userSelectedRange = selectedRange
        let mutableAttributedText = NSMutableAttributedString(attributedString: attributedText)
        mutableAttributedText.removeAttribute(attributeKey, range: userSelectedRange)
        self.attributedText = mutableAttributedText
        selectedRange = userSelectedRange
    }
    
    private func getAttribute(for key: NSAttributedString.Key,
                              in targetRange: NSRange) -> Any? {
        
        let attributeValue = attributedText.attribute(key,
                                                      at: targetRange.lowerBound,
                                                      longestEffectiveRange: nil,
                                                      in: targetRange)
        return attributeValue
    }
    
    private func toggleAttribute<T: Equatable>(_ attributeKey: NSAttributedString.Key,
                                               value: T,
                                               in range: NSRange) {
        
        let currentAttributeValue = getAttribute(for: attributeKey, in: range)

        guard
            let currentAttributeValue = currentAttributeValue as? T,
            currentAttributeValue == value
        else {
            setAttributesForSelectedText([attributeKey: value])
            return
        }
        removeAttributesForSelectedText(attributeKey)
    }
    
    @objc func toggleHighlight() {
        guard selectedRange.length != 0 else { return }
        
        let highlightColor = UIColor.accent
        toggleAttribute(NSAttributedString.Key.backgroundColor,
                        value: highlightColor,
                        in: selectedRange)
        delegate?.textViewDidChange?(self)
    }
    
    @objc func toggleBold() {
        guard selectedRange.length != 0 else { return }
        
        let currentFont = getAttribute(for: NSAttributedString.Key.font, in: selectedRange)
        guard
            let currentFont = currentFont as? UIFont,
            let updatedFont = currentFont.withToggledBoldStyle()
        else { return }

        setAttributesForSelectedText([.font: updatedFont])
    }
}
