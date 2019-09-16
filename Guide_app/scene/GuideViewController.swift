//
//  GuideViewController.swift
//  Guide_app
//
//  Created by Z64me on 16/9/2562 BE.
//  Copyright (c) 2562 Z64me. All rights reserved.
//

import UIKit

protocol GuideViewControllerInterface: class {
  func displaySomething(viewModel: Guide.Something.ViewModel)
}

class GuideViewController: UIViewController, GuideViewControllerInterface {
  var interactor: GuideInteractorInterface!
  var router: GuideRouter!

  // MARK: - Object lifecycle

  override func awakeFromNib() {
    super.awakeFromNib()
    configure(viewController: self)
  }

  // MARK: - Configuration

  private func configure(viewController: GuideViewController) {
    let router = GuideRouter()
    router.viewController = viewController

    let presenter = GuidePresenter()
    presenter.viewController = viewController

    let interactor = GuideInteractor()
    interactor.presenter = presenter
    interactor.worker = GuideWorker(store: GuideStore())

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

    let request = Guide.Something.Request()
    interactor.doSomething(request: request)
  }

  // MARK: - Display logic

  func displaySomething(viewModel: Guide.Something.ViewModel) {
    // NOTE: Display the result from the Presenter

    // nameTextField.text = viewModel.name
  }

  // MARK: - Router

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    router.passDataToNextScene(segue: segue)
  }

  @IBAction func unwindToGuideViewController(from segue: UIStoryboardSegue) {
    print("unwind...")
    router.passDataToNextScene(segue: segue)
  }
}
