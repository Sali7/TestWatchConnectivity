//
//  ViewController.swift
//  TestWatchConnectivity
//
//  Created by Mohamed Salah Bouabane on 15.11.16.
//  Copyright © 2016 CSTx IT-Professional. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController, WCSessionDelegate {
    
    var session: WCSession!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if(WCSession.isSupported()){
            self.session = WCSession.default()
            self.session.delegate = self
            self.session.activate()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    @IBAction func sendToWatchAction(_ sender: Any) {
        
        if WCSession.isSupported() {
            do {
                
                let rand = Int(arc4random_uniform(6000))
                let dictionary = ["info": "fromiPhone\(rand)"]
                
                self.session = WCSession.default()
                self.session.delegate = self
                self.session.activate()
                try self.session.updateApplicationContext(dictionary)
            
            } catch let error as NSError {
                NSLog("Updating the context failed: " + error.localizedDescription)
            }
        }
    }
    
    
   
    func session(_ session: WCSession,
                 activationDidCompleteWith activationState: WCSessionActivationState,
                 error: Error?){
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
    }
    
    func sessionDidDeactivate(_ session: WCSession){
    }

    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        
        DispatchQueue.main.async {
            self.messageLabel.text = message["info"]! as? String
        }
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        let info = applicationContext["info"] as! String
        
        DispatchQueue.main.async {
            self.messageLabel.text = info
        }
        
    }
}

