//
//  DataSource.swift
//  Doggies
//
//  Created by Irina Filkovskaya on 07/10/2020.
//

import UIKit
import Nuke

class DataSource: NSObject, UITableViewDataSource {
    
    // MARK: - Data
    private var dogs: [ViewModel] = []
    
    func set(data: [ViewModel]) {
        dogs = data
    }
    
    // MARK: - Data Source Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dogs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DogCell") as? DogCell else {
            return UITableViewCell()
        }
        
        let model = dogs[indexPath.row]
        if let url = URL(string: model.imageUrl) {
            Nuke.loadImage(
                with: url,
                options: .init(placeholder: UIImage(named: "default-placeholder"),
                               transition: .none,
                               failureImage: UIImage(named: "default-placeholder"),
                               failureImageTransition: .none,
                               contentModes: nil),
                into: cell.dogImageView
            )
        }
        
        cell.configure(with: model)
        return cell
    }
}
