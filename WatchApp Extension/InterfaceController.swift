//
//  InterfaceController.swift
//  WatchApp Extension
//
//  Created by Maik Koslowski on 15.11.16.
//  Copyright © 2016 CSTx IT-Professional. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate{
    var session:WCSession!
    @IBOutlet var messageLabel: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        
        if(WCSession.isSupported()){
            self.session = WCSession.default()
            self.session.delegate = self
            self.session.activate()
        }

        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func sendMessageToPhone() {
        let reachable =  session.isReachable
        
        //if(WCSession.isSupported()){
        //    session.sendMessage(["b" : "GoodBye"], replyHandler: nil, errorHandler: nil)
        //}
        
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
    
    func session(_ session: WCSession,
                 activationDidCompleteWith activationState: WCSessionActivationState,
                 error: Error?){
        let a = 2
    }

    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        self.messageLabel.setText(message["a"]! as? String)

    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        let movies = applicationContext["movies"]
           
    }
    //private func session(session: WCSession, didReceiveMessage message: [String : AnyObject]) {
    //}
}
