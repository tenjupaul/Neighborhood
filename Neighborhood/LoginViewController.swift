//
//  LoginVuewController.swift
//  Neighborhood
//
//  Created by Tiange Wang on 9/24/18.
//  Copyright © 2018 Tiange Wang. All rights reserved.
//

import UIKit
import CoreLocation

class LoginViewController: UIViewController {

    let locationManager = CLLocationManager()
    
    @IBOutlet weak var usernameTextLabel: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginErrorLabel: UILabel!
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        if (usernameTextLabel.text!.count < 3 || passwordTextField.text!.count < 8) {
            loginErrorLabel.text = "Invalid login."
            loginErrorLabel.isHidden = false
        } else {
            // find acct
            UserModel.loginUser(findUser: ["username": usernameTextLabel.text!, "pass": passwordTextField.text!], completionHandler: {
                data, response, error in
                do {
                    print("logging in...")
                    if let user = try JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary {
                        DispatchQueue.main.async {
                            if let _ = user["error"]{
                                self.loginErrorLabel.text = user["error"]! as? String
                                self.loginErrorLabel.isHidden = false
                            } else {
                                print(user)
                                LoggedInUser.shared.id = (user["_id"]! as? String)!
                                LoggedInUser.shared.username = (user["username"]! as? String)!
                                LoggedInUser.shared.contact = (user["contact"]! as? String)!
                                LoggedInUser.shared.address = (user["address"]! as? String)!
                                LoggedInUser.shared.latitude = (user["latitude"]! as? String)!
                                LoggedInUser.shared.longitude = (user["longitude"]! as? String)!
                                self.performSegue(withIdentifier: "LoginSegue", sender: nil)
                            }
                        }
                    }
                    
                } catch {
                    print("Error logging in from LoginVC.")
                }
            })
        }
    }
    
    override func viewDidLoad() {
        loginErrorLabel.isHidden = true
        super.viewDidLoad()
    }
    
    @IBAction func registerNewAccount(_ sender: UIButton) {
        performSegue(withIdentifier: "ToRegisterSegue", sender: nil)
    }
    
}

