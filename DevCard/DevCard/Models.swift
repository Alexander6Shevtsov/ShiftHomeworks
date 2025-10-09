//
//  Models.swift
//  DevCard
//
//  Created by Alexander Shevtsov on 03.10.2025.
//

import Foundation

struct Person {
	let fullName: String
	let education: String
	let city: String
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
