//
//  SwiftViewController.swift
//  GatorRenter
//
//  Created by fdai4856 on 15/03/2017.
//  Copyright © 2017 fdai4856. All rights reserved.
//



import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var EmailView: UIView!
    @IBOutlet weak var PasswordView: UIView!
    
    var emailTextField: UITextField? = nil
    var passwordTextField: UITextField? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailTextField = EmailView.viewWithTag(1) as! UITextField?
        passwordTextField = PasswordView.viewWithTag(1) as! UITextField?
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setNavigationBarItem()
    }
    
    @IBAction func LoginButtonTouchUpInside(_ sender: Any) {
        Networking.Login(email: (emailTextField?.text)!, password: (passwordTextField?.text)!, success: { (response) -> Void in
            let status = response as! [String: String]
            
            let nc = NotificationCenter.default
            
            if status["success"] == "true" {
                nc.post(name:Notification.Name(rawValue:"LoginNotification"),
                        object: nil,
                        userInfo: ["loggedIn" : true])
            }            
        })
    }
}
