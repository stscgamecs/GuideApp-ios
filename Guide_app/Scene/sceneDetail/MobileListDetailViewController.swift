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
    getPhoneDetail()
  }
  
  // MARK: - Event handling
  var dataMobile :Mobile?
  func getPhoneDetail() {
    
    let request = MobileListDetail.GetPhoneDetail.Request(indexCell: (dataMobile?.id)!)
    interactor.getImagePhone(request: request)
    descriptionLabel.text = dataMobile?.phoneDescription
    navText.title = dataMobile?.name
    
  }
  
  // MARK: - Display logic
  var arrayMobileList: ImagePhone = []
  @IBOutlet weak var descriptionLabel: UILabel!
  @IBOutlet weak var collectionView: UICollectionView!
  @IBOutlet weak var navText: UINavigationItem!
  
  func displayDetail(viewModel: Mobile){
    dataMobile = viewModel
  }
  // NOTE: Display the result from the Presenter
  func displayMobileImage(viewModel: MobileListDetail.GetPhoneDetail.ViewModel) {
    
    arrayMobileList = viewModel.phoneImage
    collectionView.reloadData()
    
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
    cell.setUiCollectionView(classImage: urlImage, classMobile: dataMobile! )
    return cell
  }
  
  
}
extension MobileListDetailViewController:UICollectionViewDelegate{
  
}
