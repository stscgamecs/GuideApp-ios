//
//  GuidePresenter.swift
//  Guide_app
//
//  Created by Z64me on 16/9/2562 BE.
//  Copyright (c) 2562 Z64me. All rights reserved.
//

import UIKit

protocol MobileListPresenterInterface {
  func presentPhone(response: MobileList.GetMobile.Response)
  func presentAddFavorite(response: MobileList.AddFavoritMobile.Response)
  func presentSort(response: MobileList.SortMobileList.ResponseMobile)
}

class MobileListPresenter: MobileListPresenterInterface {
  
  weak var viewController: MobileListViewControllerInterface!
  
// MARK: - Presentation logic
  func presentPhone(response: MobileList.GetMobile.Response) {
    let viewModel = MobileList.GetMobile.ViewModel(mobile: response.mobile)
    viewController.displayMobile(viewModel: viewModel)
  }
  
  func presentAddFavorite(response: MobileList.AddFavoritMobile.Response) {
    let viewModelFavorite = MobileList.AddFavoritMobile.ViewModel(checkFavorit: response.checkFavorit)
    viewController.displayAddFavorite(viewModel: viewModelFavorite)
  }

  func presentSort(response: MobileList.SortMobileList.ResponseMobile) {
    let viewModelFavorit = MobileList.SortMobileList.ViewModelMobile(mobile: response.mobile)
    viewController.displaySortPhone(viewModel: viewModelFavorit)
  }
  
  
}
