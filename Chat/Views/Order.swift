//
//  Order.swift
//  Chat
//
//  Created by Juan Gallo on 12/6/21.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth

class Order {

    var photos = [Photo]()
    
    var notes = [Note]()
    
    var note = Note()
    
    var secondPhoto:PhotoTwo?
    
    var photoTwo:PhotoTwo?
    
    var chosenPhoto:PhotoTwo?
    
    var email:String?
    
    var author = Author()
    
    var n:PhotoTwo?
    
    var photoTwoArray = [PhotoTwo]()
    
    var uid:String?
    var otherViewController = LoginViewController()
//    var numero = Order.organization(Order.autorizacion())

//    var photoTwoArray = [PhotoTwo]()
   
    
//    static func organization(completion: @escaping ([Photo]) -> Void ) {

//    static func organization(completion: @escaping (PhotoTwo) -> Void ) {
    
    
//    static func autorizacion() -> String {
        
        
       
            
//        return email ?? ""

//    }
    

    

   

    func autorizado(completion:@escaping ([PhotoTwo]) -> Void )   {
        
        var chosenPhoto:PhotoTwo?
            var email:String?
        
        let db = Firestore.firestore()
        db.collection("photos").getDocuments {   snapshot , error  in
            
            if error != nil {
                return
            }
            
            
            let documents = snapshot?.documents
            
            
            
            
            if let documets = documents {
                var photoTwoArray = [PhotoTwo]()

                for doc in documents! {
//                    var n = photoTwo

                    let photoId = doc["photoId"] as? String
                    let userId = doc["byId"] as? String
                    let username = doc["byUsername"] as? String
                    let date = doc["date"] as? String
                    let url = doc["url"] as? String
                    
                    if photoId == nil || userId == nil || username == nil || date == nil || url == nil {
                        return
                    }
                    let n = PhotoTwo(photoId: photoId ?? "", byId: userId ?? "", byUsername: username ?? "", date: date ?? "", url: url ?? "")
                    
                    photoTwoArray.append(n)
    
                }
                
                completion(photoTwoArray)
                
            
                
        }
        

        }
            
            
            
            
            
//        return photoTwoArray
        }
       
    
    
        }
    


    



