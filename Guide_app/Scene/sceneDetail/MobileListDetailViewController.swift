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
  func displayMobileDetail(viewModel: MobileListDetail.GetPhone.ViewModel)
}

class MobileListDetailViewController: UIViewController, MobileListDetailViewControllerInterface {
  
  var interactor: MobileListDetailInteractorInterface!
  var router: MobileListDetailRouter!
  var arrayMobileList: [String] = []
  
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var navText: UINavigationItem!
  @IBOutlet weak var ratingLabel: UILabel!
  @IBOutlet weak var priceLabel: UILabel!
  
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
    setPhone()
    setPhoneDetailImage()
  }
  
  var dataMobile : MobileListDetail.GetPhone.Request!
  
  func displayMobileDetail(viewModel: MobileListDetail.GetPhone.ViewModel) {
    priceLabel.text = viewModel.price
    ratingLabel.text = viewModel.rating
    descriptionLabel.text = viewModel.Discription
  }
  
  // MARK: - Event handling
  func setPhone() {
    let request = MobileListDetail.GetPhone.Request()
    interactor.getDataPhone(request: request)
  }
  
  func setPhoneDetailImage() {
    let request = MobileListDetail.GetPhoneDetail.Request()
    interactor.getImagePhone(request: request)
  }
  
  // MARK: - Display logic
  func displayMobileImage(viewModel: MobileListDetail.GetPhoneDetail.ViewModel) {
    arrayMobileList = viewModel.arrayStringImage
    collectionView.reloadData()
  }
}

extension MobileListDetailViewController:UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return arrayMobileList.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as! MobileListDetailCollectionViewCell
    let urlImage = arrayMobileList[indexPath.row]
    
    cell.setUiCollectionView(classImage: urlImage)
    
    return cell
  }
}
