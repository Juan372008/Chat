//
//  SignUpViewController.swift
//  Chat
//
//  Created by Juan Gallo on 3/5/21.
//

import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController{

    
    @IBOutlet weak var firstNameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    
    @IBOutlet weak var loginLabel: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func validateFields() -> String? {
        
        if firstNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passwordTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == ""{
            return "Please fill in all fields"
        }
        
        let cleanedPassword = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        let cleanedEmail = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            
            return "Please make sure your password is at least 8 characters, contains a special character and a number"
        }
        
        if Utilities.isEmailValid(cleanedEmail) == false {
            return "Please insert a correct email"
        }
        return nil
    }

    @IBAction func signUpTapped(_ sender: Any) {
        
        let error = validateFields()
        
        
        if error != nil {
            showError(error!)

        }
    
    else
    {
        
        let firstName = firstNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let lastName = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let email = emailTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passwordTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        storage(email, password, firstName, lastName)
    }
        
        
    }
    func storage(_ email:String,_ password:String,_ firstName:String,_ lastName:String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, err in
            if  err != nil{
                self.showError("Error creating user")
            }
            else
            {
                let db = Firestore.firestore()
                
                
                db.collection("users").addDocument(data: ["firstName":firstName,"lastName":lastName, "uid":result!.user.uid]) { error in
                    
                    
                    
                    if error != nil {
                        self.showError("Error saving user data")
                }
                    LocalStorageService.saveUser(userId: Auth.auth().currentUser!.uid, username: email)            }
                
                self.transitionToHome()
        }
    }
        
    }
    func showError(_ message:String) {
        
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func setUpElements (){
        
        errorLabel.alpha = 0
        
        Utilities.styleTextField(firstNameTextField)
        
        Utilities.styleTextField(lastNameTextField)
        
        Utilities.styleTextField(emailTextField)
        
        Utilities.styleTextField(passwordTextField)
        
        Utilities.styleFilledButton(signUpButton)
        
        Utilities.styleHollowButton(loginLabel)
    

        
        
    
    }
        
        func transitionToHome() {

            
            
            performSegue(withIdentifier: "ImageVC", sender: self)
        }
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            
            let email = emailTextField?.text!.trimmingCharacters(in: .whitespacesAndNewlines)

            if segue.destination is CameraViewController {
            let VC = segue.destination as! CameraViewController
            VC.emailValorSignUp = email ?? "Error en sign up"
            }

}
}

