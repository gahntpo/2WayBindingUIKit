//
//  SceneDelegate.swift
//  DataFlowProject
//
//  Created by Karin Prater on 29.03.21.
//

import UIKit
import SwiftUI

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

       // let contentView = ContentView()

        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            let tabView = UITabBarController()
            
            let first = TextViewController(nibName: "TextViewController", bundle: nil)
            first.tabBarItem = .init(title: "text", image: UIImage(systemName: "plus"), selectedImage: nil)
            let second = SliderViewController(nibName: "SliderViewController", bundle: nil)
            second.tabBarItem = .init(title: "slider", image: UIImage(systemName: "bolt"), selectedImage: nil)
            let third = ScrollTestViewController()
            third.tabBarItem = .init(title: "scroll", image: UIImage(systemName: "circle"), selectedImage: nil)
            
            tabView.viewControllers = [first, second, third]
            window.rootViewController = tabView
                //UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
        }
    }




}

