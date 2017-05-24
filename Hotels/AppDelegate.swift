//
//  AppDelegate.swift
//  Symphony
//
//  Created by Nikola Tomovic on 4/27/17.
//  Copyright © 2017 Nikola Tomovic. All rights reserved.
//

import UIKit
import Swinject
import SwinjectStoryboard

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    // Dependancy Injection
    let container = Container() { container in
        container.register(APIManager.self) {_ in APIManager()}
        container.register(UserService.self) { r in
            UserService(apiManager: r.resolve(APIManager.self)!)
        }
        container.register(HotelsService.self) { r in
            HotelsService(apiManager: r.resolve(APIManager.self)!)
        }
        container.storyboardInitCompleted(RegistrationController.self) { r, c in
            c.userService = r.resolve(UserService.self)!
        }
        container.storyboardInitCompleted(HotelsController.self) { r, c in
            c.hotelsService = r.resolve(HotelsService.self)!
        }
        container.storyboardInitCompleted(AddHotelController.self) { r, c in
            c.hotelsService = r.resolve(HotelsService.self)!
        }
    }
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let window = UIWindow(frame: UIScreen.main.bounds)
        window.makeKeyAndVisible()
        self.window = window
        
        let storyboard = SwinjectStoryboard.create(name: "Main", bundle: nil, container: container)
        
//        UserDefaults.standard.set("fc6de7f1196b776fad0929fd44a5b93eb77aa4c3", forKey: Constants.UserDefaults.token)
        
        if UserDefaults.standard.string(forKey: Constants.UserDefaults.token) == nil {
            window.rootViewController = storyboard.instantiateInitialViewController()
        } else {
            window.rootViewController = storyboard.instantiateViewController(withIdentifier: "TabBarController")
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }


}

