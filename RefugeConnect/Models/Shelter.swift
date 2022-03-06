//
//  Shelter.swift
//  RefugeConnect
//
//  Created by Christian Graver on 04/03/2022.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct Shelter: Codable {
	@DocumentID var id: String?
	var userID: String
	var hostName: String
	var coarseLocation: GeoPoint
	var geoHash: String
	var	accommodatesAdults: Int
	var	accommodatesChildren: Int
	var	accommodatesBabies: Int
	var startDate: Date
	var endDate: Date
	var maxDurationWeeks: Int
	var contactInfo: ShelterContactInfo
}

