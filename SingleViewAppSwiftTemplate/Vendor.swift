//
//  Vendor.swift
//  SingleViewAppSwiftTemplate
//
//  Created by Manish Chaturvedi on 3/9/19.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import Foundation

class Vendor: Entrant {
    var firstName: String?
    var lastName: String?
    var streetAddress: String? = nil
    var city: String? = nil
    var state: String? = nil
    var zipCode: String? = nil
    var entrantType: EntrantType
    var areaAccess: [AreaAccess] = []
    var rideAccess: [RideAccess] = []
    var dateOfBirth: Date?
    var discountOnFood: Int? = nil
    var discountOnMerchandise: Int? = nil
    var projectNumber: Int?
    var vendorCompany: VendorCompany?
    var dateOfVisit: Date?
    
    init(firstName: String?, lastName: String?, entrantType: EntrantType = .Vendor, vendorCompany: VendorCompany?, dateOfBirth: Date?, dateOfVisit: Date?) throws {
        
        guard let firstNameUnwrapped = firstName.nilIfEmpty else {
            throw InitializerError.missingFirstName
        }
        
        guard let lastNameUnwrapped = lastName.nilIfEmpty else {
            throw InitializerError.missingLastName
        }
        
        guard let vendorCompanyUnwrapped = vendorCompany else {
            throw InitializerError.missingVendorCompany
        }
        
        guard let dateOfBirthUnwrapped = dateOfBirth else {
            throw InitializerError.missingDateOfBirth
        }
        
        guard let dateOfVisitUnwrapped = dateOfVisit else {
            throw InitializerError.missingDateOfVisit
        }
        
        
        self.firstName = firstNameUnwrapped
        self.lastName = lastNameUnwrapped
        self.entrantType = entrantType
        self.vendorCompany = vendorCompanyUnwrapped
        self.dateOfBirth = dateOfBirthUnwrapped
        self.dateOfVisit = dateOfVisitUnwrapped
        
        
        switch vendorCompanyUnwrapped {
        case .Acme:
            self.areaAccess = [.kitchenArea]
        case .Orkin:
            self.areaAccess = [.amusementAreas, .rideControlAreas, .kitchenArea]
        case .Fedex:
            self.areaAccess = [.maintenanceAreas, .officeAreas]
        case .NWElectrical:
            self.areaAccess = [.amusementAreas, .rideControlAreas, .kitchenArea, .maintenanceAreas, .officeAreas]
        }
        
    }
    
}
