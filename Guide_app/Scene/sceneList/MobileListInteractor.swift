//
//  GuideInteractor.swift
//  Guide_app
//
//  Created by Z64me on 16/9/2562 BE.
//  Copyright (c) 2562 Z64me. All rights reserved.
//

import UIKit

protocol MobileListInteractorInterface {
  func getPhones(request: MobileList.GetMobile.Request)
  func addFavorit(request: MobileList.AddFavoritMobile.Request)
  func favSegment(request: MobileList.GetMobile.Request)
}

class MobileListInteractor: MobileListInteractorInterface {
  var presenter: MobileListPresenterInterface!
  var worker: MobileListWorker?
  var phoneData: Phone = []
  var favoritId: [Int : Bool] = [:]
  // MARK: - Business logic
  func getPhones(request: MobileList.GetMobile.Request) {
    worker?.getPhone { [weak self ] in
      if case let Result.success(data) = $0 {
        switch Result<Phone, ApiError>.success(data){
        case .success(let data):
          self?.phoneData = data
          let respones = MobileList.GetMobile.Response(mobile: data)
          self?.presenter.presentPhone(response: respones)
          
        case .failure(_): print("Error")
        }
      }
      else{
        return
      }
      
    }
  }
  
  func addFavorit(request: MobileList.AddFavoritMobile.Request) {
    let id: Int = request.indexCell
    
    let index = favoritId.filter({ (fav) -> Bool in
      if fav.value == true{
        return true
      }
      return false
    })
    
    if index.firstIndex(where: {$0.key == id}) != nil{
      
      favoritId.updateValue(false, forKey: id)
      
    }else{
      favoritId.updateValue(true, forKey: id)
      
    }
    
    let respones = MobileList.AddFavoritMobile.Response(checkFavorit: favoritId)
    self.presenter.presentAddFavorit(response: respones)
    
  }
  
  func favSegment(request: MobileList.GetMobile.Request) {
    
    let isFavorite = request.checkFav
    let favaIndex = favoritId.compactMap({ (favId) -> Int? in
      if favId.value == true {
        return favId.key
       
      }
      return nil
    })
   
    if isFavorite{
      let favPhone = phoneData.filter{favaIndex.contains($0.id!)}
      let respones = MobileList.GetMobile.Response(mobile: favPhone)
      self.presenter.presentPhone(response: respones)
    }
  }
  
}
