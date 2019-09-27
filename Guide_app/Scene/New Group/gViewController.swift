//
//  gViewController.swift
//  Guide_app
//
//  Created by Z64me on 27/9/2562 BE.
//  Copyright (c) 2562 Z64me. All rights reserved.
//

import UIKit

protocol gViewControllerInterface: class {
  func displaySomething(viewModel: g.Something.ViewModel)
}

class gViewController: UIViewController, gViewControllerInterface {
  var interactor: gInteractorInterface!
  var router: gRouter!

  // MARK: - Object lifecycle

  override func awakeFromNib() {
    super.awakeFromNib()
    configure(viewController: self)
  }

  // MARK: - Configuration

  private func configure(viewController: gViewController) {
    let router = gRouter()
    router.viewController = viewController

    let presenter = gPresenter()
    presenter.viewController = viewController

    let interactor = gInteractor()
    interactor.presenter = presenter
    interactor.worker = gWorker(store: gStore())

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

    let request = g.Something.Request()
    interactor.doSomething(request: request)
  }

  // MARK: - Display logic

  func displaySomething(viewModel: g.Something.ViewModel) {
    // NOTE: Display the result from the Presenter

    // nameTextField.text = viewModel.name
  }

  // MARK: - Router

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    router.passDataToNextScene(segue: segue)
  }

  @IBAction func unwindTogViewController(from segue: UIStoryboardSegue) {
    print("unwind...")
    router.passDataToNextScene(segue: segue)
  }
}
