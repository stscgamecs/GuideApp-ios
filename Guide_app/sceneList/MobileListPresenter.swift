//
//  GuidePresenter.swift
//  Guide_app
//
//  Created by Z64me on 16/9/2562 BE.
//  Copyright (c) 2562 Z64me. All rights reserved.
//

import UIKit

protocol MobileListPresenterInterface {
  func presentSomething(response: MobileList.Something.Response)
}

class MobileListPresenter: MobileListPresenterInterface {
  weak var viewController: MobileListViewControllerInterface!

  // MARK: - Presentation logic

  func presentSomething(response: MobileList.Something.Response) {
    
    let viewModel = MobileList.Something.ViewModel(mobile: response.mobile)
    viewController.mobileDisplay(viewModel: viewModel)
  }
}
