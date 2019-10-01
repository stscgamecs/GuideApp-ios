//
//  Guide_appTests.swift
//  Guide_appTests
//
//  Created by Z64me on 16/9/2562 BE.
//  Copyright © 2562 Z64me. All rights reserved.
//

import XCTest
@testable import Guide_app

class TestMobileListInteractor: XCTestCase {
  
  var interactor: MobileListInteractor!
  var service: MobileListStore!
  
  func setUpMobileList() {
    interactor = MobileListInteractor()
    service = MobileListStore()
  }
  
  override func setUp() {
    super.setUp()
    setUpMobileList()
  }
  
  override class func tearDown() {
    super.tearDown()
  }
  
  //Mock Presenter for test interactor
  class MobileListPresenterSpy: MobileListPresenterInterface {
    
    var presentPhone = false
    var presentAddFav = false
    var presentSort = false
    
    func presentPhone(response: MobileList.GetMobile.Response) {
      presentPhone = true
    }
    
    func presentAddFavorite(response: MobileList.AddFavoritMobile.Response) {
      presentAddFav = true
    }
    
    func presentSort(response: MobileList.SortMobileList.ResponseMobile) {
      // Mobile ????
      presentSort = true
    }
  }
  
  //Mock Presenter for test Worker
  class MobileListWorkerSpy: MobileListStoreProtocol {
    var checkStateFailure:Bool = false
    func getPhone(_ completion: @escaping (Result<Phones, ApiError>) -> Void) {
      if checkStateFailure == false{
        completion(Result.success([]))
      }else{
        completion(Result.failure(ApiError.jsonError))
      }
    }
  }
  
  //test Interacter file
  func testGetPhoneAskPresenterToPresenterAddFavorit() {
    //given
    
    let presenterSpy = MobileListPresenterSpy()
    interactor.presenter = presenterSpy
    let idSpy:Int = 1
    let indexSpy:[Int:Bool] = [1:true,2:true,3:false]
    interactor.favoritId = indexSpy
    
    //when
    let requestSpy = MobileList.AddFavoritMobile.Request(indexCell: idSpy)
    interactor.getPhone(request: requestSpy)
    
    //then
    XCTAssert(presenterSpy.presentAddFav)
    
  }
  func testGetPhoneWithFailureShouldAskPresenterToPresenterAddFavorit () {
    
    
    //given
    let presenterSpy = MobileListPresenterSpy()
    interactor.presenter = presenterSpy
    let idSpy:Int = 1
    let indexSpy:[Int:Bool] = [1:false,2:false,3:false]
    interactor.favoritId = indexSpy
    
    //when
    let requestSpy = MobileList.AddFavoritMobile.Request(indexCell: idSpy)
    interactor.getPhone(request: requestSpy)
    
    //then
    XCTAssert(presenterSpy.presentAddFav)
    
  }
  
  func testGetSegmentAskPresenterToPresentSortSegmentStatusAll() {
    //given
    let worker = MobileListWorker(store: MobileListWorkerSpy())
    interactor.worker = worker
    
    let presenterSpy = MobileListPresenterSpy()
    interactor.presenter = presenterSpy
    
    //when
    let requestSpy = MobileList.GetMobile.Request(segmentStatus: .all)
    interactor.getSegment(request: requestSpy)
    
    //then
    XCTAssert(presenterSpy.presentSort)
    
  }
  
  func testGetSegmentWithFailureSholdAskPresenterToPresentSortSegmentStatusAll() {
    //given
    let failure = MobileListWorkerSpy()
    failure.checkStateFailure = true
    let workerSpy = MobileListWorker(store: failure)
    interactor.worker = workerSpy
    
    let presenterSpy = MobileListPresenterSpy()
    interactor.presenter = presenterSpy
    
    let sortStatusSpy: SortingStatus = .priceHighToLow
    interactor.sortStatus = sortStatusSpy
    
    //when
    let requestSpy = MobileList.GetMobile.Request(segmentStatus: .all)
    interactor.getSegment(request: requestSpy)
    
    //then
    XCTAssert(presenterSpy.presentSort)
  }
  
  
  func testGetSegmentAskPresenterToPresentSortSegmentStatusFavorite() {
    //given
    let worker = MobileListWorker(store: MobileListWorkerSpy())
    interactor.worker = worker
    
    let presenterSpy = MobileListPresenterSpy()
    interactor.presenter = presenterSpy
    let favIndex:[Int:Bool] = [1:true,2:true,3:true]
    interactor.favoritId = favIndex
    let favPhoneSpy:[Mobile] = [Mobile(thumbImageURL: "", brand: "", rating: 1, name: "", phoneDescription: "", id: 1, price: 1)]
    interactor.arrayPhone = favPhoneSpy
    //when
    let requestSpy = MobileList.GetMobile.Request(segmentStatus: .favorite)
    interactor.getSegment(request: requestSpy)
    
    //then
    XCTAssert(presenterSpy.presentSort)
  }
  
