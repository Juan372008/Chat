//
//  File.swift
//  Chat
//
//  Created by Juan Gallo on 8/5/21.
//

import Foundation
import UIKit
import FirebaseStorage
import FirebaseAuth
import FirebaseFirestore

struct PhotoService {
    
    
    
  

 
 static   func savePhoto(image:UIImage){
        
        if Auth.auth().currentUser == nil{
            
            return
        }
        else {
            
        }
       let photoData = image.jpegData(compressionQuality: 0.1)
        
        guard photoData != nil else {
            return
        }
        
        let filename = UUID().uuidString
        
        let userId = Auth.auth().currentUser!.uid
        
        let ref = Storage.storage().reference().child("images/\(userId)/\(filename).jpg")
        
        ref.putData(photoData!, metadata: nil) { metadata, error in
            
            if error == nil {
                self.createDatabaseEntry(ref: ref)
            }
        }
 }
    
  static   func createDatabaseEntry(ref:StorageReference){
        
        ref.downloadURL { url, error in
            
            if error == nil {
                
                let photoId = ref.fullPath
                let photoUser = LocalStorageService.loadUser()
                let userId = photoUser.userId
                let username = photoUser.username
                
                let df = DateFormatter()
                df.dateStyle = .full
                
                let dateString = df.string(from: Date())
                
                
                let metadata = ["photoId":photoId, "byId":userId, "byUsername":username, "date":dateString, "url":url?.absoluteString]
                
                let db = Firestore.firestore()
                
               
                db.collection("photos").addDocument(data: metadata as [String : Any]) { (error) in
                    
                    
               
                
            }
        }
    }
}
    

}

