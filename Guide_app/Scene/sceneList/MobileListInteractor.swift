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
  func getFavorit(request: MobileList.AddFavoritMobile.Request)
  func getSegment(request: MobileList.GetMobile.Request)
  func getSort(request: MobileList.SortMobileList.RequestMobile)
}
class MobileListInteractor: MobileListInteractorInterface {
  var presenter: MobileListPresenterInterface!
  var worker: MobileListWorker?
  var arrayPhone: Phones = []
  var favoritId: [Int : Bool] = [:]
  var sortStatus: SortingStatus?
  var statusSegment: SegmentStatus?
  
  // MARK: - Business logic
  func getPhones(request: MobileList.GetMobile.Request) {
    worker?.getPhone { [weak self ] in
      if case let Result.success(data) = $0 {
        switch Result<Phones, ApiError> .success(data){
        case .success(let data):
          self?.arrayPhone = data
          let respones = MobileList.GetMobile.Response(mobile: data, checkFavDeleteRes: false)
          self?.presenter.presentPhone(response: respones)
          
        case .failure(_):  break
        }
        
      }
      else{
        return
      }
    }
  }
  
  func getFavorit(request: MobileList.AddFavoritMobile.Request) {
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
  
  var arrayPhoneSuccess: Phones
  {
    var arrayPhoneForSort = arrayPhone
    let segmentType = statusSegment
    
    if segmentType == .favorite {
      let favaIndex = favoritId.compactMap({ (favId) -> Int? in
        if favId.value == true {
          return favId.key
        }
        return nil
      })
      let favPhone = arrayPhone.filter{favaIndex.contains($0.id!)}
      arrayPhoneForSort = favPhone
    }
    else if segmentType == .all{
      arrayPhoneForSort = arrayPhone
    }
    
    if let sortType = sortStatus{
      switch sortType{
      case .priceHighToLow:
        
        arrayPhoneForSort = arrayPhoneForSort.sorted(by: { (data0, data1) -> Bool in
          data0.price ?? 00 > data1.price ?? 00
        })
      case .priceLowToHigh:
        arrayPhoneForSort = arrayPhoneForSort.sorted(by: { (data0, data1) -> Bool in
          data0.price ?? 00 < data1.price ?? 00
        })
      case .rating:
        arrayPhoneForSort = arrayPhoneForSort.sorted(by: { (data0, data1) -> Bool in
          data0.rating ?? 00 > data1.rating ?? 00
        })
      case .defaultMobile:
        break
      }
    }
    return arrayPhoneForSort
    
  }
  
  func getSegment(request: MobileList.GetMobile.Request) {
    let typeSegmentRequest = request.segmentStatus
    statusSegment = typeSegmentRequest
    let respones = MobileList.SortMobileList.ResponseMobile(mobile: arrayPhoneSuccess)
    self.presenter.presentSort(response: respones)
    
  }
  func getSort(request: MobileList.SortMobileList.RequestMobile) {
    let sortTypeRequest = request.sortingStatus
    sortStatus = sortTypeRequest
    if sortTypeRequest == .priceHighToLow{
      let respones = MobileList.SortMobileList.ResponseMobile(mobile: arrayPhoneSuccess)
      self.presenter.presentSort(response: respones)
    }
    if sortTypeRequest == .priceLowToHigh{
      let respones = MobileList.SortMobileList.ResponseMobile(mobile: arrayPhoneSuccess)
      self.presenter.presentSort(response: respones)
    }
    if sortTypeRequest == .rating{
      let respones = MobileList.SortMobileList.ResponseMobile(mobile: arrayPhoneSuccess)
      self.presenter.presentSort(response: respones)
    }
  }
  
  
  
  
}
