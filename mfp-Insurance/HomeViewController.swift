//
//  HomeViewController.swift
//  mfp-Insurance
//
//  Created by Vittal Pai on 31/01/19.
//  Copyright © 2019 Vittal Pai. All rights reserved.
//

import UIKit
import IBMMobileFirstPlatformFoundation
import IBMMobileFirstPlatformFoundationLiveUpdate

class HomeViewController: UIViewController {
    
    @IBOutlet weak var damageAnalyzerButton: UIButton!
    
    static var path:String = NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true).first!


    override func viewDidLoad() {
        navigationItem.hidesBackButton = true
        super.viewDidLoad()
        
        //hide button by default
        damageAnalyzerButton.isHidden = true
        
        LiveUpdateManager.sharedInstance.obtainConfiguration(useCache: false) { (configuration, error) in
            if (error == nil) {
                if(configuration?.isFeatureEnabled("analyzerFeature") ?? false) {
                    self.damageAnalyzerButton.setTitle(configuration?.getProperty("buttonLabel") ?? "Damage Analyzer", for: .normal)
                    AnalyzerViewController.backgroundColor = configuration?.getProperty("backgroundColor") ?? nil
                    self.damageAnalyzerButton.isHidden = false
                }
            }
        }
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
