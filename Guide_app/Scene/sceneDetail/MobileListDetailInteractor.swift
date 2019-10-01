//
//  sceneDetailInteractor.swift
//  Guide_app
//
//  Created by Z64me on 16/9/2562 BE.
//  Copyright (c) 2562 Z64me. All rights reserved.
//

import UIKit

protocol MobileListDetailInteractorInterface {
  func getImagePhone(request: MobileListDetail.GetPhoneDetail.Request)
  func getDataPhone(request: MobileListDetail.GetPhone.Request)
  var model: Mobile? {get set}
}

class MobileListDetailInteractor: MobileListDetailInteractorInterface {
  
  var model: Mobile?
  var presenter: MobileListDetailPresenterInterface!
  var worker: MobileListDetailWorker?
  var modelImage: ImagePhones? = []
  
  // MARK: - Business logic
  func getImagePhone(request: MobileListDetail.GetPhoneDetail.Request) {
    
    worker?.getMobile(sent: (model?.id)!) {  [weak self ] in
      if case let Result.success(data) = $0 {
        let dataImage = data
        self?.modelImage = dataImage
        let respones = MobileListDetail.GetPhoneDetail.Response(phoneImages: dataImage)
        self?.presenter.presentImagePhone(response: respones)
      }
      else {
        print(ApiError.networkError)
        
      }
    }
    
  }
  
  func getDataPhone(request: MobileListDetail.GetPhone.Request) {
    
    guard let modelPhone = model else{
      return
    }
    
    let respones = MobileListDetail.GetPhone.Response(phone: modelPhone)
    self.presenter.presentPhone(response: respones)
  }
}
