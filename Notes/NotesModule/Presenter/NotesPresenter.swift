//
//  NotesPresenter.swift
//  Notes
//
//  Created by Артём on 28.09.2021.
//

import Foundation

protocol NotesViewProtocol: AnyObject {
    
}

protocol NotesPresenterProtocol {
    
}

class NotesPresenter: NotesPresenterProtocol {
    
    private let repository: NotesRepositoryProtocol
    weak var view: NotesViewProtocol?
    
    init(repository: NotesRepositoryProtocol) {
        self.repository = repository
    }
}
