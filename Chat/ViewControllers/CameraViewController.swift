//
//  CameraViewController.swift
//  Chat
//
//  Created by Juan Gallo on 14/5/21.
//

import UIKit
import FirebaseFirestore
import FirebaseDatabase

class CameraViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    
    @IBOutlet weak var profileButton: UIButton!
    
    var photos = PhotoCell()
   
    var photosArray = [Photo]()
    
    var mail:String?
    
    var emailValorSignUp:String?
    
    
    
   
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        mail = emailValorSignUp

        
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    @IBAction func imageTapped(_ sender: Any) {

//      Action Button
        let actionsheet = UIAlertController(title: "Add profile Id", message: "Select a source", preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
        let cameraButton = UIAlertAction(title: "Camera", style: .default) { action in
            self.showImagePickerController(mode: .camera)
        }
        actionsheet.addAction(cameraButton)
}
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary){
            
        let libraryButton = UIAlertAction(title: "Photo Library", style: .default) { action  in
            
            self.showImagePickerController(mode: .photoLibrary)
        }
        actionsheet.addAction(libraryButton)
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel) { action in
            
        }
        actionsheet.addAction(cancelButton)
            
        present(actionsheet, animated: true, completion: nil)

        
        
    }
    
    
    @IBAction func transitionTapped(_ sender: Any) {
        let homeViewController = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.homeViewController) as? HomeViewController
         
         view.window?.rootViewController = homeViewController
         view.window?.makeKeyAndVisible()
    }
    
    func showImagePickerController(mode: UIImagePickerController.SourceType){
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = mode
        imagePicker.delegate = self
        
        present(imagePicker, animated: true, completion: nil)
    }    
    
    func savePhoto(image:UIImage) {
        PhotoService.savePhoto(image: image)
    }
    func displayImage(photo:Photo){
        
        if photo.url == nil {
            return
        }
        
        let url = URL(string: photo.url!)
        
        if url == nil {
            return
        }
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!) { data, response, error in
            
            if error == nil && data != nil {
                
                let image = UIImage(data: data!)
                
                DispatchQueue.main.async {
                    self.profileImage.image = image     }
            }
        }
        dataTask.resume()
        
    
    }
    
    
    @IBAction func viewChange(_ sender: Any) {
        newScreen()
    }
    
    func newScreen() {
        performSegue(withIdentifier: "ImageToHomeVC", sender: self)

        }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        

        if segue.destination is HomeViewController {
        let VC = segue.destination as! HomeViewController
            VC.emailValor = self.mail ?? "Error en camara"
        }
    }
}


extension CameraViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        
        if selectedImage != nil {
        PhotoService.savePhoto(image: selectedImage!)
            self.profileImage.image = selectedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
}
