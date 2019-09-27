//
//  gStore.swift
//  Guide_app
//
//  Created by Z64me on 27/9/2562 BE.
//  Copyright (c) 2562 Z64me. All rights reserved.
//

import Foundation

/*

 The gStore class implements the gStoreProtocol.

 The source for the data could be a database, cache, or a web service.

 You may remove these comments from the file.

 */

class gStore: gStoreProtocol {
  func getData(_ completion: @escaping (Result<Entity>) -> Void) {
    // Simulates an asynchronous background thread that calls back on the main thread after 2 seconds
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
      completion(Result.success(Entity()))
    }
  }
}
