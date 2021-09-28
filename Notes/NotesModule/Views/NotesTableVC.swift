//
//  NotesTableViewController.swift
//  Notes
//
//  Created by Артём on 28.09.2021.
//

import UIKit

class NotesTableVC: UITableViewController {
    
    private let cellReuseIdentifier = "notesTabeCell"
    
    private let testNote = NoteViewData(title: "Super Puper Title",
                                        creationDate: "19.09.2021",
                                        text: "n English, tonne is the established spelling alternative to metric ton.")
    
    var presenter: NotesPresenterProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Notes"

        view.backgroundColor = .red
        tableView.register(NoteTableViewCell.self, forCellReuseIdentifier: cellReuseIdentifier)
        
        configureTableView()
        configureNavigationBar()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 200
//    }
    
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
    
    @objc private func createButtonAction() {
        let view = NoteInfoVC()
        view.configure(from: testNote)
        navigationController?.show(view, sender: nil)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath)
        guard let noteCell = cell as? NoteTableViewCell else {
            return UITableViewCell()
        }
        
        noteCell.configure(from: testNote)
        
        return noteCell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        
        guard editingStyle == .delete else { return }
        
        print("Delete cell at index #\(indexPath.row)")
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let scoreIndex = indexPath.row
        
        print("Select cell at index #\(scoreIndex)")
    }
}

extension NotesTableVC: NotesViewProtocol {
    
}
