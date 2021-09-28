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
        textView.dataDetectorTypes = UIDataDetectorTypes.all
        textView.backgroundColor = .clear
        return textView
    }()
    
    var isTextPlaceholderActive = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Note"
        view.backgroundColor = .background
        navigationItem.largeTitleDisplayMode = .never
        
        textView.delegate = self

        addSubviews()
        setConstraints()
    }
    
    private func addSubviews() {
        view.addSubview(contentStack)
        contentStack.addArrangedSubview(titleField)
        contentStack.addArrangedSubview(dateLabel)
        contentStack.addArrangedSubview(textView)
    }
    
    private func setConstraints() {
        contentStack.fillSuperviewSafe()
    }
    
    func configure(from viewData: NoteViewData) {
        titleField.text = viewData.title
        dateLabel.text = viewData.creationDate
        textView.text = viewData.text
    }
}
