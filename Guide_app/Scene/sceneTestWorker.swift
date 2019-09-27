//
//  sceneTestWorker.swift
//  Guide_app
//
//  Created by Z64me on 26/9/2562 BE.
//  Copyright (c) 2562 Z64me. All rights reserved.
//

import UIKit

protocol sceneTestStoreProtocol {
  func getData(_ completion: @escaping (Result<Entity>) -> Void)
}

class sceneTestWorker {

  var store: sceneTestStoreProtocol

  init(store: sceneTestStoreProtocol) {
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
