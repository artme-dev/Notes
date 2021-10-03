//
//  KeyboardObserving.swift
//  Notes
//
//  Created by Артём on 29.09.2021.
//

import UIKit

extension NoteInfoVC {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    func addKeyboardObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey]
        guard let keyboardSize = (keyboardFrame as? NSValue)?.cgRectValue else {
            return
        }
        let bottomInset = keyboardSize.height - view.safeAreaInsets.bottom
        var contentInsets: UIEdgeInsets = .zero
        contentInsets.bottom = bottomInset
        setTextViewContentInsets(contentInsets)
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
        setTextViewContentInsets(UIEdgeInsets.zero)
    }
}
