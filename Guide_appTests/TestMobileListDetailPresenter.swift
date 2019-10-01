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
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
  //Mock ViewController Dretail for test presenter
  class MobileListDetailControllerSpy: MobileListDetailViewControllerInterface {
    
    var displayMobileImage = false
    var displayMobileDetail = false
    
    var ImagePhone: ImagePhones = [ImageMobile(mobileID: 1, id: 1, url: "https://")]
    var modelPhone: Mobile = Mobile(thumbImageURL: "http", brand: "aaa", rating: 4.0, name: "bbb", phoneDescription: "erqweq", id: 1, price: 200.0)
    
    func displayMobileImage(viewModel: MobileListDetail.GetPhoneDetail.ViewModel) {
      displayMobileImage = true
    }
    
    func displayMobileDetail(viewModel: MobileListDetail.GetPhone.ViewModel) {
      displayMobileDetail = true
    }
  }
  
  //test presenterDetail file
  func testPresentPhoneAskViewControllerToDisPlayMobileDetail(){
    
    //given
    
    let viewControllerDetailSpy = MobileListDetailControllerSpy()
    presenterDetail.viewController = viewControllerDetailSpy
    //when
    let responseDetailSpy = MobileListDetail.GetPhone.Response(phone: viewControllerDetailSpy.modelPhone)
    presenterDetail.presentPhone(response: responseDetailSpy)
    //then
    XCTAssert(viewControllerDetailSpy.displayMobileDetail)
    
  }
  
  func testPresentImagePhoneAskViewControllerToDisplayMobileImage() {
    //given
    
    let viewControllerDetailSpy = MobileListDetailControllerSpy()
    presenterDetail.viewController = viewControllerDetailSpy
    //when
    let responseDetailSpy = MobileListDetail.GetPhoneDetail.Response(phoneImages: viewControllerDetailSpy.ImagePhone)
    presenterDetail.presentImagePhone(response: responseDetailSpy)
    //then
    XCTAssert(viewControllerDetailSpy.displayMobileImage)
  }

   
}
