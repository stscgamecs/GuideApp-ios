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
      presentSort = true
      
    }
  }
  
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
  
  func testGetPhoneNotAskPresenPhoneButAskPresenterAddFavoritIsFavorite() {
    
    //Given
    let presenterSpy = MobileListPresenterSpy()
    interactor.presenter = presenterSpy
    
    let idSpy:Int = 1
    let indexSpy:[Int:Bool] = [1:true,2:true,3:false]
    interactor.favoritId = indexSpy
    
    //when
    let requestSpy = MobileList.AddFavoritMobile.Request(indexCell: idSpy)
    interactor.getPhone(request: requestSpy)
    
    //then
    XCTAssertFalse(presenterSpy.presentPhone,"Test getPhone() not Ask PresenPhone()")
    XCTAssert(presenterSpy.presentAddFav,"Test ask PresenterAddFavorite() is Favorite")
    
  }
  
  func testGetPhoneNotAskPresenPhoneButPresenterAddFavoritisNotFavorite () {
    
    //Given
    let presenterSpy = MobileListPresenterSpy()
    interactor.presenter = presenterSpy
    
    let idSpy: Int = 1
    let indexSpy: [Int:Bool] = [ 1 : false, 2 : false, 3 : false ]
    interactor.favoritId = indexSpy
    
    //when
    let requestSpy = MobileList.AddFavoritMobile.Request(indexCell: idSpy)
    interactor.getPhone(request: requestSpy)
    //then
    XCTAssertFalse(presenterSpy.presentPhone,"Test getPhone() not Ask PresenPhone()")
    XCTAssert(presenterSpy.presentAddFav,"Test ask PresenterAddFavorite() is not Favorite")
  }
  
  func testGetSegmentAskPresenterToPresentSortSegmentStatusAll() {
    //Given
    let workerSpy = MobileListWorker(store: MobileListWorkerSpy())
    interactor.worker = workerSpy
    
    let presenterSpy = MobileListPresenterSpy()
    interactor.presenter = presenterSpy
    
    //When
    let requestSpy = MobileList.GetMobile.Request(segmentStatus: .all)
    interactor.getSegment(request: requestSpy)
    
    //Then
    XCTAssert(presenterSpy.presentSort,"Test GetSegment() ask Presenter to PresentSort() SegmentStatus .all")
  }
  
  func testGetSegmentAskPresenterToPresentSortSegmentStatusAllFailure() {
    
    //Given
    let storeSpy = MobileListWorkerSpy()
    storeSpy.checkStateFailure = true
    
    let workerSpy = MobileListWorker(store: storeSpy)
    interactor.worker = workerSpy
    
    let presenterSpy = MobileListPresenterSpy()
    interactor.presenter = presenterSpy
    
    //When
    let requestSpy = MobileList.GetMobile.Request(segmentStatus: .all)
    interactor.getSegment(request: requestSpy)
    
    //then
    XCTAssert(presenterSpy.presentSort,"Test GetSegment ask presenter to PresentSort SegmentStatus .all is failure")
    
  }
  
  func testGetSegmentAskPresenterToPresentSortSegmentStatusFavoriteisFavorite() {
    
    //Given
    let workerSpy = MobileListWorker(store: MobileListWorkerSpy())
    interactor.worker = workerSpy
    
    let presenterSpy = MobileListPresenterSpy()
    interactor.presenter = presenterSpy
    
    let favIndex: [Int : Bool] = [1 : true, 2 : true, 3 : true]
    interactor.favoritId = favIndex
    
    let favPhoneSpy: [Mobile] = [Mobile(thumbImageURL: "",
                                        brand: "",
                                        rating: 1,
                                        name: "",
                                        phoneDescription: "",
                                        id: 1,
                                        price: 1)]
    interactor.arrayPhone = favPhoneSpy
    
    //When
    let requestSpy = MobileList.GetMobile.Request(segmentStatus: .favorite)
    interactor.getSegment(request: requestSpy)
    
    //Then
    XCTAssert(presenterSpy.presentSort,"Test GetSegment() ask Presenter to PresentSort() SegmentStatus .favorite is favorite")
  }
  
  func testGetSegmentAskPresenterToPresentSortSegmentStatusFavoriteisNotFavorite() {
    
    //Given
    let workerSpy = MobileListWorker(store: MobileListWorkerSpy())
    interactor.worker = workerSpy
    
    let presenterSpy = MobileListPresenterSpy()
    interactor.presenter = presenterSpy
    
    let favIndexSpy: [Int:Bool] = [1:false,2:true,3:true]
    interactor.favoritId = favIndexSpy
    
    let favPhoneSpy: [Mobile] = [Mobile(thumbImageURL: "", brand: "", rating: 1, name: "", phoneDescription: "", id: 1, price: 1)]
    interactor.arrayPhone = favPhoneSpy
    
    //When
    let requestSpy = MobileList.GetMobile.Request(segmentStatus: .favorite)
    interactor.getSegment(request: requestSpy)
    
    //Then
    XCTAssert(presenterSpy.presentSort,"Test GetSegment() ask Presenter to PresentSort() SegmentStatus .favorite is not favorite")
  }
  
  func testGetSortAskPresenterToPresentSortsortingStatusPriceHighToLow() {
    
    //Given
    let workerSpy = MobileListWorker(store: MobileListWorkerSpy())
    interactor.worker = workerSpy
    
    let presenterSpy = MobileListPresenterSpy()
    interactor.presenter = presenterSpy
    
    let arrayPhoneForSortSpy: Phones = [
      Mobile(thumbImageURL: "", brand: "", rating: 1, name: "", phoneDescription: "", id: 1, price: 2.0),
      Mobile(thumbImageURL: "", brand: "", rating: 2, name: "", phoneDescription: "", id: 2, price: 3.0),
      Mobile(thumbImageURL: "", brand: "", rating: 2, name: "", phoneDescription: "", id: 2, price: 1.0)
    ]
    interactor.arrayPhone = arrayPhoneForSortSpy
    
    //When
    let requestSpy = MobileList.SortMobileList.RequestMobile(sortingStatus: .priceHighToLow )
    interactor.getSort(request: requestSpy)
    
    //Then
    XCTAssert(presenterSpy.presentSort,"Test GetSort() ask Presenter to PresentSort() sortingStatus is .priceHighToLow")
  }
  
  func testGetSortAskPresenterToPresentSortsortingStatusPriceLowToHigh() {
    
    //Given
    let workerSpy = MobileListWorker(store: MobileListWorkerSpy())
    interactor.worker = workerSpy
    
    let presenterSpy = MobileListPresenterSpy()
    interactor.presenter = presenterSpy
    
    let arrayPhoneForSortSpy: Phones = [
      Mobile(thumbImageURL: "", brand: "", rating: 1, name: "", phoneDescription: "", id: 1, price: 4.0),
      Mobile(thumbImageURL: "", brand: "", rating: 2, name: "", phoneDescription: "", id: 2, price: 5.0),
      Mobile(thumbImageURL: "", brand: "", rating: 3, name: "", phoneDescription: "", id: 3, price: 2.0)]
    interactor.arrayPhone = arrayPhoneForSortSpy
    
    //When
    let requestSpy = MobileList.SortMobileList.RequestMobile(sortingStatus: .priceLowToHigh)
    interactor.getSort(request: requestSpy)
    
    //Then
    XCTAssert(presenterSpy.presentSort, "Test GetSort() ask Presenter to PresentSort() sortingStatus is .priceLowToHigh ")
  }
  
  func testGetSortAskPresenterToPresentSortsortingStatusRating() {
    
    //Given
    let workerSpy = MobileListWorker(store: MobileListWorkerSpy())
    interactor.worker = workerSpy
    
    var sortSpy = interactor.sortStatus
    sortSpy = .rating
    
    let presenterSpy = MobileListPresenterSpy()
    interactor.presenter = presenterSpy
    
    let arrayPhoneForSortSpy: Phones = [
      Mobile(thumbImageURL: "", brand: "", rating: 5, name: "", phoneDescription: "", id: 1, price: 4.0),
      Mobile(thumbImageURL: "", brand: "", rating: 2, name: "", phoneDescription: "", id: 2, price: 5.0),
      Mobile(thumbImageURL: "", brand: "", rating: 2, name: "", phoneDescription: "", id: 3, price: 3.0)]
    interactor.arrayPhone = arrayPhoneForSortSpy
    
    //When
    let requestSpy = MobileList.SortMobileList.RequestMobile(sortingStatus: sortSpy!)
    interactor.getSort(request: requestSpy)
    
    //Then
    XCTAssert(presenterSpy.presentSort,"getSort() by rating should ask presenter to presentSort()")
  }
}
