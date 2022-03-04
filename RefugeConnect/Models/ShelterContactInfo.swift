//
//  ShelterContactInfo.swift
//  RefugeConnect
//
//  Created by Christian Graver on 04/03/2022.
//

import Foundation
import FirebaseFirestoreSwift

struct ShelterContactInfo: Codable {
	@DocumentID var id: String?
	var phoneNumber: String
	var hostUID: String
	var refugeeUID: String?
}


