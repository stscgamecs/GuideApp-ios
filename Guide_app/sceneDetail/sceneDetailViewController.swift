//
//  sceneDetailViewController.swift
//  Guide_app
//
//  Created by Z64me on 16/9/2562 BE.
//  Copyright (c) 2562 Z64me. All rights reserved.
//

import UIKit

protocol sceneDetailViewControllerInterface: class {
  func displaySomething(viewModel: sceneDetail.Something.ViewModel)
}

class sceneDetailViewController: UIViewController, sceneDetailViewControllerInterface {
  var interactor: sceneDetailInteractorInterface!
  var router: sceneDetailRouter!

  // MARK: - Object lifecycle

  override func awakeFromNib() {
    super.awakeFromNib()
    configure(viewController: self)
  }

  // MARK: - Configuration

  private func configure(viewController: sceneDetailViewController) {
    let router = sceneDetailRouter()
    router.viewController = viewController

    let presenter = sceneDetailPresenter()
    presenter.viewController = viewController

    let interactor = sceneDetailInteractor()
    interactor.presenter = presenter
    interactor.worker = sceneDetailWorker(store: sceneDetailStore())

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

    let request = sceneDetail.Something.Request()
    interactor.doSomething(request: request)
  }

  // MARK: - Display logic

  func displaySomething(viewModel: sceneDetail.Something.ViewModel) {
    // NOTE: Display the result from the Presenter

    // nameTextField.text = viewModel.name
  }

  // MARK: - Router

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    router.passDataToNextScene(segue: segue)
  }

  @IBAction func unwindTosceneDetailViewController(from segue: UIStoryboardSegue) {
    print("unwind...")
    router.passDataToNextScene(segue: segue)
  }
}
