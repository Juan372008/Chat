//
//  ViewController.swift
//  Chat
//
//  Created by Juan Gallo on 3/5/21.
//

import UIKit

class ViewController: UIViewController {

   
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpElements()
    }

    func setUpElements(){
        
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleHollowButton(loginButton)
    }

}

