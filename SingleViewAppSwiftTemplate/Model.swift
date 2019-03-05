//
//  Entrants.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Manish Chaturvedi on 2/16/19.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import Foundation

enum EntrantType: String {
    case ClassicGuest
    case VIPGuest
    case FreeChildGuest
    case FoodSerEmp
    case RideSerEmp
    case MaintenanceEmp
    case Manager
    
}

enum AreaAccess: String {
    case amusementAreas
    case rideControlAreas
    case kitchenArea
    case maintenanceAreas
    case officeAreas
}

enum RideAccess {
    case accessAllRides
    case skipLine
}

enum InitializerError: Error {
    case missingDateOfBirth
    case missingFirstName
    case missingLastName
    case missingStreetAddress
    case missingCity
    case missingState
    case missingZipCode
    case olderThanAgeLimit
}

// Protocol for Staff info

protocol StaffInfo {
    var firstName: String? { get set }
    var lastName: String? { get set }
    var streetAddress: String? { get set }
    var city: String? { get set }
    var state: String? { get set }
    var zipCode: String? { get set }
}

// Protocol to make a custom type Entrant
// Entrant is a protocol which requires all the properties
protocol Entrant: StaffInfo {
    var areaAccess: [AreaAccess] { get set }
    var rideAccess: [RideAccess] { get set }
    var entrantType: EntrantType { get set }
    var dateOfBirth: Date? { get set }
    var discountOnFood: Int? { get set }
    var discountOnMerchandise: Int? { get set }
}




protocol SwipeTime {
    var swipeTime: Date? { get set }
}


// Struct to hold uniform passes
struct Pass: Entrant, SwipeTime {
    var firstName: String?
    var lastName: String?
    var streetAddress: String?
    var city: String?
    var state: String?
    var zipCode: String?
    var entrantType: EntrantType
    var rideAccess: [RideAccess] = []
    var areaAccess: [AreaAccess] = []
    var dateOfBirth: Date?
    var discountOnFood: Int?
    var discountOnMerchandise: Int?
    var swipeTime: Date? = nil
    
    init(firstName: String? = nil, lastName: String? = nil, streetAddress: String? = nil, city: String? = nil, state: String? = nil, zipCode: String? = nil, entrantType: EntrantType, dateOfBirth: Date? = nil, discountOnFood: Int? = nil, discountOnMerchandise: Int? = nil) {
        self.firstName = firstName
        self.lastName = lastName
        self.streetAddress = streetAddress
        self.city = city
        self.state = state
        self.zipCode = zipCode
        self.entrantType = entrantType
        self.dateOfBirth = dateOfBirth
        self.discountOnFood = discountOnFood
        self.discountOnMerchandise = discountOnMerchandise
    }
}
























