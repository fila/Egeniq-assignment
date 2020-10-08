//
//  DogModel.swift
//  Doggies
//
//  Created by Irina Filkovskaya on 07/10/2020.
//

import Foundation

struct Dog: Decodable {
    let breeds: [Breed]?
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case breeds, url
    }
}

struct Breed: Decodable {
    let name: String?
    let bredFor: String?
    let lifeSpan: String?
    let temperament: String?
    
    enum CodingKeys: String, CodingKey {
        case name, temperament
        case bredFor = "bred_for"
        case lifeSpan = "life_span"
    }
}
