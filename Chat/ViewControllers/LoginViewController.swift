//
//  LoginViewController.swift
//  Chat
//
//  Created by Juan Gallo on 3/5/21.
//

import UIKit
import FirebaseAuth

//protocol LoginViewControllerProtocol {
//    func loginViewControllerRetrieved(email:String)
//}

class LoginViewController: UIViewController {
    
//    var delegate:LoginViewControllerProtocol?
    
    var homeViewController:HomeViewController?
    
    var correo:Email?
    
    var password:String?
    
    var email:String?
    
    
    
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var lastNameTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    
    @IBOutlet weak var registerButton: UIButton!
    
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        
        setUpElements()
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIInputViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    func showError(_ message:String) {
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    func validateFields() -> String?{
        
        if nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || ((lastNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines))) == "" {
            return " Please fill in all fields"
        }
        
        let cleanedPassword = lastNameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedEmail = nameTextField.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if Utilities.isPasswordValid(cleanedPassword) == false {
            return " Invalid password"
        }
        if Utilities.isEmailValid(cleanedEmail) == false {
            return " Incorrect username"
        }
        return nil
    }
    
    func setUpElements(){
        
        errorLabel?.alpha = 0
        if nameTextField != nil{
        Utilities.styleTextField(lastNameTextField)
        Utilities.styleFilledButton(loginButton)
        Utilities.styleHollowButton(registerButton)
        }
    }

    @IBAction func loginTapped(_ sender: Any) {
        
        
        

        let error = validateFields()
        
        if error != nil {
            showError(error!)
        }
        else
        {
             
           
            
            
          
            self.transitionToHome()

            
        }
    }
    func transitionToHome() {

        self.email = nameTextField?.text!.trimmingCharacters(in: .whitespacesAndNewlines)
       password = lastNameTextField?.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        correo = Email(emailValue: email ?? "", password: password ?? "")
        
        Auth.auth().signIn(withEmail: email ?? "" , password: password ?? "" ) {  result, error in
            
            if error != nil{
                self.errorLabel?.text = error?.localizedDescription
                self.errorLabel?.alpha = 1
            }
        
            if Auth.auth().currentUser != nil {
                LocalStorageService.saveUser(userId: Auth.auth().currentUser!.uid, username: self.email)
            }
        }
        performSegue(withIdentifier: "HomeVC", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        email = nameTextField?.text!.trimmingCharacters(in: .whitespacesAndNewlines)

        if segue.destination is HomeViewController {
        let VC = segue.destination as! HomeViewController
        VC.valor = email ?? "Error aqui"
            VC.control = "Comes from Login"
        }
    }
}
