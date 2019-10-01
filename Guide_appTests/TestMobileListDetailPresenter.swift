//
//  TestMobileListDetailPresenter.swift
//  Guide_appTests
//
//  Created by Z64me on 30/9/2562 BE.
//  Copyright © 2562 Z64me. All rights reserved.
//

import XCTest
@testable import Guide_app
class TestMobileListDetailPresenter: XCTestCase {
  var presenterDetail: MobileListDetailPresenter!

    override func setUp() {
        presenterDetail = MobileListDetailPresenter()
    }

    override func tearDown() {
      super.tearDown()
    }
  
  class MobileListDetailControllerSpy: MobileListDetailViewControllerInterface {
    
    var displayMobileImage = false
    var displayMobileDetail = false
    var checkUrl = false
   
    var modelPhone: Mobile = Mobile(thumbImageURL: "http", brand: "aaa", rating: 4.0, name: "bbb", phoneDescription: "erqweq", id: 1, price: 200.0)
    
    func displayMobileImage(viewModel: MobileListDetail.GetPhoneDetail.ViewModel) {
      displayMobileImage = true
    }
    
    func displayMobileDetail(viewModel: MobileListDetail.GetPhone.ViewModel) {
      displayMobileDetail = true
    }
  }
  
  func testPresentPhoneAskViewControllerToDisPlayMobileDetail() {
    
    //Given
    let viewControllerDetailSpy = MobileListDetailControllerSpy()
    presenterDetail.viewController = viewControllerDetailSpy

    presenterDetail.viewController.displayMobileDetail(viewModel: MobileListDetail.GetPhone.ViewModel(price: "\(1.0)", rating: "\(1.0)", Discription: "Discription"))
  
    //When
    let responseDetailSpy = MobileListDetail.GetPhone.Response(phone: viewControllerDetailSpy.modelPhone)
    presenterDetail.presentPhone(response: responseDetailSpy)
    
    //Then
    XCTAssert(viewControllerDetailSpy.displayMobileDetail,"Test PresentPhone() ask ViewController to DisPlayMobileDetail()")
  }
  
  
  func testPresentImagePhoneAskViewControllerToDisplayMobileImageAtFormatUrl() {
    
    //Given
    let ImagePhoneSpy: ImagePhones = [ImageMobile(mobileID: 1, id: 1, url: "www")]
    let viewControllerDetailSpy = MobileListDetailControllerSpy()
    
    presenterDetail.viewController = viewControllerDetailSpy
    
    //When
    let responseDetailSpy = MobileListDetail.GetPhoneDetail.Response(phoneImages: ImagePhoneSpy)
    presenterDetail.presentImagePhone(response: responseDetailSpy)
    
    //Then
    XCTAssert(viewControllerDetailSpy.displayMobileImage,"Test PresentImagePhone() ask ViewController to DisplayMobileImage() at format Url")
  }
  func testPresentImagePhoneAskViewControllerToDisplayMobileImageAtNotFormatUrl() {
    
    //Given
    let ImagePhoneSpy: ImagePhones = [ImageMobile(mobileID: 1, id: 1, url: "http://")]
    let viewControllerDetailSpy = MobileListDetailControllerSpy()
    
    presenterDetail.viewController = viewControllerDetailSpy
    
    //When
    let responseDetailSpy = MobileListDetail.GetPhoneDetail.Response(phoneImages: ImagePhoneSpy)
    presenterDetail.presentImagePhone(response: responseDetailSpy)
    
    //then
    XCTAssert(viewControllerDetailSpy.displayMobileImage,"Test PresentImagePhone() ask ViewController to DisplayMobileImage() at not format Url")
  }

   
}
