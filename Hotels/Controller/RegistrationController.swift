//
//  RegistrationController.swift
//  Symphony
//
//  Created by Nikola Tomovic on 4/27/17.
//  Copyright © 2017 Nikola Tomovic. All rights reserved.
//

import UIKit

class RegistrationController: UITableViewController {

    @IBOutlet weak var txtFieldFirstName: UITextField!
    @IBOutlet weak var txtFieldLastName: UITextField!
    @IBOutlet weak var txtFieldEmail: UITextField!
    @IBOutlet weak var txtFieldUsername: UITextField!
    @IBOutlet weak var txtFieldPassword: UITextField!
    
    var userService: UserService!
    private var user = User()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    //Action
    @IBAction func registerAction(_ sender: Any) {
        if checkFields() {
            register()
        }
    }
    
    func register() {
        showProgressHUD()
        userService.register(user: user, password: txtFieldPassword.text!, succes: { [weak self] (user) in
            self?.hideProgressHUD()
            self?.login()
        }, failure: { [weak self] (error) in
            self?.hideProgressHUD()
            self?.showDialog("Error", message: error, cancelButtonTitle: "OK")
        })
    }
    
    func login() {
        showProgressHUD()
        userService.login(user: user, password: txtFieldPassword.text!, succes: { [weak self] (token) in
            self?.hideProgressHUD()
            self?.performSegue(withIdentifier: Constants.Segue.showHotels, sender: self)
        }, failure: { [weak self] (error) in
            self?.hideProgressHUD()
            self?.showDialog("Error", message: error, cancelButtonTitle: "OK")
        })
    }
    
    
    //Check Fields before register
    func checkFields() -> Bool {
        
        var errorMessage = "Please fill the field "
        var errorFields = [String]()
        var isFilled = true
        if let name = txtFieldFirstName.text, name != "" {
            user.firstName = name
        } else {
            isFilled = false
            errorFields.append("first name")
        }
        if let lastName = txtFieldLastName.text, lastName != "" {
            user.lastName = lastName
        } else {
            isFilled = false
            errorFields.append("last name")
        }
        if let email = txtFieldEmail.text, email != "" {
            user.email = email
        } else {
            isFilled = false
            errorFields.append("email")
        }
        if let username = txtFieldUsername.text, username != "" {
            user.username = username
        } else {
            isFilled = false
            errorFields.append("username")
        }
        if let password = txtFieldPassword.text, password != "" {
            
        } else {
            isFilled = false
            errorFields.append("password")
        }
        
        
        if !isFilled {
            if errorFields.count == 1 {
                errorMessage += errorFields[0]
            } else {
                errorMessage = NSLocalizedString("Please fill the field: ", comment: "") + errorFields.joined(separator: ", ")
            }
            showDialog("", message: errorMessage, cancelButtonTitle: "OK")
        }
        
        return isFilled
        
    }

}

extension RegistrationController {
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
}

extension RegistrationController: UITextFieldDelegate {
    // MARK - TextField
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if textField == txtFieldFirstName {
            txtFieldLastName.becomeFirstResponder()
        }else if textField == txtFieldLastName {
            txtFieldEmail.becomeFirstResponder()
        }else if textField == txtFieldEmail {
            txtFieldUsername.becomeFirstResponder()
        }else if textField == txtFieldUsername {
            txtFieldPassword.becomeFirstResponder()
        }
        return true
    }
}

