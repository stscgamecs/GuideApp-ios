//
//  sceneDetailPresenter.swift
//  Guide_app
//
//  Created by Z64me on 16/9/2562 BE.
//  Copyright (c) 2562 Z64me. All rights reserved.
//

import UIKit

protocol MobileListDetailPresenterInterface {
  func presentImagePhone(response: MobileListDetail.GetPhoneDetail.Response)
}

class MobileListDetailPresenter: MobileListDetailPresenterInterface {
  weak var viewController: MobileListDetailViewControllerInterface!
  
  // MARK: - Presentation logic
  
  func presentImagePhone(response: MobileListDetail.GetPhoneDetail.Response) {
    
    
    var myArrayPhoneImage: [String] = []
    for i in 0 ... response.phoneImages.count - 1{
      var urlName = response.phoneImages[i].url
//      if urlName.starts(with: "https://"){
      if urlName.range(of: "https://") == nil && urlName.range(of: "http://") == nil{
        urlName = "https://" + response.phoneImages[i].url
        myArrayPhoneImage.append(urlName)
      }else{
        myArrayPhoneImage.append(urlName)
      }
    }
    
    let viewModel = MobileListDetail.GetPhoneDetail.ViewModel(phoneImages: response.phoneImages, arrayStringImage: myArrayPhoneImage)
    
    viewController.displayMobileImage(viewModel: viewModel)
  }
}
