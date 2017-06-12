//
//  FLLoginViewController.swift
//  FLSignInUpFlow-swift
//
//  Created by Florian Lecluse on 6/12/17.
//  Copyright © 2017 Florian Lecluse. All rights reserved.
//

import UIKit
//MARK: -
//MARK: - Constants
//MARK: -
struct FLLoginViewControllerConstants {
    static let loginSegue = "loginSegue"
    static let signUpSegue = "signupSegue"
}
//MARK: -
//MARK: - FLLoginViewController Class
//MARK: -
class FLLoginViewController: UIViewController {
    //MARK: -
    //MARK: - UIViewController Methods
    //MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == FLLoginViewControllerConstants.loginSegue {
            FLSignInUpViewModel.sharedInstance.isSignUp = false
        } else if segue.identifier == FLLoginViewControllerConstants.signUpSegue {
            FLSignInUpViewModel.sharedInstance.isSignUp = true
        }
    }
}
