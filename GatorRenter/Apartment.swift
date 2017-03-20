//
//  Apartment.swift
//  GatorRenter
//
//  Created by fdai4856 on 17/03/2017.
//  Copyright © 2017 fdai4856. All rights reserved.
//

import Foundation

public struct Apartment {
    public var internalName: String
    public var id: String
    public var active: String
    public var createdAt: String
    public var updatedAt: String
    public var state: String
    public var addressLine1: String
    public var city: String
    public var country: String
    public var zip: String
    public var title: String
    public var description: String
    public var sqFeet: String
    public var nrBedrooms: String
    public var nrRoommates: String
    public var nrBathrooms: String
    public var floor: String
    public var privateRoom: String
    public var privateBath: String
    public var kitchenInApartment: String
    public var hasSecurityDeposit: String
    public var creditScoreCheck: String
    public var monthlyRent: String
    public var securityDeposit: String
    public var availableSince: String
    public var leaseEndDate: String
    public var longitude: String
    public var flagged: String
    public var latitude: String
    
    init () {
        self.internalName = ""
        self.id = ""
        self.active = ""
        self.createdAt = ""
        self.updatedAt = ""
        self.state = ""
        self.addressLine1 = ""
        self.city = ""
        self.country = ""
        self.zip = ""
        self.title = ""
        self.description = ""
        self.sqFeet = ""
        self.nrBedrooms = ""
        self.nrRoommates = ""
        self.nrBathrooms = ""
        self.floor = ""
        self.privateRoom = ""
        self.privateBath = ""
        self.kitchenInApartment = ""
        self.hasSecurityDeposit = ""
        self.creditScoreCheck = ""
        self.monthlyRent = ""
        self.securityDeposit = ""
        self.availableSince = ""
        self.leaseEndDate = ""
        self.longitude = ""
        self.flagged = ""
        self.latitude = ""

    }
    
    init(
        internalName: String,
        id: String,
         active: String,
         createdAt: String,
         updatedAt: String,
         state: String,
         addressLine1: String,
         city: String,
         country: String,
         zip: String,
         title: String,
         description: String,
         sqFeet: String,
         nrBedrooms: String,
         nrRoommates: String,
         nrBathrooms: String,
         floor: String,
         privateRoom: String,
         privateBath: String,
         kitchenInApartment: String,
         hasSecurityDeposit: String,
         creditScoreCheck: String,
         monthlyRent: String,
         securityDeposit: String,
         availableSince: String,
         leaseEndDate: String,
         longitude: String,
         flagged: String,
         latitude: String) {
        
        self.internalName = internalName
        self.id = id
        self.active = active
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.state = state
        self.addressLine1 = addressLine1
        self.city = city
        self.country = country
        self.zip = zip
        self.title = title
        self.description = description
        self.sqFeet = sqFeet
        self.nrBedrooms = nrBedrooms
        self.nrRoommates = nrRoommates
        self.nrBathrooms = nrBathrooms
        self.floor = floor
        self.privateRoom = privateRoom
        self.privateBath = privateBath
        self.kitchenInApartment = kitchenInApartment
        self.hasSecurityDeposit = hasSecurityDeposit
        self.creditScoreCheck = creditScoreCheck
        self.monthlyRent = monthlyRent
        self.securityDeposit = securityDeposit
        self.availableSince = availableSince
        self.leaseEndDate = leaseEndDate
        self.longitude = longitude
        self.flagged = flagged
        self.latitude = latitude
    }
}
