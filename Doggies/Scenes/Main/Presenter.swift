//
//  Presenter.swift
//  Doggies
//
//  Created by Irina Filkovskaya on 07/10/2020.
//

import Foundation

protocol PresenterProtocol {
    func set(viewController: ViewControllerProtocol)
    func presentDogs(from models: [Dog])
    func presentError(_ error: Error)
}

class Presenter: PresenterProtocol {
    
    // MARK: - DI
    private weak var viewController: ViewControllerProtocol?
    
    func set(viewController: ViewControllerProtocol) {
        self.viewController = viewController
    }
    
    // MARK: - Presentation Logic
    func presentDogs(from models: [Dog]) {
        let viewModels: [ViewModel] = models.map { dog in
            var title = ""
            var bredFor = ""
            var lifeSpan = ""
            var temperament = ""
            
            if let breed = dog.breeds?[0] {
                title = breed.name ?? ""
                bredFor = breed.bredFor ?? ""
                lifeSpan = breed.lifeSpan ?? ""
                temperament = breed.temperament ?? ""
            }
            
            return ViewModel(title: title,
                             imageUrl: dog.url,
                             bredFor: bredFor,
                             lifeSpan: lifeSpan,
                             temperament: temperament)
        }
        
        viewController?.displayDoggies(from: viewModels)
    }
    
    func presentError(_ error: Error) {
        
        var title: String? = nil
        if let appError = error as? AppError {
            title = appError.title
        }
        
        viewController?.displayError(title: title, message: error.localizedDescription)
    }
}
