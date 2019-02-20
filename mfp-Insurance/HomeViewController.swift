//
//  HomeViewController.swift
//  mfp-Insurance
//
//  Created by Vittal Pai on 31/01/19.
//  Copyright © 2019 Vittal Pai. All rights reserved.
//

import UIKit
import IBMMobileFirstPlatformFoundation

class HomeViewController: UIViewController {
    
        static var path:String = NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true).first!

    override func viewDidLoad() {
        navigationItem.hidesBackButton = true
        super.viewDidLoad()
        // Check for model update
        WLClient.sharedInstance()?.downloadModelUpdate(completionHandler: { (status, response) in
            if (status != nil && response != nil) {
                HomeViewController.path = response!
            }
        }, showProgressBar: true)
    }

    @IBAction func logout(_ sender: Any) {
        WLAuthorizationManager.sharedInstance()?.logout( UserLoginChallengeHandler.securityCheckName, withCompletionHandler: { (error) in
           self.navigationController?.popViewController(animated: true)
        })
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
