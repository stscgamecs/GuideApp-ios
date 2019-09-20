//
//  GuideViewController.swift
//  Guide_app
//
//  Created by Z64me on 16/9/2562 BE.
//  Copyright (c) 2562 Z64me. All rights reserved.
//

import UIKit

protocol MobileListViewControllerInterface: class {
  func mobileDisplay(viewModel: MobileList.GetMobile.ViewModel)
  func displayAddFavorit(viewModel: MobileList.AddFavoritMobile.ViewModel)
}

class MobileListViewController: UIViewController,MobileListViewControllerInterface {
  
  var interactor: MobileListInteractorInterface!
  var router: MobileListRouter!
  var modelPhone: Phone = []
  var modelFavoritPhone: [Int: Bool] = [:]
  
  @IBOutlet weak var segMentControl: UISegmentedControl!
  @IBOutlet weak var tableViewControl: UITableView!
  
// MARK: - Object lifecycle
  override func awakeFromNib() {
    super.awakeFromNib()
    configure(viewController: self)
  }
  
// MARK: - Configuration
  private func configure(viewController: MobileListViewController) {
    let router = MobileListRouter()
    router.viewController = viewController
    
    let presenter = MobileListPresenter()
    presenter.viewController = viewController
    
    let interactor = MobileListInteractor()
    interactor.presenter = presenter
    interactor.worker = MobileListWorker(store: MobileListStore())
    
    
    viewController.interactor = interactor
    viewController.router = router
  }
  
// MARK: - View lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    setupCell()
    getPhones(favorite: false)
  }
  
  
  
  func setupCell() {
    let bundle = Bundle(for: MobileListTableViewCell.self)
    let nib = UINib(nibName: "MobileListTableViewCell", bundle: bundle)
    tableViewControl.register(nib, forCellReuseIdentifier: "tableViewPhoneCell")
  }
  @IBAction func btnSort(_ sender: Any) {
    let alert = UIAlertController(title: "Sort", message: "", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Price low to high", style: .default, handler:nil))
    alert.addAction(UIAlertAction(title: "Price low to low", style: .default, handler:nil))
    alert.addAction(UIAlertAction(title: "Rating", style: .default, handler:nil))
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    self.present(alert, animated: true)
  }
  
  
  
// MARK: - Event handling
  func getPhones(favorite: Bool) {
    interactor.getPhones(request: MobileList.GetMobile.Request(checkFav: true))
  }
  
  
  
// MARK: - Display logic
  func mobileDisplay(viewModel: MobileList.GetMobile.ViewModel) {
    DispatchQueue.main.async {
      self.modelPhone = viewModel.mobile
      self.tableViewControl.reloadData()
    }
  }
  func displayAddFavorit(viewModel: MobileList.AddFavoritMobile.ViewModel) {
    DispatchQueue.main.async {
    self.modelFavoritPhone = viewModel.checkFavorit
    self.tableViewControl.reloadData()
    }
  }
 
  @IBAction func segmentMenu(_ sender: Any) {
    switch segMentControl.selectedSegmentIndex {
    case 0 :
      getPhones(favorite: false)
    case 1:
      getPhoneFavorite()
    default:
      break
    }
    
  }
  func getPhoneFavorite(){
    interactor.favSegment(request: MobileList.GetMobile.Request(checkFav: true))
  }
// MARK: - Router
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "ShowSomewhereScene",
      let _ = segue.destination as? MobileListDetailViewController{
      
    }
    
  }
  
  @IBAction func unwindToGuideViewController(from segue: UIStoryboardSegue) {
    print("unwind...")
    router.passDataToNextScene(segue: segue)
  }
}

extension MobileListViewController:UITableViewDelegate{
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    self.performSegue(withIdentifier: "ShowSomewhereScene", sender: nil)
  }
}
extension MobileListViewController: UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return modelPhone.count

  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let cell = tableViewControl.dequeueReusableCell(withIdentifier: "tableViewPhoneCell") as? MobileListTableViewCell else { return UITableViewCell() }
    
    let phone = modelPhone[indexPath.row]
    let isFavourite = modelFavoritPhone[phone.id ?? 0] ?? false
    
    cell.setUi(classPhone: modelPhone[indexPath.row], isFavourite: isFavourite)
    let selectCell = modelPhone[indexPath.row].id
    
    cell.btnFavoriteAction = {
      self.interactor.addFavorit(request: MobileList.AddFavoritMobile.Request(indexCell:selectCell!))
      
    }
    return cell
  }
  
  
  
}
