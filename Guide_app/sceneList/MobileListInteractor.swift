//
//  GuideInteractor.swift
//  Guide_app
//
//  Created by Z64me on 16/9/2562 BE.
//  Copyright (c) 2562 Z64me. All rights reserved.
//

import UIKit

protocol MobileListInteractorInterface {
  func getPhones(request: MobileList.Something.Request)
  var model: Phone? { get }
}

class MobileListInteractor: MobileListInteractorInterface {
   
    
  var presenter: MobileListPresenterInterface!
  var worker: MobileListWorker?
  var model: Phone? = []

  // MARK: - Business logic
    func getPhones(request: MobileList.Something.Request) {
        worker?.getPhone { [weak self ] in
            if case let Result.success(data) = $0 {
                switch Result<Phone, ApiError>.success(data){
                
                case .success(let data):
                  let respones = MobileList.Something.Response(mobile: data)
                    self?.presenter.presentSomething(response: respones)
                    
                case .failure(_): print("Error")
                }
            }
            else{
              return
          }
          
      }
    }
}
