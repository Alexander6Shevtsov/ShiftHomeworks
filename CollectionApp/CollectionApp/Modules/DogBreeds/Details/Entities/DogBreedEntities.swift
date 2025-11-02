//
//  DogBreedEntities.swift
//  CollectionApp
//
//  Created by Alexander Shevtsov on 27.10.2025.
//

import Foundation

enum DogLocation: Equatable {
	case spb
	case other
}

struct DogOption: Equatable {
	let name: String
	let ageYears: Int
	let location: DogLocation
	let imageName: String
	let price: Int
	let description: String
}

struct DogBreed: Equatable {
	let name: String
	let imageName: String
	let shortDescription: String
	let variants: [DogOption]
}

