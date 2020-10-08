//
//  ViewController.swift
//  Doggies
//
//  Created by Irina Filkovskaya on 07/10/2020.
//

import UIKit

protocol ViewControllerProtocol: class {
    func displayDoggies(from models: [ViewModel])
    func displayError(title: String?, message: String)
}

class ViewController: UIViewController {
    
    // MARK: - IB Outlets
    @IBOutlet weak var button: UIButton! {
        didSet {
            button.layer.masksToBounds = true
            button.layer.cornerRadius = 8
            button.setTitle("Show Doggies", for: .normal)
        }
    }
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Actions
    @IBAction func buttonTapped(_ sender: Any) {
        interactor?.handleGetDoggies()
    }
    
    // MARK: - DI
    private var interactor: InteractorProtocol?
    private let dataSource = DataSource()
    
    // MARK: - View Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
}

// MARK: - Protocol Methods
extension ViewController: ViewControllerProtocol {
    func displayDoggies(from models: [ViewModel]) {
        dataSource.set(data: models)
        DispatchQueue.main.async {
            self.button.setTitle("Show More Doggies", for: .normal)
            self.tableView.isHidden = false
            self.tableView.reloadData()
            self.tableView.scrollToRow(at: .init(row: 0, section: 0), at: .top, animated: true)
        }
    }
    
    func displayError(title: String?, message: String) {
        
        guard let title = title else {
            print(message)
            return
        }
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(okAction)
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}

// MARK: - Privates
private extension ViewController {
    func configure() {
        interactor = Interactor()
        let presenter = Presenter()
        let service = Service()
        
        interactor?.set(presenter: presenter)
        interactor?.set(service: service)
        presenter.set(viewController: self)
    }
    
    func setupTableView() {
        tableView.dataSource = dataSource
        tableView.delegate = self
    }
}

extension ViewController: UITableViewDelegate {}

