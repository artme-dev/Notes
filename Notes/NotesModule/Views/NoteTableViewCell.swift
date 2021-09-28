//
//  NotesTableViewCell.swift
//  Notes
//
//  Created by Артём on 28.09.2021.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    
    enum Constants {
        static let titleFont: UIFont = .systemFont(ofSize: 20)
        static let textFont: UIFont = .systemFont(ofSize: 16)
        
        static let titleColor: UIColor = .primaryText
        static let textColor: UIColor = .secondaryText
        static let noteColor: UIColor = .notes
        static let noteCurlColor: UIColor = .noteCurl
        
        static let titlePlaceholder = "New note"
        static let textPlaceholder = "No additional text"
    }
    
    private let stickyView: StickyShapeView = {
        let stickyView = StickyShapeView()
        stickyView.noteColor = Constants.noteColor.cgColor
        stickyView.curlColor = Constants.noteCurlColor.cgColor
        stickyView.translatesAutoresizingMaskIntoConstraints = false
        return stickyView
    }()
    
    private let containerStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 8
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = Constants.titleFont
        label.textColor = Constants.titleColor
        return label
    }()
    private let textPreviewLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = Constants.textFont
        label.textColor = Constants.textColor
        return label
    }()
    
    var title: String? {
        get { titleLabel.text }
        set {
            guard let title = newValue, !title.isEmpty else {
                titleLabel.text = Constants.titlePlaceholder
                return
            }
            titleLabel.text = title
        }
    }
    private func setTextPreview(text: String?, date: String) {
        guard let textPreview = text, !textPreview.isEmpty else {
            textPreviewLabel.text = Constants.textPlaceholder
            return
        }
        let combinedPreview = "\(date) | \(textPreview)"
        textPreviewLabel.text = combinedPreview
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func commonInit() {
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(stickyView)
        stickyView.addSubview(containerStackView)
        
        containerStackView.addArrangedSubview(titleLabel)
        containerStackView.addArrangedSubview(textPreviewLabel)
        
        setContainerConstraints()
    }
    
    private func setContainerConstraints() {
        stickyView.fillSuperviewSafe()
        
        let stackViewInstets = ConstraintsConstants(top: 16, trailing: 32, bottom: 16, leading: 16)
        containerStackView.fillSuperview(using: stackViewInstets)
    }
    
    func configure(from viewData: NoteViewData) {
        title = viewData.title
        setTextPreview(text: viewData.text, date: viewData.creationDate)
    }
}
