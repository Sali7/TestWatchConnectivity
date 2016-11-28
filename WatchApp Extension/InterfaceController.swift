//
//  InterfaceController.swift
//  WatchApp Extension
//
//  Created by Mohamed Salah Bouabane on 15.11.16.
//  Copyright © 2016 CSTx IT-Professional. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class InterfaceController: WKInterfaceController, WCSessionDelegate{
    @IBOutlet var messageLabel: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }
    
    fileprivate let session : WCSession? = WCSession.isSupported() ? WCSession.default() : nil

    override init() {
        super.init()
        
        session?.delegate = self
        session?.activate()
    }
    
    override func willActivate() {
        super.willActivate()
    }
   
    override func didDeactivate() {
        super.didDeactivate()
    }

    @IBAction func sendMessageToPhone() {
        let rand = Int(arc4random_uniform(6000))

        let dictionary = ["info": "infoFromWatch\(rand)"]

        if let session = session, session.isReachable {
            session.sendMessage(dictionary,
                                replyHandler: { replyData in
                                    print(replyData)
            }, errorHandler: { error in
                print(error)
            })
        } else {
            // when the iPhone is not connected via Bluetooth
        }

    }
    
    func session(_ session: WCSession,
                 activationDidCompleteWith activationState: WCSessionActivationState,
                 error: Error?){
    }

    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {

    }
    
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        let info = applicationContext["info"] as! String
        
        DispatchQueue.main.async {
            self.messageLabel.setText(info)
        }
    }
 }
