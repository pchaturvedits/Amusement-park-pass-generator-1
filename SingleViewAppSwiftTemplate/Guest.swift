//
//  Guest.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Manish Chaturvedi on 2/25/19.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import Foundation
class Guest:Entrant {
    var firstName: String?
    var lastName: String?
    var streetAddress: String?
    var city: String?
    var state: String?
    var zipCode: String?
    var entrantType: EntrantType
    var areaAccess: [AreaAccess] = [.amusementAreas]
    var rideAccess: [RideAccess] = [.accessAllRides]
    var dateOfBirth: Date?
    var discountOnFood: Int?
    var discountOnMerchandise: Int?
    
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
    class ClassicGuest: Guest {
        override init(firstName: String? = nil, lastName: String? = nil, streetAddress: String? = nil, city: String? = nil, state: String? = nil, zipCode: String? = nil, entrantType: EntrantType = .ClassicGuest, dateOfBirth: Date? = nil, discountOnFood: Int?  = nil, discountOnMerchandise: Int? = nil) {
            super.init(entrantType: entrantType)
        }
}
    class VIPGuest: Guest {
        
        override init(firstName: String? = nil, lastName: String? = nil, streetAddress: String? = nil, city: String? = nil, state: String? = nil, zipCode: String? = nil, entrantType: EntrantType = .VIPGuest, dateOfBirth: Date? = nil, discountOnFood: Int? = nil, discountOnMerchandise: Int? = nil) {
            super.init(entrantType: entrantType)
            self.rideAccess = [.accessAllRides, . skipLine]
            self.discountOnFood = 10
            self.discountOnMerchandise = 20
        }
}

class FreeChildGuest: Guest {
    let maxChildAge: Int = 5

    init(dateOfBirth: Date?, entrantType: EntrantType = .FreeChildGuest) throws {
        super.init(entrantType: entrantType)
        guard let dateOfBirthUnwrapped = dateOfBirth else {
            throw InitializerError.missingDateOfBirth
        }

        let calendar = Calendar.current
        let ageComponent = calendar.dateComponents([.year], from: dateOfBirthUnwrapped , to: Date())

        if let ageComponentUnwrapped = ageComponent.year {
            if ageComponentUnwrapped <= maxChildAge {
                self.dateOfBirth = dateOfBirthUnwrapped
            } else {
                throw InitializerError.olderThanAgeLimit
            }
        }
    }

}



//class FreeChildGuest: Guest{
//    override init(firstName: String? = nil, lastName: String? = nil, streetAddress: String? = nil, city: String? = nil, state: String? = nil, zipCode: String? = nil, entrantType: EntrantType = .FreeChildGuest, dateOfBirth: Date? = nil, discountOnFood: Int? = nil, discountOnMerchandise: Int? = nil) {
//        super.init(entrantType: entrantType )
//
//        <#code#>
//    }
//}
//






