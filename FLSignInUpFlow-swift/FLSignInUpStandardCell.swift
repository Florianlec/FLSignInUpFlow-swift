//
//  FLSignInUpStandardCell.swift
//  FLSignInUpFlow-swift
//
//  Created by Florian Lecluse on 6/12/17.
//  Copyright © 2017 Florian Lecluse. All rights reserved.
//

import UIKit

class FLSignInUpStandardCell: FLSignInUpAbstractCell {
    //MARK: -
    //MARK: - Attributes
    //MARK: -
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    var textFieldStr: String = ""
    var containerView : UIView?
    //MARK: -
    //MARK: - Publics Methods
    //MARK: -
    override func performWithItem(_ item: FLSignInUpViewItem) {
        self.item = item
        self.titleLabel.text = self.item?.title
        self.titleLabel.font = UIFont(name: (self.titleLabel!.font?.fontName)!, size: UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline).pointSize)
        self.textField.text = self.item?.value
        self.textField.delegate = self
        self.textField.autocorrectionType = UITextAutocorrectionType.no
        self.textField.placeholder = self.item?.detailTitle
        self.textField.isSecureTextEntry = self.item?.key == FLSignInUpViewModelConstants.password ? true : false
        self.textField.clearButtonMode = self.item?.key == FLSignInUpViewModelConstants.password ? UITextFieldViewMode.never : UITextFieldViewMode.whileEditing
        self.textField.font = UIFont(name: (self.textField!.font?.fontName)!, size: UIFont.preferredFont(forTextStyle: UIFontTextStyle.headline).pointSize)
        if FLSignInUpViewModel.sharedInstance.isSignUp == false  {
            self.textField.returnKeyType = self.item?.key == FLSignInUpViewModelConstants.password ? UIReturnKeyType.go : UIReturnKeyType.next
        } else {
            self.textField.returnKeyType = self.item?.key == FLSignInUpViewModelConstants.lastName ? UIReturnKeyType.go : UIReturnKeyType.next
        }
        self.textField.textColor = UIColor.black
        self.p_dealWithErrorView()
    }
    override func textFieldBecomeFirstResponder() {
        self.textField.becomeFirstResponder()
    }
    //MARK: -
    //MARK: - Private Methods
    //MARK: -
    fileprivate func p_configureErrorView(_ message:String) {
        if self.errorView == nil {
            
        }
        let signInUpErrorViewController = UIViewController().signUpErrorViewController()
        self.errorView = signInUpErrorViewController.view as? FLSignInUpAccessoryView
        self.errorView?.frame = CGRect(x: 0, y: 0, width: self.bounds.size.width, height: 30)
        self.errorView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.errorView?.errorLabel.text = message
        self.textField.inputAccessoryView = self.errorView
    }
    fileprivate func p_removeErrorView() {
        self.textField.inputAccessoryView = nil
        self.errorView?.removeFromSuperview()
    }
    fileprivate func p_dealWithErrorView() {
        if self.item?.error != nil && (self.item?.error.characters.count)! > 0 {
            self.textField.textColor = self.p_errorColor()
            self.p_configureErrorView((self.item?.error)!)
        } else {
            self.p_removeErrorView()
        }
    }
    fileprivate func p_errorColor() -> UIColor {
        return UIColor(red: 245/255, green: 0/255, blue: 87/255, alpha: 1)
    }
}
//MARK: -
//MARK: - UITextFieldDelegate Methods
//MARK: -
extension FLSignInUpStandardCell : UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.textFieldStr = textField.text!
        if self.textFieldStr == "" {
            FLSignInUpViewModel.sharedInstance.errors[(self.item?.key)!] = ""
        }
        FLSignInUpViewModel.sharedInstance.params[(self.item?.key)!] = self.textFieldStr
        self.p_removeErrorView()
        if self.item?.key == FLSignInUpViewModelConstants.email {
            FLSignInUpViewModel.sharedInstance.checkEmail { (isValid, errorMessage, item) in
                self.item = item
                self.textField.textColor = isValid ? UIColor.black : self.p_errorColor()
            }
        } else if self.item?.key == FLSignInUpViewModelConstants.password {
            FLSignInUpViewModel.sharedInstance.checkPassword({ (isValid, errorMessage, item) in
                self.item = item
                self.textField.textColor = isValid ? UIColor.black : self.p_errorColor()
            })
        }
        
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.textFieldStr = textField.text!
        self.textField.textColor = UIColor.black
        self.p_dealWithErrorView()
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        self.textField.textColor = UIColor.black
        self.p_removeErrorView()
        let newString = String((textField.text! as NSString).replacingCharacters(in: range, with: string))
        self.textFieldStr = newString!
        FLSignInUpViewModel.sharedInstance.params[(self.item?.key)!] = newString
        return true
    }
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return true
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        self.p_removeErrorView()
        self.textFieldStr = ""
        FLSignInUpViewModel.sharedInstance.params[(self.item?.key)!] = ""
        FLSignInUpViewModel.sharedInstance.errors[(self.item?.key)!] = ""
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.returnKeyType == UIReturnKeyType.go {
            if FLSignInUpViewModel.sharedInstance.isSignUp {
                FLSignInUpViewModel.sharedInstance.signup()
            } else {
                FLSignInUpViewModel.sharedInstance.login()
            }
        } else {
            self.delegate?.nextTouchUpInside(indexPath: self.indexPath)
        }
        return true
    }
}
