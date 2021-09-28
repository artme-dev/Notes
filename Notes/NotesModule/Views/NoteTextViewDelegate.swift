//
//  NoteTextViewDelegate.swift
//  Notes
//
//  Created by Артём on 28.09.2021.
//

import UIKit

extension NoteInfoVC: UITextViewDelegate {
    func textViewDidChangeSelection(_ textView: UITextView) {
        guard view.window != nil else { return }
        
        if isTextPlaceholderActive {
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument,
                                                            to: textView.beginningOfDocument)
        }
    }
    
    func textView(_ textView: UITextView,
                  shouldChangeTextIn range: NSRange,
                  replacementText text: String) -> Bool {
        
        let currentText: String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
        
        let placeholderColor = Constants.placeholderColor
         
        guard !updatedText.isEmpty else {
            textView.text = Constants.textPlaceholder
            textView.textColor = placeholderColor
            textView.selectedTextRange = textView.textRange(from: textView.beginningOfDocument,
                                                            to: textView.beginningOfDocument)
            isTextPlaceholderActive = true
            return false
        }
        if isTextPlaceholderActive && !text.isEmpty {
            isTextPlaceholderActive = false
            textView.textColor = Constants.textColor
            textView.text = text
            return false
        }
        return true
    }
}
