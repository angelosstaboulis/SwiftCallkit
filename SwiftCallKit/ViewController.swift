//
//  ViewController.swift
//  SwiftCallKit
//
//  Created by Angelos Staboulis on 4/4/24.
//

import UIKit
import CallKit
class ViewController: UIViewController,CXProviderDelegate {
    let update = CXCallUpdate()
    let config = CallKit.CXProviderConfiguration()
    func providerDidReset(_ provider: CXProvider) {
        
    }
    func provider(_ provider: CXProvider, perform action: CXAnswerCallAction) {
        action.fulfill()
        return
    }
    func provider(_ provider: CXProvider, perform action: CXEndCallAction) {
        action.fail()
        return
    }
    func createCallUpdate(){
        update.remoteHandle = CXHandle(type: .phoneNumber, value: "Family Phone Number")
        update.hasVideo = true
    }
    func createCallConfig(){
           config.includesCallsInRecents = true
           config.supportsVideo = true
    }
    func createCallProvider(){
        let provider = CXProvider(configuration: config)
        provider.setDelegate(self, queue: nil)
        provider.reportNewIncomingCall(with: UUID(), update: update, completion: { error in })
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        createCallUpdate()
        createCallConfig()
        createCallProvider()
       
    }

}

