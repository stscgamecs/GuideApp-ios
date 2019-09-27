//
//  sceneTestInteractor.swift
//  Guide_app
//
//  Created by Z64me on 26/9/2562 BE.
//  Copyright (c) 2562 Z64me. All rights reserved.
//

import UIKit

protocol sceneTestInteractorInterface {
  func doSomething(request: sceneTest.Something.Request)
  var model: Entity? { get }
}

class sceneTestInteractor: sceneTestInteractorInterface {
  var presenter: sceneTestPresenterInterface!
  var worker: sceneTestWorker?
  var model: Entity?

  // MARK: - Business logic

  func doSomething(request: sceneTest.Something.Request) {
    worker?.doSomeWork { [weak self] in
      if case let Result.success(data) = $0 {
        // If the result was successful, we keep the data so that we can deliver it to another view controller through the router.
        self?.model = data
      }

      // NOTE: Pass the result to the Presenter. This is done by creating a response model with the result from the worker. The response could contain a type like UserResult enum (as declared in the SCB Easy project) with the result as an associated value.
      let response = sceneTest.Something.Response()
      self?.presenter.presentSomething(response: response)
    }
  }
}
