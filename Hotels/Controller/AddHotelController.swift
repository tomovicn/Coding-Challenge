//
//  AddHotelController.swift
//  Symphony
//
//  Created by Nikola Tomovic on 4/27/17.
//  Copyright © 2017 Nikola Tomovic. All rights reserved.
//

import UIKit

class AddHotelController: UITableViewController {
    @IBOutlet weak var txtFieldName: UITextField!
    @IBOutlet weak var txtFieldCity: UITextField!
    @IBOutlet weak var txtFieldCountry: UITextField!
    @IBOutlet weak var txtFieldDescription: UITextField!
    @IBOutlet weak var txtFieldPrice: UITextField!
    @IBOutlet weak var txtFieldLocation: UITextField!
    @IBOutlet weak var txtFieldStars: UITextField!

    private var hotel = Hotel()
    var hotelsService: HotelsService!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func addHotelAction(_ sender: Any) {
        view.endEditing(true)
        if checkFields() {
            showProgressHUD()
            hotelsService.addHotel(hotel: hotel, succes: {[weak self] (hotel) in
                self?.hideProgressHUD()
                self?.showDialog("Succes", message: "Dodali ste hotel", cancelButtonTitle: "OK")
                
            }, failure: {[weak self] (error) in
                self?.hideProgressHUD()
                self?.showDialog("", message: error, cancelButtonTitle: "OK")
            })
        }
    }
    
    //Check Fields before add
    func checkFields() -> Bool {
        var errorMessage = "Please fill the field "
        var errorFields = [String]()
        var isFilled = true
        if let name = txtFieldName.text, name != "" {
            hotel.name = name
        } else {
            isFilled = false
            errorFields.append(" name")
        }
        if let city = txtFieldCity.text, city != "" {
            hotel.city = city
        } else {
            isFilled = false
            errorFields.append("city")
        }
        if let country = txtFieldCountry.text, country != "" {
            hotel.country = country
        } else {
            isFilled = false
            errorFields.append("country")
        }
        if let description = txtFieldDescription.text, description != "" {
            hotel.description = description
        } else {
            isFilled = false
            errorFields.append("description")
        }
        if let location = txtFieldLocation.text, location != "" {
            hotel.location = location
        } else {
            isFilled = false
            errorFields.append("location")
        }
        if let price = txtFieldPrice.text, price != "" {
            hotel.price = Double(price)
        } else {
            isFilled = false
            errorFields.append("price")
        }
        if let stars = txtFieldStars.text, stars != "" {
            hotel.stars = Int(stars)
        } else {
            isFilled = false
            errorFields.append("stars")
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

extension AddHotelController {
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
}

extension AddHotelController: UITextFieldDelegate {
    // MARK - TextField
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

