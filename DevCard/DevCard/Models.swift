//
//  Models.swift
//  DevCard
//
//  Created by Alexander Shevtsov on 03.10.2025.
//

import Foundation

struct Person {
	let firstName: String
	let lastName: String
	let age: Int
	let education: String
	let city: String
	let homeTown: String
	let photo: String
}

struct DevelopSkills {
	let experienceYears: Int
	let languages: String
	let internshipResults: String
}

struct Hobby {
	let hobbies: [String]
}
