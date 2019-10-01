//
//  TestMobileListDetailInteractor.swift
//  Guide_appTests
//
//  Created by Z64me on 30/9/2562 BE.
//  Copyright © 2562 Z64me. All rights reserved.
//

import XCTest
@testable import Guide_app
class TestMobileListDetailInteractor: XCTestCase {
  
  var interactorDetail: MobileListDetailInteractor!
  var serviceDetail: MobileListDetailStore!
  
  override func setUp() {
    interactorDetail = MobileListDetailInteractor()
    serviceDetail = MobileListDetailStore()
  }
  
  override func tearDown() {
    super.tearDown()
  }
  
  class MobileListDetailPresenterSpy: MobileListDetailPresenterInterface {
    var presentImagePhone = false
    var presentPhone = false
    var mobile: Mobile?
    
    func presentImagePhone(response: MobileListDetail.GetPhoneDetail.Response) {
      presentImagePhone = true
    }
    
    func presentPhone(response: MobileListDetail.GetPhone.Response) {
      mobile = response.phone
      presentPhone = true
    }
  }
  
  class MobileListDetailStoreSpy: MobileListDetailStoreProtocol {
    var checkFailure = false
    
    func getImageMobile(sent numbers: Int, _ completion: @escaping (Result<ImagePhones, ApiError>) -> Void) {
      if checkFailure == false{
        completion(Result.success([]))
      }
      else if checkFailure == true {
        completion(Result.failure(ApiError.networkError))
      }
    }
  }
  
  func testGetImagePhoneAskPresenterToPresentImagePhone() {
    
    //Given
    let workerDetailSpy = MobileListDetailWorker(store: MobileListDetailStoreSpy())
    interactorDetail.worker = workerDetailSpy
    
    let model = Mobile(thumbImageURL: "", brand: "", rating: 0.0, name: "", phoneDescription: "", id: 1, price: 0.0)
    interactorDetail.model = model
    
    let presenterDetailSpy = MobileListDetailPresenterSpy()
    interactorDetail.presenter = presenterDetailSpy
    
    //When
    let requestDetailSpy = MobileListDetail.GetPhoneDetail.Request()
    interactorDetail.getImagePhone(request: requestDetailSpy)
    
    //Then
    XCTAssert(presenterDetailSpy.presentImagePhone,"Test GetImagePhone() ask Presenter to PresentImagePhone()")
  }
  
  func testGetImagePhoneCaseFailureSholdAskPresenterToPresenterImagePhone() {
    
    //Given
    let workerDetailSpy = MobileListDetailWorker(store: MobileListDetailStoreSpy())
    interactorDetail.worker = workerDetailSpy
    
    let modelSpy = Mobile(thumbImageURL: nil, brand: nil, rating: 0.0, name: "", phoneDescription: "", id: 1, price: 0.0)
    interactorDetail.model = modelSpy
    
    let presenterDetailSpy = MobileListDetailPresenterSpy()
    interactorDetail.presenter = presenterDetailSpy
    
    //When
    let requestDetailSpy = MobileListDetail.GetPhoneDetail.Request()
    interactorDetail.getImagePhone(request: requestDetailSpy)
    
    //Then
    XCTAssert(presenterDetailSpy.presentImagePhone,"Test GetImagePhone() failure shold ask Presenter to PresenterImagePhone()")
    
  }
  
  func testGetImagePhoneFailureSholdNotAskPresenterToPresenterImagePhone() {
    
    //Given
    let storeSpy = MobileListDetailStoreSpy()
    storeSpy.checkFailure = true
    
    let workerDetailSpy = MobileListDetailWorker(store: storeSpy)
    interactorDetail.worker = workerDetailSpy
    
    let model = Mobile(thumbImageURL: "",
                       brand: "",
                       rating: 0.0,
                       name: "",
                       phoneDescription: "",
                       id: 1,
                       price: 0.0)
    interactorDetail.model = model
    
    // When
    let requestDetailSpy = MobileListDetail.GetPhoneDetail.Request()
    interactorDetail.getImagePhone(request: requestDetailSpy)
    
    // Then
    let presenterDetailSpy = MobileListDetailPresenterSpy()
    XCTAssertFalse(presenterDetailSpy.presentImagePhone,"Test GetImagePhone() failure not shold ask Presenter To PresenterImagePhone()")
  }
  
  func testGetDataPhoneAskPresenterToPresentPhone() {
    
    //given
    let presenterDetailSpy = MobileListDetailPresenterSpy()
    interactorDetail.presenter = presenterDetailSpy
    
    let MobileSpy = Mobile(thumbImageURL: "", brand: "", rating: 1, name: "", phoneDescription: "", id: 1, price: 2)
    interactorDetail.model = MobileSpy
    
    //when
    let requestDetailSpy = MobileListDetail.GetPhone.Request()
    interactorDetail.getDataPhone(request: requestDetailSpy)
    
    //then
    
    XCTAssert(presenterDetailSpy.presentPhone,"Test GetDataPhone() ask Presenter to PresentPhone()")
  }
  
  func testGetDataPhoneFailureSholdAskPresenterToPresentPhone() {
    
    //Given
    let presenterDetailSpy = MobileListDetailPresenterSpy()
    interactorDetail.presenter = presenterDetailSpy
    
    interactorDetail.model = nil
    //When
    let requestDetailSpy = MobileListDetail.GetPhone.Request()
    interactorDetail.getDataPhone(request: requestDetailSpy)
    
    //Then
    
    XCTAssertFalse(presenterDetailSpy.presentPhone,"Test GetDataPhone() failure not shold ask Presenter to PresentPhone()")
    
  }
}
