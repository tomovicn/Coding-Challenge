//
//  Extensions.swift
//  Symphony
//
//  Created by Nikola Tomovic on 4/27/17.
//  Copyright © 2017 Nikola Tomovic. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

protocol Reusable: class {
    static var reuseIdentifier: String { get }
    static var nib: UINib? { get }
}

extension Reusable {
    static var reuseIdentifier: String { return String(describing: self) }
    static var nib: UINib? { return nil }
}

extension UITableView {
    func registerReusableCell<T: UITableViewCell>(_: T.Type) where T: Reusable {
        if let nib = T.nib {
            self.register(nib, forCellReuseIdentifier: T.reuseIdentifier)
        } else {
            self.register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
        }
    }
    
    func dequeueReusableCell<T: UITableViewCell>(indexPath: IndexPath) -> T where T: Reusable {
        return self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
}

extension UIViewController {
    func showDialog(_ withTitle: String?, message: String, cancelButtonTitle: String? ) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: cancelButtonTitle, style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showNotReachableDialog() {
        let alert = UIAlertController(title: nil, message: "No internet connection", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showProgressHUD() {
        let HUD = MBProgressHUD.showAdded(to: self.view, animated: true)
        HUD.backgroundColor = UIColor.black.withAlphaComponent(0.3)
    }
    
    func hideProgressHUD() {
        MBProgressHUD.hide(for: self.view, animated: true)
    }
}
