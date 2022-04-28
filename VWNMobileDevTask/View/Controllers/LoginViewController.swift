//
//  LoginViewController.swift
//  VWNMobileDevTask
//
//  Created by Nasr on 28/04/2022.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hidenKeyboard()
    }
    @IBAction func didPressedOnSignIn(_ sender: Any) {
        self.animateButton(button: sender as! UIButton)
        
        if valiedSignIn(){
            print("Sing in success")
        }else{
            print("sign in falied")
            self.showAlertError(title: "Valied Info", message: "Please, fill correct info..")
        }
    }
    
    func valiedSignIn() -> Bool{
        guard let name = userNameTextField.text, !name.isEmpty, name.count >= 3, let password = passwordTextField.text, !password.isEmpty, password.count >= 6 else {
            return false
        }
        return true
    }
}
