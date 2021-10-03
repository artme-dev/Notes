//
//  NoteInfoVC.swift
//  Notes
//
//  Created by Артём on 28.09.2021.
//

import UIKit

class NoteInfoVC: UIViewController {
    
    enum Constants {
        static let titleFont: UIFont = .systemFont(ofSize: 32)
        static let dateFont: UIFont = .systemFont(ofSize: 18)
        static let textFont: UIFont = .systemFont(ofSize: 20)
        
        static let titlePlaceholder = "Title"
        static let textPlaceholder = "Type something..."
        
        static let dateLabelColor: UIColor = .secondaryLabel
        static let textColor = UIColor.label
        static let placeholderColor = UIColor.placeholderText
    }
    
    var onNoteChanges: ((NoteInputData)->Void)?
    
    private let contentStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.spacing = 16
        stackView.axis = .vertical
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 24, left: 0, bottom: 16, right: 0)
        return stackView
    }()
    private let titleField: UITextField = {
        let titleField = UITextField()
        titleField.font = Constants.titleFont
        titleField.tintColor = UIColor.accent
        titleField.placeholder = Constants.titlePlaceholder
        return titleField
    }()
    private let dateLabel: UILabel = {
        let dateLabel = UILabel()
        dateLabel.font = Constants.dateFont
        dateLabel.textColor = Constants.dateLabelColor
        return dateLabel
    }()
    private let textView: UITextView = {
        let textView = UITextView()
        textView.font = Constants.textFont
        textView.textColor = Constants.textColor
        textView.dataDetectorTypes = UIDataDetectorTypes.all
        textView.backgroundColor = .clear
        return textView
    }()
    
    var noteTitle: String? {
        get { return titleField.text }
        set { titleField.text = newValue  }
    }
    var noteText: NSAttributedString? {
        get { return textView.attributedText }
        set { textView.attributedText = newValue  }
    }
    var noteInputData: NoteInputData {
        return NoteInputData(title: noteTitle,
                             text: noteText)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Note"
        view.backgroundColor = .background
        navigationItem.largeTitleDisplayMode = .never
        
        textView.delegate = self
        
        addFieldObservers()
        addSubviews()
        setConstraints()
        addKeyboardObservers()
        addInputAccessoryView()
    }
    
    private func addFieldObservers() {
        titleField.addTarget(self, action: #selector(applyChanges), for: .editingChanged)
    }
    
    private func addSubviews() {
        view.addSubview(contentStack)
        contentStack.addArrangedSubview(titleField)
        contentStack.addArrangedSubview(dateLabel)
        contentStack.addArrangedSubview(textView)
        
        textView.addSubview(placeholderLabel)
    }
    
    private func setConstraints() {
        contentStack.fillSuperviewSafe()
        
        let placeholderInsets = ConstraintsConstants(top: 8, trailing: 0, bottom: nil, leading: 4)
        placeholderLabel.fillSuperview(using: placeholderInsets)
    }
    
    func configure(from viewData: NoteViewData) {
        noteTitle = viewData.title
        dateLabel.text = viewData.creationDate
        
        if let text = viewData.text {
            let mutableAttributedString = NSMutableAttributedString(attributedString: text)
            let textLength = text.string.count
            mutableAttributedString.addAttribute(NSAttributedString.Key.font,
                                                 value: Constants.textFont,
                                                 range: NSRange(location: 0, length: textLength))
            noteText = mutableAttributedString
        }
        
        isTextPlaceholderActive = noteText != nil && noteText!.string.isEmpty
    }
    
    @objc func applyChanges() {
        onNoteChanges?(noteInputData)
    }
    
    func setTextViewContentInsets(_ insets: UIEdgeInsets) {
        textView.contentInset = insets
        textView.scrollIndicatorInsets = insets
    }
    
    // MARK: TextView Placeholder
    
    private let placeholderLabel: UILabel = {
        let placeholderLabel = UILabel()
        placeholderLabel.translatesAutoresizingMaskIntoConstraints = false
        placeholderLabel.textColor = Constants.placeholderColor
        placeholderLabel.text = Constants.textPlaceholder
        placeholderLabel.font = Constants.textFont
        placeholderLabel.isUserInteractionEnabled = false
        return placeholderLabel
    }()
    
    var isTextPlaceholderActive: Bool {
        get { return !placeholderLabel.isHidden }
        set { placeholderLabel.isHidden = !newValue }
    }
    
    // MARK: Input Accessory View
    
    private func addInputAccessoryView() {
        
        let bar = UIToolbar()
        
        let boldTextButton = UIBarButtonItem(title: "Bold",
                                             style: .plain,
                                             target: textView,
                                             action: #selector(UITextView.toggleBoldface(_:)))

        let italicTextButton = UIBarButtonItem(title: "Italic",
                                               style: .plain,
                                               target: textView,
                                               action: #selector(UITextView.toggleItalics(_:)))

        let underlineTextButton = UIBarButtonItem(title: "Underline",
                                                  style: .plain,
                                                  target: textView,
                                                  action: #selector(UITextView.toggleUnderline(_:)))

        let highlightTextButton = UIBarButtonItem(title: "Highlight",
                                                  style: .plain,
                                                  target: textView,
                                                  action: #selector(UITextView.toggleHighlight))

        bar.items = [
            boldTextButton,
            UIBarButtonItem.flexibleSpace(),
            italicTextButton,
            UIBarButtonItem.flexibleSpace(),
            underlineTextButton,
            UIBarButtonItem.flexibleSpace(),
            highlightTextButton
        ]
        bar.sizeToFit()

        textView.inputAccessoryView = bar
    }

}
