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
}

class MobileListDetailInteractor: MobileListDetailInteractorInterface {
  var presenter: MobileListDetailPresenterInterface!
  var worker: MobileListDetailWorker?
  var model: ImagePhone = []
  
  // MARK: - Business logic
  func getImagePhone(request: MobileListDetail.GetPhoneDetail.Request) {
    worker?.getMobile(sent: request.indexCell) {  [weak self ] in
      if case let Result.success(data) = $0 {
        switch Result<ImagePhone, ApiError>.success(data){
        case .success(let dataImage):
          self?.model = dataImage
          let respones = MobileListDetail.GetPhoneDetail.Response(phoneImage: dataImage)
          self?.presenter.presentImagePhone(response: respones)
        case .failure(_): print("Error")
        }
      }
      else{
        return
      }
    }
  }
  
}
