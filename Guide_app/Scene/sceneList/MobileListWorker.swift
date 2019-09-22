//
//  GuideWorker.swift
//  Guide_app
//
//  Created by Z64me on 16/9/2562 BE.
//  Copyright (c) 2562 Z64me. All rights reserved.
//

import UIKit

protocol MobileListStoreProtocol {
    func getPhone(_ completion: @escaping (Result<Phone,ApiError>) -> Void)
}

class MobileListWorker {

  var store: MobileListStoreProtocol

  init(store: MobileListStoreProtocol) {
    self.store = store
  }

  // MARK: - Business Logic

    func getPhone(_ completion: @escaping (Result<Phone,ApiError>) -> Void) {
        store.getPhone{
          completion($0)
      }
    }
}
