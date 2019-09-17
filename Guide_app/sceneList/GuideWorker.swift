////
////  GuideWorker.swift
////  Guide_app
////
////  Created by Z64me on 16/9/2562 BE.
////  Copyright (c) 2562 Z64me. All rights reserved.
////
//
//import UIKit
//
//protocol GuideStoreProtocol {
//  func getData(_ completion: @escaping (Result<phone>) -> Void)
//}
//
//class GuideWorker {
//
//  var store: GuideStoreProtocol
//
//  init(store: GuideStoreProtocol) {
//    self.store = store
//  }
//
//  // MARK: - Business Logic
//
//  func doSomeWork(_ completion: @escaping (Result<phone>) -> Void) {
//    // NOTE: Do the work
//    store.getData {
//      // The worker may perform some small business logic before returning the result to the Interactor
//      completion($0)
//    }
//  }
//}