  func testGetSegmentAskPresenterToPresentSortSegmentStatusFavoriteFailure() {
    //given
    let worker = MobileListWorker(store: MobileListWorkerSpy())
    interactor.worker = worker
    
    let presenterSpy = MobileListPresenterSpy()
    interactor.presenter = presenterSpy
    let favIndex:[Int:Bool] = [1:false,2:true,3:true]
    interactor.favoritId = favIndex
    let favPhoneSpy:[Mobile] = [Mobile(thumbImageURL: "", brand: "", rating: 1, name: "", phoneDescription: "", id: 1, price: 1)]
    interactor.arrayPhone = favPhoneSpy
    //when
    let requestSpy = MobileList.GetMobile.Request(segmentStatus: .favorite)
    interactor.getSegment(request: requestSpy)
    
    //then
    XCTAssert(presenterSpy.presentSort)
  }
  
  
  func testGetSortAskPresenterToPresentSortsortingStatusPriceHighToLow (){
    //given
    let workerSpy = MobileListWorker(store: MobileListWorkerSpy())
    interactor.worker = workerSpy
    
    let presenterSpy = MobileListPresenterSpy()
    interactor.presenter = presenterSpy
    
    let arrayPhoneForSortSpy:Phones = [
      Mobile(thumbImageURL: "", brand: "", rating: 1, name: "", phoneDescription: "", id: 1, price: 2.0),
      Mobile(thumbImageURL: "", brand: "", rating: 2, name: "", phoneDescription: "", id: 2, price: 3.0),
      Mobile(thumbImageURL: "", brand: "", rating: 2, name: "", phoneDescription: "", id: 2, price: 1.0)
    ]
    interactor.arrayPhone = arrayPhoneForSortSpy
    
    //when
    let requestSpy = MobileList.SortMobileList.RequestMobile(sortingStatus: .priceHighToLow )
    interactor.getSort(request: requestSpy)
    //interactor.sortStatus = .priceHighToLow
    
    //then
    XCTAssert(presenterSpy.presentSort)
    //XCTAssert(presenterSpy.???, [4.0, 3.0, 2.0] , "????????")
  }
  
  func testGetSortAskPresenterToPresentSortsortingStatusPriceLowToHigh (){
    //given
    let workerSpy = MobileListWorker(store: MobileListWorkerSpy())
    interactor.worker = workerSpy
    var sortSpy = interactor.sortStatus
    sortSpy = .priceLowToHigh
    let presenterSpy = MobileListPresenterSpy()
    interactor.presenter = presenterSpy
    let arrayPhoneForSortSpy:Phones = [Mobile(thumbImageURL: "", brand: "", rating: 1, name: "", phoneDescription: "", id: 1, price: 4.0),Mobile(thumbImageURL: "", brand: "", rating: 2, name: "", phoneDescription: "", id: 2, price: 5.0)]
    interactor.arrayPhone = arrayPhoneForSortSpy
    //when
    let requestSpy = MobileList.SortMobileList.RequestMobile(sortingStatus: sortSpy!)
    interactor.getSort(request: requestSpy)
    
    //then
    XCTAssert(presenterSpy.presentSort, "?????")
  }
  
  func testGetSortAskPresenterToPresentSortsortingStatusRating (){
    //given
    let workerSpy = MobileListWorker(store: MobileListWorkerSpy())
    interactor.worker = workerSpy
    var sortSpy = interactor.sortStatus
    sortSpy = .rating
    let presenterSpy = MobileListPresenterSpy()
    interactor.presenter = presenterSpy
    
    let arrayPhoneForSortSpy:Phones = [Mobile(thumbImageURL: "", brand: "", rating: 5, name: "", phoneDescription: "", id: 1, price: 4.0),Mobile(thumbImageURL: "", brand: "", rating: 2, name: "", phoneDescription: "", id: 2, price: 5.0)]
    interactor.arrayPhone = arrayPhoneForSortSpy
    
    //when
    let requestSpy = MobileList.SortMobileList.RequestMobile(sortingStatus: sortSpy!)
    interactor.getSort(request: requestSpy)
    
    //then
    XCTAssert(presenterSpy.presentSort,"getSort() by rating should ask presenter to presentSort()")
  }
}
