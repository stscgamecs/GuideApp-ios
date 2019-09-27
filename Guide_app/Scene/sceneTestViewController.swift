//
//  sceneTestViewController.swift
//  Guide_app
//
//  Created by Z64me on 26/9/2562 BE.
//  Copyright (c) 2562 Z64me. All rights reserved.
//

import UIKit

protocol sceneTestViewControllerInterface: class {
  func displaySomething(viewModel: sceneTest.Something.ViewModel)
}

class sceneTestViewController: UIViewController, sceneTestViewControllerInterface {
  var interactor: sceneTestInteractorInterface!
  var router: sceneTestRouter!

  // MARK: - Object lifecycle

  override func awakeFromNib() {
    super.awakeFromNib()
    configure(viewController: self)
  }

  // MARK: - Configuration

  private func configure(viewController: sceneTestViewController) {
    let router = sceneTestRouter()
    router.viewController = viewController

    let presenter = sceneTestPresenter()
    presenter.viewController = viewController

    let interactor = sceneTestInteractor()
    interactor.presenter = presenter
    interactor.worker = sceneTestWorker(store: sceneTestStore())

    viewController.interactor = interactor
    viewController.router = router
  }

  // MARK: - View lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    doSomethingOnLoad()
  }

  // MARK: - Event handling

  func doSomethingOnLoad() {
    // NOTE: Ask the Interactor to do some work

    let request = sceneTest.Something.Request()
    interactor.doSomething(request: request)
  }

  // MARK: - Display logic

  func displaySomething(viewModel: sceneTest.Something.ViewModel) {
    // NOTE: Display the result from the Presenter

    // nameTextField.text = viewModel.name
  }

  // MARK: - Router

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    router.passDataToNextScene(segue: segue)
  }

  @IBAction func unwindTosceneTestViewController(from segue: UIStoryboardSegue) {
    print("unwind...")
    router.passDataToNextScene(segue: segue)
  }
}
