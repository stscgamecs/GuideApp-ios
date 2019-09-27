//
//  GuideRouter.swift
//  Guide_app
//
//  Created by Z64me on 16/9/2562 BE.
//  Copyright (c) 2562 Z64me. All rights reserved.
//

import UIKit

protocol MobileListRouterInput {
  func navigateToSomewhere(sender: Mobile)
}
class MobileListRouter: MobileListRouterInput {
  
  weak var viewController: MobileListViewController!
  
  // MARK: - Navigation
  
  func navigateToSomewhere(sender: Mobile) {
    viewController.performSegue(withIdentifier: "ShowSomewhereScene", sender: sender)
  }
  
  // MARK: - Communication
  
  func passDataToNextScene(segue: UIStoryboardSegue,sender: Any?) {
    if segue.identifier == "ShowSomewhereScene" {
      passDataToSomewhereScene(segue: segue, sender: sender as! Mobile)
    }
  }
  
  func passDataToSomewhereScene(segue: UIStoryboardSegue , sender: Mobile) {
    let mobileViewController = segue.destination as? MobileListDetailViewController
    mobileViewController?.interactor.model = sender
  }
}
