//
//  NoteTextViewDelegate.swift
//  Notes
//
//  Created by Артём on 28.09.2021.
//

import UIKit

extension NoteInfoVC: UITextViewDelegate {
    
    func textView(_ textView: UITextView,
                  shouldChangeTextIn range: NSRange,
                  replacementText text: String) -> Bool {

        let currentText: String = textView.text
        let updatedText = (currentText as NSString).replacingCharacters(in: range, with: text)
        
        let textWithoutSpaces = updatedText.replacingOccurrences(of: " ", with: "")
        let cleanText = textWithoutSpaces.replacingOccurrences(of: "\n", with: "")
        
        guard !(currentText.isEmpty && cleanText.isEmpty) else {
            return false
        }
        
        if updatedText.isEmpty {
            isTextPlaceholderActive = true
        }
        if isTextPlaceholderActive && !text.isEmpty {
            isTextPlaceholderActive = false
        }
        
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        applyChanges()
    }
}
