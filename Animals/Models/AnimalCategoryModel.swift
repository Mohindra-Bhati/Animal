//
//  AnimalCategoryModel.swift
//  Animals
//
//  Created by Mohindra Bhati on 09/07/24.
//

import Foundation

struct AnimalCategoryModel: Codable, Identifiable {
    var id: UUID? = .init()
    let name: String?
    let taxonomy: Taxonomy?
    let locations: [String]?
    let characteristics: Characteristics?
}

struct Taxonomy: Codable {
    let kingdom: String?
    let phylum: String?
    let classTaxonomy: String?
    let order: String?
    let family: String?
    let genus: String?
    let scientificName: String?

    enum CodingKeys: String, CodingKey {
        case kingdom, phylum
        case classTaxonomy = "class"
        case order, family, genus
        case scientificName = "scientific_name"
    }
}

struct Characteristics: Codable {
    let prey: String?
    let mainPrey: String?
    let nameOfYoung: String?
    let groupBehavior: String?
    let estimatedPopulationSize: String?
    let biggestThreat: String?
    let mostDistinctiveFeature: String?
    let otherNames: String?
    let gestationPeriod: String?
    let habitat: String?
    let predators: String?
    let diet: String?
    let averageLitterSize: String?
    let lifestyle: String?
    let commonName: String?
    let numberOfSpecies: String?
    let location: String?
    let slogan: String?
    let group: String?
    let color: String?
    let skinType: String?
    let topSpeed: String?
    let lifespan: String?
    let weight: String?
    let height: String?
    let ageOfSexualMaturity: String?
    let ageOfWeaning: String?

    enum CodingKeys: String, CodingKey {
        case prey
        case mainPrey = "main_prey"
        case nameOfYoung = "name_of_young"
        case groupBehavior = "group_behavior"
        case estimatedPopulationSize = "estimated_population_size"
        case biggestThreat = "biggest_threat"
        case mostDistinctiveFeature = "most_distinctive_feature"
        case otherNames = "other_name(s)"
        case gestationPeriod = "gestation_period"
        case habitat, predators, diet
        case averageLitterSize = "average_litter_size"
        case lifestyle
        case commonName = "common_name"
        case numberOfSpecies = "number_of_species"
        case location, slogan, group, color
        case skinType = "skin_type"
        case topSpeed = "top_speed"
        case lifespan, weight, height
        case ageOfSexualMaturity = "age_of_sexual_maturity"
        case ageOfWeaning = "age_of_weaning"
    }
}
