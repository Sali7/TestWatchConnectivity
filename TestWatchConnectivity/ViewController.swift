//
//  ViewController.swift
//  TestWatchConnectivity
//
//  Created by Maik Koslowski on 15.11.16.
//  Copyright © 2016 CSTx IT-Professional. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController, WCSessionDelegate {
    
    var session: WCSession!
    @IBOutlet weak var messageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        if(WCSession.isSupported()){
            self.session = WCSession.default()
            self.session.delegate = self
            self.session.activate()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func sendToWatchAction(_ sender: Any) {
        let reachable =  self.session.isReachable
        let paired    =  self.session.isPaired
        
        //self.session.sendMessage(["a":"hello"], replyHandler: nil, errorHandler: { (error) in
        //    let err = error
        //})
        
        if WCSession.isSupported() {
            // 2
            do {
                let dictionary = ["movies": "test"]
                try WCSession.default().updateApplicationContext(dictionary)
            
            } catch let error as NSError {
                NSLog("Updating the context failed: " + error.localizedDescription)
            }
        }
    }
   
    func session(_ session: WCSession,
                 activationDidCompleteWith activationState: WCSessionActivationState,
                 error: Error?){
        let a = 2
    }
    
    func sessionDidBecomeInactive(_ session: WCSession) {
        let a = 2
    }
    
    func sessionDidDeactivate(_ session: WCSession){
        let a = 2
    }

    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        self.messageLabel.text = message["b"]! as? String
    }
    
    func sendPurchasedMoviesToPhone(_ notification:Notification) {
        // 1
        if WCSession.isSupported() {
            // 2
                do {
                    let dictionary = ["movies": "test"]
                    try WCSession.default().updateApplicationContext(dictionary)
                } catch {
                    print("ERROR: \(error)")
                }
        }
    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        let movies = applicationContext["movies"]
            // 3
    
    }
}

