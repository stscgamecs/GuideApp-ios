//
//  gWorker.swift
//  Guide_app
//
//  Created by Z64me on 27/9/2562 BE.
//  Copyright (c) 2562 Z64me. All rights reserved.
//

import UIKit

protocol gStoreProtocol {
  func getData(_ completion: @escaping (Result<Entity>) -> Void)
}

class gWorker {

  var store: gStoreProtocol

  init(store: gStoreProtocol) {
    self.store = store
  }

  // MARK: - Business Logic

  func doSomeWork(_ completion: @escaping (Result<Entity>) -> Void) {
    // NOTE: Do the work
    store.getData {
      // The worker may perform some small business logic before returning the result to the Interactor
      completion($0)
    }
  }
}
