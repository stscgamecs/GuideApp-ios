//
//  sceneDetailPresenter.swift
//  Guide_app
//
//  Created by Z64me on 16/9/2562 BE.
//  Copyright (c) 2562 Z64me. All rights reserved.
//

import UIKit

protocol MobileListDetailPresenterInterface {
  func presentPhone(response: MobileListDetail.GetPhone.Response)
  func presentImagePhone(response: MobileListDetail.GetPhoneDetail.Response)
  
}

class MobileListDetailPresenter: MobileListDetailPresenterInterface {
  weak var viewController: MobileListDetailViewControllerInterface!
  
  // MARK: - Presentation logic
  func presentPhone(response: MobileListDetail.GetPhone.Response) {
    let price = "$\(response.phone.price ?? 0)"
    let rating = "\(response.phone.rating ?? 0)"
    let discription = response.phone.phoneDescription
    let viewModel = MobileListDetail.GetPhone.ViewModel(price: price, rating: rating, Discription: discription!)
    viewController.displayMobileDetail(viewModel: viewModel)
  }
  
  func presentImagePhone(response: MobileListDetail.GetPhoneDetail.Response) {
    var myArrayPhoneImage: [String] = []
    for i in 0 ... response.phoneImages.count - 1 {
      var urlName = response.phoneImages[i].url
      if urlName.range(of: "https://") == nil && urlName.range(of: "http://") == nil {
        urlName = "https://" + response.phoneImages[i].url
        myArrayPhoneImage.append(urlName)
      }else {
        myArrayPhoneImage.append(urlName)
      }
    }
    
    let viewModel = MobileListDetail.GetPhoneDetail.ViewModel(phoneImages: response.phoneImages, arrayStringImage: myArrayPhoneImage)
    viewController.displayMobileImage(viewModel: viewModel)
  }
}
