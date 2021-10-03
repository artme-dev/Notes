//
//  NotesPresenter.swift
//  Notes
//
//  Created by Артём on 28.09.2021.
//

import Foundation

protocol NotesViewProtocol: AnyObject {
    func showNotes(_ notes: [NoteViewData])
    func showNoteInfoView(for note: NoteViewData)
    func removeCell(at index: Int)
}

protocol NotesPresenterProtocol {
    func viewWillAppear()
    func deleteSelected(for index: Int)
    func cellSelected(with index: Int)
    func createButtonTapped()
    func updateNote(using noteData: NoteInputData)
}

class NotesPresenter {
    private let repository: NotesRepositoryProtocol
    weak var view: NotesViewProtocol?
    private let haveBeenLoadedDefaultsKey = "haveBeenLoaded"
    
    private var showedNotes: [Note]?
    private var showedNote: Note?
    
    init(view: NotesViewProtocol, repository: NotesRepositoryProtocol) {
        self.repository = repository
        self.view = view
    }
    
    private let fullDateFormatter: DateFormatter  = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "d MMM yyyy"
        return dateFormatter
    }()
    private let timeOnlyDateFormatter: DateFormatter  = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"
        return dateFormatter
    }()
    
    private func preparedDate(_ date: Date?) -> String {
        guard let modificationDate = date else {
            return "unknown"
        }
        let calendar = Calendar.autoupdatingCurrent
        if calendar.isDateInToday(modificationDate) {
            return timeOnlyDateFormatter.string(from: modificationDate)
        }
        return fullDateFormatter.string(from: modificationDate)
    }
    
    private func noteViewData(from note: Note) -> NoteViewData {
        return NoteViewData(title: note.title,
                            creationDate: preparedDate(note.modificationDate),
                            text: note.text)
    }
    
    private func noteInfo(from noteInputData: NoteInputData) -> NoteInfo {
        return NoteInfo(title: noteInputData.title ?? "",
                        text: noteInputData.text ?? NSAttributedString())
    }
    
    private func updateShowedNotes() {
        let notes = repository.getNotes()
        guard let notes = notes else {
            return
        }
        let notesViewData = notes.map { noteViewData(from: $0) }
        view?.showNotes(notesViewData)
        
        showedNotes = notes
    }
    
    private func show(note: Note) {
        let viewData = noteViewData(from: note)
        view?.showNoteInfoView(for: viewData)
        
        showedNote = note
    }
    
    private func handleFirstAppLoad() {
        let defaults = UserDefaults.standard
        if !defaults.bool(forKey: haveBeenLoadedDefaultsKey) {
            
            let noteText = NSAttributedString(string: "Let's make your first note")
            let preloadNoteInfo = NoteInfo(title: "Welcome!",
                                           text: noteText)
            
            repository.createNote(using: preloadNoteInfo)
            defaults.set(true, forKey: haveBeenLoadedDefaultsKey)
        }
    }
    
}

// MARK: Notes Presenter Protocol

extension NotesPresenter: NotesPresenterProtocol {
    func viewWillAppear() {
        handleFirstAppLoad()
        updateShowedNotes()
    }
    
    func deleteSelected(for index: Int) {
        guard let showedNotes = showedNotes else { return }
        let note = showedNotes[index]
        repository.delete(note)
        view?.removeCell(at: index)
        self.showedNotes?.remove(at: index)
    }
    
    func cellSelected(with index: Int) {
        guard let showedNotes = showedNotes else { return }
        let selectedNote = showedNotes[index]
        show(note: selectedNote)
    }
    
    func createButtonTapped() {
        let createdNote = repository.createEmptyNote()
        guard let createdNote = createdNote else { return }
        show(note: createdNote)
    }
    
    func updateNote(using noteInputData: NoteInputData) {
        guard let showedNote = showedNote else { return }
        repository.edit(showedNote, using: noteInfo(from: noteInputData))
    }
}
