//
//  FLSignInUpViewController.swift
//  FLSignInUpFlow-swift
//
//  Created by Florian Lecluse on 6/12/17.
//  Copyright © 2017 Florian Lecluse. All rights reserved.
//

import UIKit
//MARK: -
//MARK: - Constants
//MARK: -
struct FLSignInUpViewControllerConstants {
    static let reloadItemsNotification = "SignInUpReloadItems"
}
//MARK: -
//MARK: - Localized String Constants
//MARK: -
struct FLSignInUpViewControllerLocalizedStringConstants {
    static let createAccount = NSLocalizedString("Create an account", comment: "")
    static let signUpSegue = "signupSegue"
}
//MARK: -
//MARK: - FLSignInUpViewController Class
//MARK: -
class FLSignInUpViewController: FLTableViewController {
    //MARK: -
    //MARK: - UIViewController Methods
    //MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        FLSignInUpViewModel.sharedInstance.delegate = self
        self.p_manageTableViewItems()
        self.navigationItem.title = FLSignInUpViewModel.sharedInstance.isSignUp ? FLSignInUpViewControllerLocalizedStringConstants.createAccount : FLSignInUpViewModelLocalizedStringConstants.login
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: FLSignInUpViewControllerConstants.reloadItemsNotification), object:nil)
        FLSignInUpViewModel.sharedInstance.resetAttributes()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(FLSignInUpViewController.p_manageTableViewItems), name: NSNotification.Name(rawValue: FLSignInUpViewControllerConstants.reloadItemsNotification), object: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    //MARK: -
    //MARK: - Private Methods
    //MARK: -
    override internal func p_manageTableViewItems() {
        FLSignInUpViewModel.sharedInstance.itemsBySections { (sections : [String : [FLSignInUpViewItem]]) in
            self.tableView.reloadData()
        }
    }
}
//MARK: -
//MARK: - UITableViewDelegate Methods
//MARK: -
extension FLSignInUpViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nil
    }
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return nil
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.tableView.deselectRow(at: indexPath, animated: true)
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return nil
    }
}
//MARK: -
//MARK: - UITableViewDataSource Methods
//MARK: -
extension FLSignInUpViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (FLSignInUpViewModel.sharedInstance.sections[String(section)]?.count)!
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return FLSignInUpViewModel.sharedInstance.sections.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = FLSignInUpViewModel.sharedInstance.sections[String(indexPath.section)]![indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: item.identifier, for: indexPath) as! FLSignInUpAbstractCell
        cell.delegate = self
        cell.indexPath = indexPath
        cell.performWithItem(item)
        return cell
    }
}
//MARK: -
//MARK: - SignInUpAbstractCellProtocol Methods
//MARK: -
extension FLSignInUpViewController : FLSignInUpAbstractCellProtocol {
    func nextTouchUpInside(indexPath: IndexPath) {
        guard let nextCell = self.tableView.cellForRow(at: IndexPath(row: indexPath.row + 1, section: indexPath.section)) else {
            return
        }
        (nextCell as! FLSignInUpAbstractCell).textFieldBecomeFirstResponder()
    }
}
extension FLSignInUpViewController : FLSignInUpViewModelProtocol {
    func fieldBecomeFirstResponder(indexPath: IndexPath) {
        guard let cell = self.tableView.cellForRow(at: indexPath) else {
            return
        }
        (cell as! FLSignInUpAbstractCell).textFieldBecomeFirstResponder()
    }
}
