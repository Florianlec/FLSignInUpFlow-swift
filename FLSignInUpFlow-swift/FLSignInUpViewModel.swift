//
//  FLSignInUpViewModel.swift
//  FLSignInUpFlow-swift
//
//  Created by Florian Lecluse on 6/12/17.
//  Copyright © 2017 Florian Lecluse. All rights reserved.
//

import UIKit
import SVProgressHUD

typealias Block = ([String : [FLSignInUpViewItem]]) -> Void
typealias FieldValidatorBlock = (Bool, String, FLSignInUpViewItem) -> Void
//MARK: -
//MARK: - FLSignInUpAbstractCellProtocol
//MARK: -
protocol FLSignInUpViewModelProtocol {
    func fieldBecomeFirstResponder(indexPath: IndexPath)
}
//MARK: -
//MARK: - Constants
//MARK: -
struct FLSignInUpViewModelConstants {
    static let email = "email"
    static let password = "password"
    static let firstName = "first_name"
    static let lastName = "last_name"
}
//MARK: -
//MARK: - LocalizedString Constants
//MARK: -
struct FLSignInUpViewModelLocalizedStringConstants {
    static let email = NSLocalizedString("Email", comment: "")
    static let emailExample = NSLocalizedString("example@email.com", comment: "")
    static let password = NSLocalizedString("Password", comment: "")
    static let passwordExample = NSLocalizedString("At least 8 characters", comment: "")
    static let forgorYourPassword = NSLocalizedString("Forgot your password?", comment: "")
    static let login = NSLocalizedString("Login", comment: "")
    static let firstName = NSLocalizedString("First Name", comment: "")
    static let lastName = NSLocalizedString("Last Name", comment: "")
    static let signup = NSLocalizedString("Signup", comment: "")
    static let signupSuccess = NSLocalizedString("Signup Success", comment: "")
    static let loginSuccess = NSLocalizedString("Login Success", comment: "")
    static let invalidEmail = NSLocalizedString("Invalid email address", comment: "")
}
//MARK: -
//MARK: - FLSignInUpViewModel Class
//MARK: -
class FLSignInUpViewModel: NSObject {
    //MARK: -
    //MARK: - Attributes
    //MARK: -
    var delegate : FLSignInUpViewModelProtocol?
    var isSignUp = true
    var sections = [String : [FLSignInUpViewItem]]()
    var params = [String: String]()
    var errors = [String: String]()
    var block : Block?
    //MARK: -
    //MARK: - Singleton Methods
    //MARK: -
    static let sharedInstance = FLSignInUpViewModel()
    fileprivate override init () {
    }
    //MARK: -
    //MARK: - Public Methods
    //MARK: -
    func itemsBySections(_ block: @escaping Block) {
        if self.isSignUp == false {
            self.sections = [
                "0" : [
                    FLSignInUpViewItem.init(
                        identifier: FLSignInUpViewItemConstants.standardCell,
                        title: FLSignInUpViewModelLocalizedStringConstants.email,
                        key: FLSignInUpViewModelConstants.email,
                        value: self.params[FLSignInUpViewModelConstants.email] != nil ? self.params[FLSignInUpViewModelConstants.email]! : "",
                        detailTitle: FLSignInUpViewModelLocalizedStringConstants.emailExample,
                        error: self.errors[FLSignInUpViewModelConstants.email] != nil ? self.errors[FLSignInUpViewModelConstants.email]! : ""),
                    FLSignInUpViewItem.init(
                        identifier: FLSignInUpViewItemConstants.standardCell,
                        title: FLSignInUpViewModelLocalizedStringConstants.password,
                        key: FLSignInUpViewModelConstants.password,
                        value: self.params[FLSignInUpViewModelConstants.password] != nil ? self.params[FLSignInUpViewModelConstants.password]! : "",
                        detailTitle: FLSignInUpViewModelLocalizedStringConstants.passwordExample,
                        error: self.errors[FLSignInUpViewModelConstants.password] != nil ? self.errors[FLSignInUpViewModelConstants.password]! : "")
                ],
                "1" : [
                    FLSignInUpViewItem.init(
                        identifier: FLSignInUpViewItemConstants.buttonCell,
                        title: FLSignInUpViewModelLocalizedStringConstants.forgorYourPassword,
                        key: "",
                        value: "",
                        detailTitle: "",
                        error : "")
                ],
                "2" : [
                    FLSignInUpViewItem.init(
                        identifier: FLSignInUpViewItemConstants.buttonCell,
                        title: FLSignInUpViewModelLocalizedStringConstants.login,
                        key: "",
                        value: "",
                        detailTitle: "",
                        error : "")
                ],
                "3" : [
                    FLSignInUpViewItem.init(
                        identifier: FLSignInUpViewItemConstants.socialCell,
                        title: "",
                        key: "",
                        value: "",
                        detailTitle: "",
                        error : "")
                ]
            ]
        } else {
            self.sections = [
                "0" : [
                    FLSignInUpViewItem.init(
                        identifier: FLSignInUpViewItemConstants.standardCell,
                        title: FLSignInUpViewModelLocalizedStringConstants.email,
                        key: FLSignInUpViewModelConstants.email,
                        value: self.params[FLSignInUpViewModelConstants.email] != nil ? self.params[FLSignInUpViewModelConstants.email]! : "",
                        detailTitle: FLSignInUpViewModelLocalizedStringConstants.emailExample,
                        error: self.errors[FLSignInUpViewModelConstants.email] != nil ? self.errors[FLSignInUpViewModelConstants.email]! : ""),
                    FLSignInUpViewItem.init(
                        identifier: FLSignInUpViewItemConstants.standardCell,
                        title: FLSignInUpViewModelLocalizedStringConstants.password,
                        key: FLSignInUpViewModelConstants.password,
                        value: self.params[FLSignInUpViewModelConstants.password] != nil ? self.params[FLSignInUpViewModelConstants.password]! : "",
                        detailTitle: FLSignInUpViewModelLocalizedStringConstants.passwordExample,
                        error: self.errors[FLSignInUpViewModelConstants.password] != nil ? self.errors[FLSignInUpViewModelConstants.password]! : ""),
                    FLSignInUpViewItem.init(
                        identifier: FLSignInUpViewItemConstants.standardCell,
                        title: FLSignInUpViewModelLocalizedStringConstants.firstName,
                        key: FLSignInUpViewModelConstants.firstName,
                        value: self.params[FLSignInUpViewModelConstants.firstName] != nil ? self.params[FLSignInUpViewModelConstants.firstName]! : "",
                        detailTitle: "",
                        error: self.errors[FLSignInUpViewModelConstants.firstName] != nil ? self.errors[FLSignInUpViewModelConstants.firstName]! : ""),
                    FLSignInUpViewItem.init(
                        identifier: FLSignInUpViewItemConstants.standardCell,
                        title: FLSignInUpViewModelLocalizedStringConstants.lastName,
                        key: FLSignInUpViewModelConstants.lastName,
                        value: self.params[FLSignInUpViewModelConstants.lastName] != nil ? self.params[FLSignInUpViewModelConstants.lastName]! : "",
                        detailTitle: "",
                        error: self.errors[FLSignInUpViewModelConstants.lastName] != nil ? self.errors[FLSignInUpViewModelConstants.lastName]! : ""),
                ],
                "1" : [
                    FLSignInUpViewItem.init(
                        identifier: FLSignInUpViewItemConstants.buttonCell,
                        title: FLSignInUpViewModelLocalizedStringConstants.signup,
                        key: "",
                        value : "",
                        detailTitle: "",
                        error: "")
                ],
                "2" : [
                    FLSignInUpViewItem.init(
                        identifier: FLSignInUpViewItemConstants.socialCell,
                        title: "",
                        key: "",
                        value : "",
                        detailTitle: "",
                        error : "")
                ]
            ]
        }
        self.block = block
        block(self.sections)
    }
    func resetAttributes() {
        self.block = nil
        self.params = [String: String]()
        self.errors = [String: String]()
        self.sections = [String : [FLSignInUpViewItem]]()
    }
    func login() {
        SVProgressHUD.setDefaultMaskType(.gradient)
        SVProgressHUD.showSuccess(withStatus: FLSignInUpViewModelLocalizedStringConstants.loginSuccess)
        NSLog("perform login through the Web API")
    }
    func signup() {
        if self.delegate != nil {
            self.checkEmail { (isValid, errorMessage, item) in
                if isValid == false {
                    self.delegate?.fieldBecomeFirstResponder(indexPath: IndexPath(row: 0, section: 0))
                } else {
                    self.checkPassword { (isValid, errorMessage, item) in
                        if isValid == false {
                            self.delegate?.fieldBecomeFirstResponder(indexPath: IndexPath(row: 1, section: 0))
                        } else {
                            SVProgressHUD.setDefaultMaskType(.gradient)
                            SVProgressHUD.showSuccess(withStatus: FLSignInUpViewModelLocalizedStringConstants.signupSuccess)
                            NSLog("perform sign up through the Web API")
                        }
                    }
                }
            }
        }
    }
    func facebookSSO() {
        SVProgressHUD.setDefaultMaskType(.gradient)
        SVProgressHUD.showSuccess(withStatus: "Facebook SSO")
        NSLog("perform facebook SSO")
    }
    func googleSSO() {
        SVProgressHUD.setDefaultMaskType(.gradient)
        SVProgressHUD.showSuccess(withStatus: "Google SSO")
        NSLog("perform google SSO")
    }
    func forgorPassword() {
        SVProgressHUD.setDefaultMaskType(.gradient)
        SVProgressHUD.showSuccess(withStatus: "Forgot password action")
        NSLog("display forgot password view controller")
    }
    //MARK: -
    //MARK: - FieldValidator Methods
    //MARK: -
    func checkEmail(_ block:@escaping FieldValidatorBlock) {
        guard var email = self.params[FLSignInUpViewModelConstants.email] else { return }
        email = email.trimmingCharacters(in: CharacterSet.whitespaces)
        self.errors[FLSignInUpViewModelConstants.email] = ""
        var errorMessage = ""
        var isValid = true
        if self.isSignUp == true {
            if email.contains("@") {
                if email.isValidEmail() == false {
                    if email.characters.count > 0 {
                        isValid = false
                        errorMessage = FLSignInUpViewModelLocalizedStringConstants.invalidEmail
                        self.errors[FLSignInUpViewModelConstants.email] = errorMessage
                    }
                }
            } else {
                if email.characters.count > 0 {
                    errorMessage = FLSignInUpViewModelLocalizedStringConstants.invalidEmail
                    isValid = false
                    self.errors[FLSignInUpViewModelConstants.email] = errorMessage
                }
            }
        }
        self.p_updateEmailItem()
        block(isValid, errorMessage, (self.sections["0"]?[0])!)
    }
    func checkPassword(_ block:@escaping FieldValidatorBlock) {
        guard let password = self.params[FLSignInUpViewModelConstants.password] else { return }
        self.errors[FLSignInUpViewModelConstants.password] = ""
        var errorMessage = ""
        var isValid = true
        if self.isSignUp == true {
            if password.characters.count > 0 && password.characters.count < 8 {
                isValid = false
                errorMessage = FLSignInUpViewModelLocalizedStringConstants.passwordExample
                self.errors[FLSignInUpViewModelConstants.password] = errorMessage
            }
        }
        self.p_updatePasswordItem()
        block(isValid, errorMessage, (self.sections["0"]?[1])!)
    }
    //MARK: -
    //MARK: - Private Methods
    //MARK: -
    private func p_updateEmailItem() {
        self.sections["0"]?[0] = FLSignInUpViewItem.init(
            identifier: FLSignInUpViewItemConstants.standardCell,
            title: FLSignInUpViewModelLocalizedStringConstants.email,
            key: FLSignInUpViewModelConstants.email,
            value: self.params[FLSignInUpViewModelConstants.email] != nil ? self.params[FLSignInUpViewModelConstants.email]! : "",
            detailTitle: FLSignInUpViewModelLocalizedStringConstants.emailExample,
            error: self.errors[FLSignInUpViewModelConstants.email] != nil ? self.errors[FLSignInUpViewModelConstants.email]! : "")
    }
    private func p_updatePasswordItem() {
        self.sections["0"]?[1] = FLSignInUpViewItem.init(
            identifier: FLSignInUpViewItemConstants.standardCell,
            title: FLSignInUpViewModelLocalizedStringConstants.password,
            key: FLSignInUpViewModelConstants.password,
            value: self.params[FLSignInUpViewModelConstants.password] != nil ? self.params[FLSignInUpViewModelConstants.password]! : "",
            detailTitle: FLSignInUpViewModelLocalizedStringConstants.passwordExample,
            error: self.errors[FLSignInUpViewModelConstants.password] != nil ? self.errors[FLSignInUpViewModelConstants.password]! : "")
    }
}
