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
  //Mock presenter Dretail for test interactorDetail
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
  
  //Mock PresenterDetail for test Worker
  class MobileListDetailStoreSpy: MobileListDetailStoreProtocol {
    var checkFailure = false
    func getImageMobile(sent numbers: Int, _ completion: @escaping (Result<ImagePhones, ApiError>) -> Void) {
      if checkFailure == false{
        completion(Result.success([]))
      }
      else if checkFailure == true{
        completion(Result.failure(ApiError.networkError))
      }
    }
  }
  //test Interacter Detail file
  func testGetImagePhoneAskPresenterToPresenterImagePhone() {
    
    //given
    let workerDetailSpy = MobileListDetailWorker(store: MobileListDetailStoreSpy())
    
    interactorDetail.worker = workerDetailSpy
    let model = Mobile(thumbImageURL: "", brand: "", rating: 0.0, name: "", phoneDescription: "", id: 1, price: 0.0)
    interactorDetail.model = model
    let phone:ImagePhones = [ImageMobile(mobileID: 1, id: 1, url: "ssss")]
    let presenterDetailSpy = MobileListDetailPresenterSpy()
    interactorDetail.presenter = presenterDetailSpy
    
    
    //when
    let requestDetailSpy = MobileListDetail.GetPhoneDetail.Request()
    interactorDetail.getImagePhone(request: requestDetailSpy)
    
    let responseDetailSpy = MobileListDetail.GetPhoneDetail.Response(phoneImages: phone)
    interactorDetail.presenter.presentImagePhone(response: responseDetailSpy)
    //then
    
    XCTAssert(presenterDetailSpy.presentImagePhone)
  }
  
  func testGetImagePhoneFailureSholdAskPresenterToPresenterImagePhone() {
    // Given
    let store = MobileListDetailStoreSpy()
    store.checkFailure = true
    
    let workerDetailSpy = MobileListDetailWorker(store: store)
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
    XCTAssert(presenterDetailSpy.presentImagePhone)
//    XCTAssert((presenterDetailSpy.mobile?.id != nil))
    
    //let phone:ImagePhones = [ImageMobile(mobileID: 1, id: 1, url: "ssss")]
    //interactorDetail.presenter = presenterDetailSpy
    
    //let responseDetailSpy = MobileListDetail.GetPhoneDetail.Response(phoneImages: phone)
    //interactorDetail.presenter.presentImagePhone(response: responseDetailSpy)
  }
  
  func testGetDataPhoneAskPresenterToPresentPhone() {
    
    //given
    
    let presenterDetailSpy = MobileListDetailPresenterSpy()
    interactorDetail.presenter = presenterDetailSpy
    
    let arrayPhone = Mobile(thumbImageURL: "", brand: "", rating: 1, name: "", phoneDescription: "", id: 1, price: 2)
    interactorDetail.model = arrayPhone
    //when
    let requestDetailSpy = MobileListDetail.GetPhone.Request()
    interactorDetail.getDataPhone(request: requestDetailSpy)
    
    let responseDetailSpy = MobileListDetail.GetPhone.Response(phone: arrayPhone)
    interactorDetail.presenter.presentPhone(response: responseDetailSpy)
    //then
    
    XCTAssert(presenterDetailSpy.presentPhone)
    
  }
  func testGetDataPhoneFailureSholdAskPresenterToPresentPhone() {
    
    //given
    
    let presenterDetailSpy = MobileListDetailPresenterSpy()
    interactorDetail.presenter = presenterDetailSpy
    
    let arrayPhone = Mobile(thumbImageURL: nil, brand: nil, rating: nil, name: nil, phoneDescription: nil, id: nil, price: nil)
    interactorDetail.model = nil
    //when
    let requestDetailSpy = MobileListDetail.GetPhone.Request()
    interactorDetail.getDataPhone(request: requestDetailSpy)
    
    let responseDetailSpy = MobileListDetail.GetPhone.Response(phone: arrayPhone)
    interactorDetail.presenter.presentPhone(response: responseDetailSpy)
    //then
    
    XCTAssert(presenterDetailSpy.presentPhone)
    
  }
}
