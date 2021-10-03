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
        static let dateFont: UIFont = .systemFont(ofSize: 16)
        
        static let titleColor: UIColor = .primaryText
        static let textColor: UIColor = .secondaryText
        static let dateColor: UIColor = .tertiaryText
        
        static let titlePlaceholder = "New note"
        static let textPlaceholder = "No additional text"
    }
    
    private let stickyView: StickyShapeView = {
        let stickyView = StickyShapeView()
        stickyView.noteColor = UIColor.notes.cgColor
        stickyView.curlColor = UIColor.noteCurl.cgColor
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
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.dateFont
        label.textColor = Constants.dateColor
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
    var textPreview: String? {
        get { textPreviewLabel.text }
        set {
            guard let text = newValue, !text.isEmpty else {
                textPreviewLabel.text = Constants.textPlaceholder
                return
            }
            textPreviewLabel.text = text
        }
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
        containerStackView.addArrangedSubview(dateLabel)
        
        setContainerConstraints()
    }
    
    private func setContainerConstraints() {
        stickyView.fillSuperviewSafe()
        
        let stackViewInsets = ConstraintsConstants(top: 16, trailing: 32, bottom: 16, leading: 16)
        containerStackView.fillSuperview(using: stackViewInsets)
    }
    
    func configure(from viewData: NoteViewData) {
        title = viewData.title
        textPreview = viewData.text?.string
        dateLabel.text = viewData.creationDate
    }
}
