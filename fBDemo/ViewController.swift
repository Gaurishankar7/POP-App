//
//  ViewController.swift
//  fBDemo
//
//  Created by Parvez Shaikh on 18/02/19.
//  Copyright © 2019 Parvez Shaikh. All rights reserved.
//

import UIKit
import FacebookLogin
import FacebookCore

class ViewController: UIViewController,LoginButtonDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
 
        //Default
//        let loginButton = LoginButton(readPermissions: [ .publicProfile, .email ])
//
//        loginButton.center = view.center
//        loginButton.delegate = self
//        view.addSubview(loginButton)
        
        //custom button
        let loginButton = LoginButton(readPermissions: [.publicProfile,.email])
        loginButton.frame = CGRect(x: 20, y: view.frame.height - 190, width: view.frame.width - 40, height: 50)
        loginButton.delegate = self
        view.addSubview(loginButton)
        
        if let accessToken = AccessToken.current {
            getFBUserInfo()
        }
        
        
        
    }
    
    // MARK: get user data
    func getFBUserInfo() {
        let request = GraphRequest(graphPath: "me", parameters: ["fields":"email,name"], accessToken: AccessToken.current, httpMethod: .GET, apiVersion: FacebookCore.GraphAPIVersion.defaultVersion)
        request.start { (response, result) in
            switch result {
            case .success(let value):
                print(value.dictionaryValue)
                print("result is \(result)")
            case .failed(let error):
                print(error)
            }
        }
    }
    // MARK: LoginButtonDelegate method
    func loginButtonDidCompleteLogin(_ loginButton: LoginButton, result: LoginResult) {
        print("logged in")
        self.getFBUserInfo()
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton) {
        print("logged out")
    }

}

