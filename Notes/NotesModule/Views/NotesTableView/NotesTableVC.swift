//
//  NotesTableViewController.swift
//  Notes
//
//  Created by Артём on 28.09.2021.
//

import UIKit

class NotesTableVC: UITableViewController {
    
    private let cellReuseIdentifier = "notesTableCell"
    private var notes: [NoteViewData]?
    var presenter: NotesPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        title = "Notes"
        tableView.register(NoteTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        configureTableView()
        configureNavigationBar()
        addInfoLabel()
    }
    
    private let infoLabel: UILabel = {
        let infoLabel = UILabel()
        infoLabel.text = "No notes"
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.font = NoteTableViewCell.Constants.textFont
        infoLabel.textColor = NoteTableViewCell.Constants.dateColor
        infoLabel.isHidden = true
        return infoLabel
    }()
    
    private func addInfoLabel() {
        tableView.addSubview(infoLabel)
        infoLabel.centerXAnchor.constraint(equalTo: tableView.centerXAnchor).isActive = true
        infoLabel.topAnchor.constraint(equalTo: tableView.topAnchor, constant: 16).isActive = true
    }
    
    private func updateInfoLabel() {
        infoLabel.isHidden = !(notes == nil || notes!.isEmpty)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        presenter?.viewWillAppear()
    }
    
    private func configureTableView() {
        tableView.backgroundColor = .background
        tableView.separatorStyle = .none
        tableView.isUserInteractionEnabled = true
    }
    
    private func configureNavigationBar() {
        self.navigationItem.leftBarButtonItem = self.editButtonItem
        
        let creationButton = UIButton()
        let buttonImage = UIImage.createButtonIcon.withTintColor(.accent)
        creationButton.setImage(buttonImage, for: .normal)
        creationButton.addTarget(self, action: #selector(createButtonAction), for: .touchUpInside)
        let creationButtonItem = UIBarButtonItem(customView: creationButton)
        self.navigationItem.rightBarButtonItem = creationButtonItem
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes?.count ?? 0
    }
    
    @objc private func createButtonAction() {
        presenter?.createButtonTapped()
    }

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier,
                                                 for: indexPath)
        guard let noteCell = cell as? NoteTableViewCell else {
            return UITableViewCell()
        }
        guard let notes = notes else {
            return noteCell
        }
        
        let index = indexPath.row
        let note = notes[index]
        noteCell.configure(from: note)
        
        return noteCell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        
        guard editingStyle == .delete else { return }
        let index = indexPath.row
        presenter?.deleteSelected(for: index)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let index = indexPath.row
        presenter?.cellSelected(with: index)
    }
}

extension NotesTableVC: NotesViewProtocol {
    func showNotes(_ notes: [NoteViewData]) {
        self.notes = notes
        updateInfoLabel()
        tableView.reloadData()
    }
    
    func showNoteInfoView(for note: NoteViewData) {
        let infoView = NoteInfoVC()
        infoView.configure(from: note)
        infoView.onNoteChanges = { [weak self] (inputData) in
            guard let self = self else { return }
            self.presenter?.updateNote(using: inputData)
        }
        navigationController?.show(infoView, sender: nil)
    }
    
    func removeCell(at index: Int) {
        let indexPath = IndexPath(row: index, section: 0)
        notes?.remove(at: index)
        tableView.deleteRows(at: [indexPath],
                             with: .automatic)
        updateInfoLabel()
    }
}
