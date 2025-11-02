//
//  DogBreedCatalog.swift
//  CollectionApp
//
//  Created by Alexander Shevtsov on 27.10.2025.
//

import Foundation

enum DogBreedCatalog {
	
	static let breeds: [DogBreed] = [
		DogBreed(
			name: "Сиба-ину",
			imageName: "breed-shiba",
			shortDescription: "Компактная и умная из Японии.",
			variants: [
				DogOption(
					name: "Люся 2 года, СПБ",
					ageYears: 2,
					location: .spb,
					imageName: "dog-lucy-shiba",
					price: 52000,
					description: "Добродушная, активная, любит длительные прогулки."
				),
				DogOption(
					name: "Кен 4 года, МСК",
					ageYears: 4,
					location: .other,
					imageName: "dog-ken-shiba",
					price: 48000,
					description: "Спокойный, аккуратный, хорошо уживается в квартире."
				)
			]
		),
		
		DogBreed(
			name: "Бордер-колли",
			imageName: "breed-border-collie",
			shortDescription: "Умная, энергичная и работоспособная.",
			variants: [
				DogOption(
					name: "Скай 2 года, СПБ",
					ageYears: 2,
					location: .spb,
					imageName: "dog-sky-border",
					price: 60000,
					description: "Очень обучаемый, обожает апорт и воду."
				),
				DogOption(
					name: "Рой 5 лет, Новосиб",
					ageYears: 5,
					location: .other,
					imageName: "dog-roy-border",
					price: 54000,
					description: "Уравновешенный, любит игры-головоломки."
				)
			]
		),
		
		DogBreed(
			name: "Самоед",
			imageName: "breed-samoyed",
			shortDescription: "Дружелюбный северный шпиц.",
			variants: [
				DogOption(
					name: "Снежок 2 года, Томск",
					ageYears: 2,
					location: .other,
					imageName: "dog-snow-samoyed",
					price: 62000,
					description: "Очень общительный, любит детей и внимание."
				),
				DogOption(
					name: "Айс 3 года, СПБ",
					ageYears: 3,
					location: .spb,
					imageName: "dog-ice-samoyed",
					price: 65000,
					description: "Активный, игривый, любит бегать по снегу."
				)
			]
		),
		
		DogBreed(
			name: "Хаски",
			imageName: "breed-husky",
			shortDescription: "Выносливый, «волчий» взгляд.",
			variants: [
				DogOption(
					name: "Луна 2 года, СПБ",
					ageYears: 2,
					location: .spb,
					imageName: "dog-luna-husky",
					price: 53000,
					description: "Ласковая, любит бег и фрисби."
				),
				DogOption(
					name: "Грей 4 года, Брянск",
					ageYears: 4,
					location: .other,
					imageName: "dog-grey-husky",
					price: 50000,
					description: "Спокойный, выносливый, дружелюбный к людям."
				)
			]
		),
		
		DogBreed(
			name: "Ретривер",
			imageName: "breed-golden",
			shortDescription: "Ласковая, семейная собака.",
			variants: [
				DogOption(
					name: "Санни 2 года, СПБ",
					ageYears: 2,
					location: .spb,
					imageName: "dog-sunny-golden",
					price: 59000,
					description: "Очень дружелюбный, любит воду и играть."
				),
				DogOption(
					name: "Голд 6 лет, Самара",
					ageYears: 6,
					location: .other,
					imageName: "dog-gold-golden",
					price: 51000,
					description: "Спокойный компаньон, терпеливый и ласковый."
				)
			]
		),
		
		DogBreed(
			name: "Овчарка",
			imageName: "breed-gsd",
			shortDescription: "Преданная и активная.",
			variants: [
				DogOption(
					name: "Рик 3 года, СПБ",
					ageYears: 3,
					location: .spb,
					imageName: "dog-rick-gsd",
					price: 56000,
					description: "Послушный, быстро обучается командам."
				),
				DogOption(
					name: "Грета 5 лет, Луга",
					ageYears: 5,
					location: .other,
					imageName: "dog-greta-gsd",
					price: 52000,
					description: "Уравновешенная, внимательная, любит дрессировку."
				)
			]
		),
		
		DogBreed(
			name: "Далматинец",
			imageName: "breed-dalmatian",
			shortDescription: "Активная и пятнистая.",
			variants: [
				DogOption(
					name: "Дотти 2 года, Пушкин",
					ageYears: 2,
					location: .other,
					imageName: "dog-dotty-dalmatian",
					price: 52000,
					description: "Игривый характер, любит долгие прогулки."
				),
				DogOption(
					name: "Спот 4 года, СПБ",
					ageYears: 4,
					location: .spb,
					imageName: "dog-spot-dalmatian",
					price: 51000,
					description: "Доброжелательный, хорошо ладит с детьми."
				)
			]
		),
		
		DogBreed(
			name: "Пудель",
			imageName: "breed-poodle",
			shortDescription: "Умная, активная и интересная.",
			variants: [
				DogOption(
					name: "Коко 2 года, СПБ",
					ageYears: 2,
					location: .spb,
					imageName: "dog-coco-poodle",
					price: 52000,
					description: "Озорной характер, любит трюки и обучение."
				),
				DogOption(
					name: "Бонни 4 года, Красноярск",
					ageYears: 4,
					location: .other,
					imageName: "dog-bonnie-poodle",
					price: 50000,
					description: "Спокойная, аккуратная, подходит для квартиры."
				)
			]
		)
	]
}

