//
//  ShelterVM.swift
//  RefugeConnect
//
//  Created by Christian Graver on 04/03/2022.
//

import Foundation
import MapKit

struct ShelterVM {
	var hostName: String?
	var coarseLocation: CLLocationCoordinate2D?
	var	accommodatesAdults: Int?
	var	accommodatesChildren: Int?
	var	accommodatesBabies: Int?
	var startDate: Date?
	var endDate: Date?
	var maxDurationWeeks: Int?
}
