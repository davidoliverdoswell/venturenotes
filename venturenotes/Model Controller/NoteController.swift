//
//  NoteController.swift
//  venturenotes
//
//  Created by David Doswell on 10/29/18.
//  Copyright © 2018 David Doswell. All rights reserved.
//

import Foundation

private let noteList = "noteList"

class NoteController {
    
    private(set) var notes: [Note] = []
    
    func createNote(text: String, reference: String, date: Date) {
        let note = Note(text: text, reference: reference, date: date)
        notes.append(note)
        encode()
    }
    
    func delete(note: Note) {
        guard let index = notes.index(of: note) else { return }
        notes.remove(at: index)
        encode()
    }
    
    var url : URL? {
        let fileManager = FileManager()
        let docDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        return docDirectory.appendingPathComponent(noteList)
    }
    
    func encode() {
        do {
            guard let url = url else { return }
            
            let encoder = PropertyListEncoder()
            let noteData = try encoder.encode(notes)
            try noteData.write(to: url)
        } catch {
            NSLog("Error encoding: \(error)")
        }
    }
    
    func decode() {
        let fileManager = FileManager()
        do {
            guard let url = url, fileManager.fileExists(atPath: url.path) else { return }
            
            let noteData = try Data(contentsOf: url)
            let decoder = PropertyListDecoder()
            let decodedNotes = try decoder.decode([Note].self, from: noteData)
            notes = decodedNotes
        } catch {
            NSLog("Error decoding: \(error)")
        }
    }
}
