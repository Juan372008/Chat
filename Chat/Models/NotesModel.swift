//
//  NotesModel.swift
//  Chat
//
//  Created by Juan Gallo on 31/5/21.
//

import Foundation
import Firebase
import FirebaseDatabase
import FirebaseFirestore

protocol NotesModelProtocol {
    
    func notesRetrieved(notes:[Note])
}
class NotesModel {
    
    var delegate:NotesModelProtocol?
    
    var listener:ListenerRegistration?
    var notas = [Note]()
    
    deinit {
        listener?.remove()
    }


    func getNotes() {
    
    let db = Firestore.firestore()
    
        self.listener = db.collection("notes").addSnapshotListener({ snapshot, error  in
            
            if error == nil && snapshot != nil {
                
                var notes = [Note]()
                
                for doc in snapshot!.documents {
                    
                    let createdAtDate = Timestamp.dateValue(doc["createdAt"] as! Timestamp)
                    
                    let n = Note(docId: doc["docId"] as? String, body: doc["body"] as? String, createdAt: createdAtDate(), user: doc["user"] as? String)
                    
                    notes.append(n)
                }
                
                DispatchQueue.main.async {
                    self.delegate?.notesRetrieved(notes: notes)

                }
                
            }
        })
            
            
        
        
    }
    
    
    func saveNote(_ n:Note){
        
        let db = Firestore.firestore()
        
        db.collection("notes").document(n.docId!).setData(noteToDict(n))
        db.collection("notes").document(n.docId!).mutableOrderedSetValue(forKey: "createdAt")

    }
    
    func noteToDict(_ n:Note) -> [String:Any]{
        
        var dict = [String:Any]()
        
        dict["docId"] = n.docId
        dict["body"] = n.body
        dict["createdAt"] = n.createdAt
        dict["user"] = n.user
        dict["picture"] = n.picture
        return dict
    }
    
}
