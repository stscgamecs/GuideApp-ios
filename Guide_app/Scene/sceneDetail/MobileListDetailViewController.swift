//
//  sceneDetailViewController.swift
//  Guide_app
//
//  Created by Z64me on 16/9/2562 BE.
//  Copyright (c) 2562 Z64me. All rights reserved.
//

import UIKit

protocol MobileListDetailViewControllerInterface: class {
  func displayMobileImage(viewModel: MobileListDetail.GetPhoneDetail.ViewModel)
}

class MobileListDetailViewController: UIViewController, MobileListDetailViewControllerInterface {
 
  

  
  var interactor: MobileListDetailInteractorInterface!
  var router: MobileListDetailRouter!
  

  // MARK: - Object lifecycle

  override func awakeFromNib() {
    super.awakeFromNib()
    configure(viewController: self)
  }

  // MARK: - Configuration

  private func configure(viewController: MobileListDetailViewController) {
    let router = MobileListDetailRouter()
    router.viewController = viewController

    let presenter = MobileListDetailPresenter()
    presenter.viewController = viewController

    let interactor = MobileListDetailInteractor()
    interactor.presenter = presenter
    interactor.worker = MobileListDetailWorker(store: MobileListDetailStore())

    viewController.interactor = interactor
    viewController.router = router
  }

  // MARK: - View lifecycle

  override func viewDidLoad() {
    super.viewDidLoad()
    getPhone()
  }

  // MARK: - Event handling

  func getPhone() {
    // NOTE: Ask the Interactor to do some work

   let request = MobileListDetail.GetPhoneDetail.Request()
    interactor.getImagePhone(request: request)
  }

  // MARK: - Display logic

  
  var arrayMobileList: ImagePhone = []
  
  @IBOutlet weak var subtextLabel: UILabel!
  @IBOutlet weak var collectionView: UICollectionView!
  
  func displayMobileImage(viewModel: MobileListDetail.GetPhoneDetail.ViewModel) {
    // NOTE: Display the result from the Presenter
    arrayMobileList = viewModel.phoneImage
    collectionView.reloadData()
    // nameTextField.text = viewModel.name
  }

  // MARK: - Router

}

extension MobileListDetailViewController:UICollectionViewDataSource{
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return arrayMobileList.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! MobileListDetailCollectionViewCell
    let urlImage = arrayMobileList[indexPath.item]
    cell.setUiCollectionView(classImage: urlImage)
    return cell
  }
  
  
}
extension MobileListDetailViewController:UICollectionViewDelegate{
  
}
