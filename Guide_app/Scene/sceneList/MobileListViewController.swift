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
  func  displaySortPhone(viewModel: MobileList.SortMobileList.ViewModelMobile)
}

class MobileListViewController: UIViewController,MobileListViewControllerInterface {
  
  var interactor: MobileListInteractorInterface!
  var router: MobileListRouter!
  var modelPhone: Phones = []
  var modelFavoritPhone: [Int: Bool] = [:]
  var statusFavForDelete : Bool = false
  var typeBar: SegmentStatus = .all

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
    getPhones()
    
  }
  
  func setupCell() {
    let bundle = Bundle(for: MobileListTableViewCell.self)
    let nib = UINib(nibName: "MobileListTableViewCell", bundle: bundle)
    tableViewControl.register(nib, forCellReuseIdentifier: "tableViewPhoneCell")
  }
  @IBAction func btnSort(_ sender: Any) {
    
    let alert = UIAlertController(title: "Sort", message: "", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "Price low to high", style: .default, handler:{ action in

      self.getSortImage(typeSort: .priceHighToLow)
    }))
    alert.addAction(UIAlertAction(title: "Price high to low", style: .default, handler:{ action in

      self.getSortImage(typeSort: .priceLowToHigh)
    }))
    alert.addAction(UIAlertAction(title: "Rating", style: .default, handler:{ action in

      self.getSortImage(typeSort: .rating)
    }))
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
    self.present(alert, animated: true)
  }
  
  // MARK: - Display logic
  func mobileDisplay(viewModel: MobileList.GetMobile.ViewModel) {
   
      self.modelPhone = viewModel.mobile
      self.statusFavForDelete = viewModel.checkFavDelete
      self.tableViewControl.reloadData()
    
  }
  func displayAddFavorit(viewModel: MobileList.AddFavoritMobile.ViewModel) {

      self.modelFavoritPhone = viewModel.checkFavorit
      self.tableViewControl.reloadData()
    
  }
  func displaySortPhone(viewModel: MobileList.SortMobileList.ViewModelMobile) {
   
      self.modelPhone = viewModel.mobile
      self.tableViewControl.reloadData()
    
  }
  
  @IBAction func segmentMenu(_ sender: Any) {
    switch segMentControl.selectedSegmentIndex {
    case 0 :
      statusFavForDelete = false
      self.getPhoneFavorite(typeBar: .all)
      
      
    case 1:
      statusFavForDelete = true
      self.getPhoneFavorite(typeBar: .favorite)
      
    default:
      break
    }
    
  }
  
  // MARK: - Event handling
  func getPhones() {
    interactor.getPhones(request: MobileList.GetMobile.Request(segmentStatus: .all))
  }
  
  func getPhoneFavorite(typeBar: SegmentStatus ){
    interactor.getSegment(request: MobileList.GetMobile.Request(segmentStatus:typeBar))
  }
  
  func getSortImage(typeSort: SortingStatus){
    interactor.getSort(request: MobileList.SortMobileList.RequestMobile(sortingStatus: typeSort))
  }

  
  // MARK: - Router
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "ShowSomewhereScene",
      let viewController = segue.destination as? MobileListDetailViewController{
      viewController.displayDetail(viewModel: sender as! Mobile)
    }
    
  }
  
  @IBAction func unwindToGuideViewController(from segue: UIStoryboardSegue) {
    print("unwind...")
    router.passDataToNextScene(segue: segue)
  }
}


extension MobileListViewController:UITableViewDelegate{
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let indexDescription = modelPhone[indexPath.item]
    self.performSegue(withIdentifier: "ShowSomewhereScene", sender: indexDescription)
      
  }
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    
    return statusFavForDelete
  }
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    let selectCell = modelPhone[indexPath.row].id
    
    self.interactor.getFavorit(request: MobileList.AddFavoritMobile.Request(indexCell:selectCell!))
    if editingStyle == .delete {
      self.modelPhone.remove(at: indexPath.row)
      self.tableViewControl.deleteRows(at:[indexPath], with: .fade)
    }
  }
}

extension MobileListViewController: UITableViewDataSource{
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return modelPhone.count
    
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let cell = tableViewControl.dequeueReusableCell(withIdentifier: "tableViewPhoneCell") as? MobileListTableViewCell else { return UITableViewCell() }
    
    let selectCell = modelPhone[indexPath.row].id
    cell.btnFavoriteAction = {
      self.interactor.getFavorit(request: MobileList.AddFavoritMobile.Request(indexCell:selectCell!))
    }
    let phone = modelPhone[indexPath.row]
    let isFavourite = modelFavoritPhone[phone.id ?? 0] ?? false
    cell.setUi(classPhone: modelPhone[indexPath.row], isFavourite: isFavourite)
    
    cell.setFavHidden(isMenuFavorite: typeBar)
    return cell
  }
  
  
  
}
