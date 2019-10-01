//
//  TestMobileListPresenter.swift
//  Guide_appTests
//
//  Created by Z64me on 30/9/2562 BE.
//  Copyright © 2562 Z64me. All rights reserved.
//

import XCTest
@testable import Guide_app

class TestMobileListPresenter: XCTestCase {
  var presenter: MobileListPresenter!
    override func setUp() {
        presenter = MobileListPresenter()
    }

    override func tearDown() {
            super.tearDown()
    }
  //Mock ViewController for test presenter
  class MobileListControllerSpy: MobileListViewControllerInterface{
    
     let arrayPhone: Phones = [Mobile(thumbImageURL: "aaaa", brand: "sdsds", rating: 1.1, name: "bbb", phoneDescription: "I am Iron man", id: 1, price: 2.0),Mobile(thumbImageURL: "bbb", brand: "sdsds", rating: 1.1, name: "bbb", phoneDescription: "I am Iron man", id: 1, price: 2.0)]

     let indexSpy:[Int : Bool] = [1:true,2:false,4:true,3:true]
    var displayMobile = false
    var displayAddFavorit = false
    var displaySortPhone = false
    
    func displayMobile(viewModel: MobileList.GetMobile.ViewModel) {
      displayMobile = true
    }
    
    func displayAddFavorite(viewModel: MobileList.AddFavoritMobile.ViewModel) {
      displayAddFavorit = true
    }
    
    func displaySortPhone(viewModel: MobileList.SortMobileList.ViewModelMobile) {
      displaySortPhone = true
    }
    
  }
  //test presenter
  func testPresentPhoneAskViewControllerToMobileDisPlay() {
    //given
    let viewControllerSpy = MobileListControllerSpy()
    presenter.viewController = viewControllerSpy
    //when
    let responseSpy = MobileList.GetMobile.Response(mobile: viewControllerSpy.arrayPhone)
    presenter.presentPhone(response: responseSpy)
    //then
    XCTAssert(viewControllerSpy.displayMobile)
  }
  
  func testPresentAddFavoriteAskViewControllerTodisplayAddFavorit() {
    //given
    let viewControllerSpy = MobileListControllerSpy()
    presenter.viewController = viewControllerSpy
    //when
    let response = MobileList.AddFavoritMobile.Response(checkFavorit: viewControllerSpy.indexSpy)
    presenter.presentAddFavorite(response: response)
    //then
    XCTAssert(viewControllerSpy.displayAddFavorit)
    
  }
  
  func testPresentSortAskViewControllerTodisplaySortPhone() {
    
    //given
    let viewControllerSpy = MobileListControllerSpy()
    presenter.viewController = viewControllerSpy
    //when
    let response = MobileList.SortMobileList.ResponseMobile(mobile: viewControllerSpy.arrayPhone)
    presenter.presentSort(response: response)
    //then
    XCTAssert(viewControllerSpy.displaySortPhone)
    
  }

    

}
