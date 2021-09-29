//
//  NotesRepository.swift
//  Notes
//
//  Created by Артём on 28.09.2021.
//

import Foundation

struct NoteInfo {
    let title: String
    let text: String
}

protocol NotesRepositoryProtocol {
    
    func getNotes() -> [Note]?
    
    func createNote(using: NoteInfo) -> Note?
    
    func createEmptyNote() -> Note?
    
    func edit(_: Note, using: NoteInfo)
    
    func delete(_: Note)
}

class NotesRepository: NotesRepositoryProtocol {
    
    private let repository: CoreDataRepository<Note>
    
    init(repository: CoreDataRepository<Note>) {
        self.repository = repository
    }
    
    func getNotes() -> [Note]? {
        do {
            let sortDescripotor = NSSortDescriptor(keyPath: \Note.modificationDate, ascending: false)
            let notes = try repository.getItems(sortDescriptors: [sortDescripotor])
            return notes
        } catch {
            print("Error: \(error)")
            return nil
        }
    }
    
    func createNote(using noteInfo: NoteInfo) -> Note? {
        do {
            let note = try repository.create()
            edit(note, using: noteInfo)
            try repository.applyChanges()
            return note
        } catch {
            print("Error: \(error)")
            return nil
        }
    }
    
    func edit(_ note: Note, using noteInfo: NoteInfo) {
        do {
            note.title = noteInfo.title
            note.text = noteInfo.text
            note.modificationDate = Date()
            try repository.applyChanges()
        } catch {
            print("Error: \(error)")
        }
    }
    
    func delete(_ note: Note) {
        do {
            try repository.delete(item: note)
            try repository.applyChanges()
        } catch {
            print("Error: \(error)")
        }
    }
    
    func createEmptyNote() -> Note? {
        let emptyNoteInfo = NoteInfo(title: "", text: "")
        let note = createNote(using: emptyNoteInfo)
        return note
    }
}
