//
//  IntroViewController.swift
//  VWNMobileDevTask
//
//  Created by Nasr on 28/04/2022.
//

import UIKit

class IntroViewController: UIViewController {
    
    @IBOutlet weak var segmentControl: HBSegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSegmentControl()
    }
    
    func setUpSegmentControl(){
        segmentControl.items = ["Sign Up", "Log In"]
        segmentControl.font = UIFont(name: "Avenir-Black", size: 15)
        segmentControl.borderColor = UIColor(white: 1.1, alpha: 0.3)
        segmentControl.selectedIndex = 0
        segmentControl.addTarget(self, action: #selector(goToLoginPage), for: .valueChanged)
    }
    
    @objc func goToLoginPage(){
        if segmentControl.selectedIndex == 1 {
            let signInVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
            self.present(signInVC, animated: true, completion: nil)
        }
    }
}
