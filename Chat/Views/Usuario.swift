//
//  Usuario.swift
//  Chat
//
//  Created by Juan Gallo on 5/8/21.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class Usuario {
    
    
    func usuarios (completion:@escaping ([PhotoUser]) -> Void){
        
        let db = Firestore.firestore()
        
        db.collection("users").getDocuments { snapshot , error  in
            
            if error != nil {
                return
            }
            
            let documents = snapshot?.documents
            
            if let documents = documents{
                
                var usuariosArray = [PhotoUser]()
                
                for doc in documents {
                    
                    let userId = doc["firstName"] as? String
                    let username = doc["lastName"] as? String
                    let uid = doc["uid"] as? String
                    
                    if userId == nil || username == nil || uid == nil {
                        return
                    }
                    let n = PhotoUser(userId: userId ?? "", username: username ?? "", uid: uid ?? "")
                    usuariosArray.append(n)
                }
                completion(usuariosArray)
            }
            
        }
    }

}
