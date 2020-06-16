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
    
    @IBOutlet weak var profileImage: UIImageView!
    
    static var path:String = NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true).first!


    override func viewDidLoad() {
        navigationItem.hidesBackButton = true
        super.viewDidLoad()
        
        //Circular Image
        profileImage.layer.masksToBounds = true
        profileImage.layer.cornerRadius = profileImage.bounds.width / 2

        
        //hide button by default
        damageAnalyzerButton.isHidden = true
        
     LiveUpdateManager.sharedInstance.obtainConfiguration(useCache: false) { (configuration, error) in
            if (error == nil) {
                if(configuration?.isFeatureEnabled("recordsUpdate") ?? false) {
                    self.damageAnalyzerButton.setTitle(configuration?.getProperty("buttonLabel") ?? "Records Update", for: .normal)
                    self.damageAnalyzerButton.isHidden = false
                }
            }
        }
        WLAnalytics.sharedInstance()?.send()
    }

    @IBAction func logout(_ sender: Any) {
                   WLAnalytics.sharedInstance().log("buttonClick", withMetadata    :["buttonClick" : "logout"]);
                   WLAnalytics.sharedInstance()?.send()
        WLAuthorizationManager.sharedInstance()?.logout( UserLoginChallengeHandler.securityCheckName, withCompletionHandler: { (error) in
           self.navigationController?.popViewController(animated: true)
            WLAnalytics.sharedInstance()?.send()
        })
    }
    
    
    @IBAction func getBasicDetails(_ sender: Any) {
        WLAnalytics.sharedInstance().log("buttonClick", withMetadata : ["buttonClick" : "basicDetail"]);
              WLAnalytics.sharedInstance()?.send()
        let request = WLResourceRequest(url: URL(string: "/adapters/EmployeeResourceAdapter/basic"), method: WLHttpMethodGet,scope: "employeeAccess")
               request?.send { (response, error) -> Void in
                   if(error == nil){
                       NSLog((response?.responseText)!)
                    self.showAlert(title: "Basic Details", message: response?.responseText ?? "")
                    WLAnalytics.sharedInstance()?.send()

                   }
                   else{
                       NSLog(error.debugDescription)
                    self.showAlert(title: "Error", message: "Failed to retreive basic details")
                    WLAnalytics.sharedInstance()?.send()
                   }
               }
    }
    
    func showAlert(title: String, message: String) {
        // create the alert
               let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)

               // add an action (button)
               alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))

               // show the alert
               self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func getCompensation(_ sender: Any) {
        WLAnalytics.sharedInstance().log("buttonClick", withMetadata    :["buttonClick" : "compensation"]);
        WLAnalytics.sharedInstance()?.send()
        let request = WLResourceRequest(url: URL(string: "/adapters/EmployeeResourceAdapter/compensation"), method: WLHttpMethodGet, scope: "accessRestricted")
        request?.send { (response, error) -> Void in
            if(error == nil){
                NSLog((response?.responseText)!)
                self.showAlert(title: "Compensation", message: response?.responseText ?? "nil")
                WLAnalytics.sharedInstance()?.send()
            }
            else{
                NSLog(error.debugDescription)
                self.showAlert(title: "Error", message: "Failed to retreive compensation")
                WLAnalytics.sharedInstance()?.send()

            }
        }
    }
    
    
    
    @IBAction func requestFeedback(_ sender: Any) {
        do {
            let error: Error = MyError.customError
            throw error
        } catch  let error {
            print(error.localizedDescription)
            OCLogger.setLevel(OCLogger_DEBUG);
            let logger : OCLogger = OCLogger.getInstanceWithPackage("Fatal Cras1h");
            logger.logFatalWithMessages(message: error.localizedDescription);
                             logger.sendfuc();
        }
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

extension OCLogger {
    //Log methods with no metadata
    
    func logTraceWithMessages(message:String, _ args: CVarArg...) {
        log(withLevel: OCLogger_TRACE, message: message, args:getVaList(args), userInfo:Dictionary<String, String>())
    }
    
    func logFatalWithMessages(message:String, _ args: CVarArg...) {
        log(withLevel: OCLogger_FATAL, message: message, args:getVaList(args), userInfo:Dictionary<String, String>())
    }
    
    @objc func sendfuc(){
        OCLogger.send()
    }
}

public enum MyError: Error {
    case customError
}

extension MyError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .customError:
            return NSLocalizedString("Throwing this error to test.", comment: "Custom generated error")
        }
    }
}
