//
//  DogBreedEntities.swift
//  CollectionApp
//
//  Created by Alexander Shevtsov on 27.10.2025.
//

import Foundation

enum DogLocation {
	case spb
	case other
}

struct DogOption {
	let name: String
	let ageYears: Int
	let location: DogLocation
	let imageName: String
	let price: Int
	let description: String
}

struct DogBreed {
	let name: String
	let imageName: String
	let shortDescription: String
	let extendedDescription: String
	let basePrice: Int
	let variants: [DogOption]
}
