//
//  Interactor.swift
//  Doggies
//
//  Created by Irina Filkovskaya on 07/10/2020.
//

import Foundation
import RxSwift

protocol InteractorProtocol {
    func set(presenter: PresenterProtocol)
    func set(service: ServiceProtocol)
    func handleGetDoggies()
}

class Interactor: InteractorProtocol {
    
    private var service: ServiceProtocol?
    private var presenter: PresenterProtocol?
    private let disposeBag = DisposeBag()
    
    func set(presenter: PresenterProtocol) {
        self.presenter = presenter
    }
    
    func set(service: ServiceProtocol) {
        self.service = service
    }

    func handleGetDoggies() {
        service?.get()
            .subscribe(
                onSuccess: { [presenter] dogs in
                    presenter?.presentDogs(from: dogs)
                },
                onError: { [presenter] error in
                    presenter?.presentError(error)
                })
            .disposed(by: disposeBag)
    }
}
