//
//  ViewController.swift
//  mfp-Insurance
//
//  Created by Vittal Pai on 07/01/19.
//  Copyright © 2019 Vittal Pai. All rights reserved.
//

import UIKit
import IBMMobileFirstPlatformFoundation
import IBMMobileFirstPlatformFoundationPush

class LoginViewController: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    func registerPush() {
        MFPPush.sharedInstance().registerDevice(nil) { (response, error) -> Void in
            if error == nil {
                MFPPush.sharedInstance().subscribe(["HR"]) { (response, error)  -> Void in
                    if error == nil {
                      //  print("Subscribed successfully response: \(response)")
                    } else {
                     //   print("Error \(error?.localizedDescription)")
                    }
                }
                
              //  print(response?.description ?? "")
                
            } else {
                
              //  print(error?.localizedDescription ?? "")
            }
            
        }
        
    }
    
    @IBAction func login(_ sender: Any) {
        if let user = username.text, let pass = password.text{
            let dictionary = ["buttonClick": "login"]
            WLAnalytics.sharedInstance().log("buttonClick", withMetadata: dictionary as [String: AnyHashable]);
            WLAnalytics.sharedInstance()?.send()
            WLAuthorizationManager.sharedInstance()?.login(UserLoginChallengeHandler.securityCheckName, withCredentials: ["username": user, "password" : pass], withCompletionHandler: { (error) in
                if (error == nil) {
                    WLAnalytics.sharedInstance().setUserContext(user)
                    WLAnalytics.sharedInstance()?.send()
                    self.navigationController?.pushViewController( (self.storyboard?.instantiateViewController(withIdentifier: "Home"))!, animated: true)
                }
            })
        }
    }
    
    func showInvalidScreen() {
        let alert = UIAlertController(title: "Invalid", message: "Username/Password is invalid, Kindly Retry.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Okay", style: UIAlertAction.Style.cancel, handler: {(alert: UIAlertAction!) in
            self.username.text = ""
            self.password.text = ""
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    
    
}

