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
  
  var  model: Mobile?
  var presenter: MobileListDetailPresenterInterface!
  var worker: MobileListDetailWorker?
  var modelImage: ImagePhones = []
  
  // MARK: - Business logic
  func getImagePhone(request: MobileListDetail.GetPhoneDetail.Request) {
    worker?.getMobile(sent: (model?.id)!) {  [weak self ] in
      if case let Result.success(data) = $0 {
        switch Result<ImagePhones, ApiError>.success(data){
        case .success(let dataImage):
          self?.modelImage = dataImage
          let respones = MobileListDetail.GetPhoneDetail.Response(phoneImages: dataImage)
          self?.presenter.presentImagePhone(response: respones)
        case .failure(_): break
        }
      }
      else {
        return
      }
    }
  }
  func getDataPhone(request: MobileListDetail.GetPhone.Request) {
    let respones = MobileListDetail.GetPhone.Response(phone: model!)
    self.presenter.presentPhone(response: respones)
  }
}
