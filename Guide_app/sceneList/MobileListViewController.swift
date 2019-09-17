//
//  GuideViewController.swift
//  Guide_app
//
//  Created by Z64me on 16/9/2562 BE.
//  Copyright (c) 2562 Z64me. All rights reserved.
//

import UIKit

protocol MobileListViewControllerInterface: class {
  func displaySomething(viewModel: Guide.Something.ViewModel)
}

class MobileListViewController: UIViewController, MobileListViewControllerInterface {
  //var interactor: GuideInteractorInterface!
  var router: MobileListRouter!

    @IBOutlet weak var segMentControl: UISegmentedControl!
    //var number:Int = 2
    @IBAction func segMentController(_ sender: Any) {
        
        switch  segMentControl.selectedSegmentIndex {
        case 0:
            //number = 2
            print("one")
            tableViewControl.reloadData()
        case 1:
          // number = 4
            print("Two")
           tableViewControl.reloadData()
        default:
            break
        }
    }
    
 
    @IBOutlet weak var tableViewControl: UITableView!
    
    @IBAction func btnSort(_ sender: Any) {
     
        let alert = UIAlertController(title: "Sort", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Price low to high", style: .default, handler:nil))
        alert.addAction(UIAlertAction(title: "Price low to low", style: .default, handler:nil))
        alert.addAction(UIAlertAction(title: "Rating", style: .default, handler:nil))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))

        self.present(alert, animated: true)
        
    }
    
    
  // MARK: - Object lifecycle

  override func awakeFromNib() {
    super.awakeFromNib()
   // configure(viewController: self)
  }

  // MARK: - Configuration

//  private func configure(viewController: GuideViewController) {
//    let router = GuideRouter()
//    router.viewController = viewController
//
//    let presenter = GuidePresenter()
//    presenter.viewController = viewController
//
//    let interactor = GuideInteractor()
//    interactor.presenter = presenter
//    interactor.worker = GuideWorker(store: GuideStore())
//
//    viewController.interactor = interactor
//    viewController.router = router
//  }

  // MARK: - View lifecycle
    
  override func viewDidLoad() {
    super.viewDidLoad()
    
    let bundle = Bundle(for: SegmentTableViewCell.self)
    let nib = UINib(nibName: "SegmentTableViewCell", bundle: bundle)
    tableViewControl.register(nib, forCellReuseIdentifier: "tableViewPhoneCell")
   // doSomethingOnLoad()
    getBeers() 
    
  }
    var arrApiPhone:[phone] = []
    var page = 1
    func getBeers() {
        
        let apiManager = ApiPhone()
        apiManager.getPhone(urlString:"https://scb-test-mobile.herokuapp.com/api/mobiles/") { [weak self] (result: Result<[phone], APIError>) in
            switch result {
            case .success(let phone):
                self?.arrApiPhone.append(contentsOf: phone)
                DispatchQueue.main.sync {
                    //self?.loadingView.isHidden = true
                    self?.tableViewControl.reloadData()
                    self?.page += 1
                }
            case .failure(let error):
                print(error.localizedDescription)
                let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
                let action = UIAlertAction(title: "OK", style: .destructive)
                alert.addAction(action)
                DispatchQueue.main.sync {
                    //  self?.loadingView.isHidden = true
                    self?.present(alert, animated: true)
                }
            }
        }
    }
  // MARK: - Event handling
  func doSomethingOnLoad() {
    // NOTE: Ask the Interactor to do some work

   // let request = Guide.Something.Request()
   // interactor.doSomething(request: request)
  }

  // MARK: - Display logic

  func displaySomething(viewModel: Guide.Something.ViewModel) {
    // NOTE: Display the result from the Presenter

    // nameTextField.text = viewModel.name
  }

  // MARK: - Router

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "ShowSomewhereScene",
        let _ = segue.destination as? MobileListDetailViewController{
        
    }
    //router.passDataToNextScene(segue: segue)
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
extension MobileListViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
                print(arrApiPhone.count)
        return arrApiPhone.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableViewControl.dequeueReusableCell(withIdentifier: "tableViewPhoneCell") as? SegmentTableViewCell else { return UITableViewCell() }
        
        cell.setUi(classPhone: arrApiPhone[indexPath.row])
        return cell
    }
    
    
    
}
