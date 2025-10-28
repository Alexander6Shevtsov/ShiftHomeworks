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
			shortDescription: "Компактная, умная и независимая собака из Японии.",
			extendedDescription: """
 Сиба-ину — внимательная и независимая порода, 
 известная своей чистоплотностью и «лисиным» выражением. 
 Требует ранней социализации и последовательной дрессировки.
 """,
			variants: [
				DogOption(
					name: "Люся",
					ageYears: 2,
					location: .spb,
					imageName: "dog-lucy-shiba",
					price: 52000,
					description: "Добродушная, активная, любит длительные прогулки."
				),
				DogOption(
					name: "Кен",
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
			shortDescription: "Одна из самых умных пород, энергичная и работоспособная.",
			extendedDescription: """
 Бордер-колли — выдающаяся рабочая собака с потребностью в умственных и физических нагрузках. 
 Идеальна для аджилити и активных хозяев.
 """,
			variants: [
				DogOption(
					name: "Скай",
					ageYears: 1,
					location: .spb,
					imageName: "dog-sky-border",
					price: 60000,
					description: "Очень обучаемый, обожает апорт и аджилити."
				),
				DogOption(
					name: "Рой",
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
			shortDescription: "Дружелюбный «улыбающийся» северный шпиц.",
			extendedDescription: "Самоед — ласковая и общительная порода с густой белой шерстью. Требует регулярного ухода за шерстью и достаточных прогулок.",
			variants: [
				DogOption(
					name: "Снежок",
					ageYears: 2,
					location: .other,
					imageName: "dog-snow-samoyed",
					price: 62000,
					description: "Очень общительный, любит детей и внимание."
				),
				DogOption(
					name: "Айс",
					ageYears: 3,
					location: .spb,
					imageName: "dog-ice-samoyed",
					price: 65000,
					description: "Активный, игривый, любит бегать по снегу."
				)
			]
		),
		
		DogBreed(
			name: "Сибирский хаски",
			imageName: "breed-husky",
			shortDescription: "Выносливый, дружелюбный, с характерным «волчьим» взглядом.",
			extendedDescription: "Хаски — энергичная порода, требующая активных прогулок и внимания. Умны и независимы, нуждаются в последовательной дрессировке.",
			variants: [
				DogOption(
					name: "Луна",
					ageYears: 1,
					location: .spb,
					imageName: "dog-luna-husky",
					price: 53000,
					description: "Ласковая, любит бег и фрисби."
				),
				DogOption(
					name: "Грей",
					ageYears: 4,
					location: .other,
					imageName: "dog-grey-husky",
					price: 50000,
					description: "Спокойный, выносливый, дружелюбный к людям."
				)
			]
		),
		
		DogBreed(
			name: "Голден ретривер",
			imageName: "breed-golden",
			shortDescription: "Ласковая, уравновешенная семейная собака.",
			extendedDescription: "Голден ретривер — добрая и умная порода, легко обучается и обожает приносить предметы. Прекрасно подходит для семьи.",
			variants: [
				DogOption(
					name: "Санни",
					ageYears: 2,
					location: .spb,
					imageName: "dog-sunny-golden",
					price: 59000,
					description: "Очень дружелюбный, любит воду и апорт."
				),
				DogOption(
					name: "Голд",
					ageYears: 6,
					location: .other,
					imageName: "dog-gold-golden",
					price: 51000,
					description: "Спокойный компаньон, терпеливый и ласковый."
				)
			]
		),
		
		DogBreed(
			name: "Немецкая овчарка",
			imageName: "breed-gsd",
			shortDescription: "Интеллектуальная служебная порода, преданная и активная.",
			extendedDescription: "Немецкая овчарка — универсальная порода для службы и спорта. Требует дрессировки и активных занятий.",
			variants: [
				DogOption(
					name: "Рик",
					ageYears: 3,
					location: .spb,
					imageName: "dog-rick-gsd",
					price: 56000,
					description: "Послушный, быстро обучается командам."
				),
				DogOption(
					name: "Грета",
					ageYears: 5,
					location: .other,
					imageName: "dog-greta-gsd",
					price: 52000,
					description: "Уравновешенная, внимательная, любит дрессировку."
				)
			]
		),
		
		DogBreed(
			name: "Далматин",
			imageName: "breed-dalmatian",
			shortDescription: "Активная, яркая порода с пятнистым окрасом.",
			extendedDescription: "Далматины — энергичные и дружелюбные собаки. Нуждаются в регулярных нагрузках и внимании хозяина.",
			variants: [
				DogOption(
					name: "Дотти",
					ageYears: 2,
					location: .other,
					imageName: "dog-dotty-dalmatian",
					price: 52000,
					description: "Игривый характер, любит долгие прогулки."
				),
				DogOption(
					name: "Спот",
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
			shortDescription: "Умная, активная порода, различается по размерам.",
			extendedDescription: "Пудели легко обучаемы, славятся сообразительностью. Требуют ухода за шерстью и регулярных прогулок.",
			variants: [
				DogOption(
					name: "Коко",
					ageYears: 1,
					location: .spb,
					imageName: "dog-coco-poodle",
					price: 52000,
					description: "Озорной характер, любит трюки и обучение."
				),
				DogOption(
					name: "Бонни",
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
