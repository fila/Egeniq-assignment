//
//  AppError.swift
//  Doggies
//
//  Created by Irina Filkovskaya on 07/10/2020.
//

import Foundation

protocol AppError: Error {
    var title: String { get }
    var localizedDescription: String { get }
}

enum DataError: AppError {
    
    case wrongUrlFormat
    case fetchingDataFailed(Error?)
    case decodingDataFailed(Error)
    
    var title: String {
        return "Ooops!"
    }
    
    var localizedDescription: String {
        switch self {
        case .decodingDataFailed(let error):
            return "Decoding the data fetched from the server failed: \(error.localizedDescription)."
        case .fetchingDataFailed(let error):
            var extra = ""
            if let error = error {
                extra = ": \(error.localizedDescription)"
            }
            return "Fetching data from the server failed" + extra + "."
        case .wrongUrlFormat:
            return "Wrong server URL is used."
        }
    }
}
