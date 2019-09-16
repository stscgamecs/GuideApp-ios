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

    @IBOutlet weak var segMentControl: UISegmentedControl!
   
    @IBAction func segMentController(_ sender: Any) {
        
        switch  segMentControl.selectedSegmentIndex {
        case 0:
           
            print("one")
        case 1:
           
            print("Two")
           
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
    
    let bundle = Bundle(for: SegmentTableViewCell.self)
    let nib = UINib(nibName: "SegmentTableViewCell", bundle: bundle)
    tableViewControl.register(nib, forCellReuseIdentifier: "tableViewPhoneCell")
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

extension GuideViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "ShowSomewhereScene", sender: nil)
    }
}
extension GuideViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableViewControl.dequeueReusableCell(withIdentifier: "tableViewPhoneCell") as? SegmentTableViewCell else { return UITableViewCell() }
        return cell
    }
    
    
    
}
