//
//  ServerRepository.swift
//  RefugeConnect
//
//  Created by Christian Graver on 04/03/2022.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

struct Constants {
	struct Collections {
		static let Shelters = "shelters"
	}
}

class ServerRepository {
	let db: Firestore
	init() {
		db = Firestore.firestore()
	}
	
	public func addShelther(_ shelter: Shelter, completion: @escaping (_ id:String?) -> Void) {
		let docRef = db.collection(Constants.Collections.Shelters).document()
		
		do {
			try docRef.setData(from: shelter)
			completion(docRef.documentID)
		}
		catch {
			print(error)
			completion(nil)
		}
	}
	
	public func updateShelther(_ shelter: Shelter, with id: String, completion: @escaping (_ id:String?) -> Void) {
		//guard let id = shelter.id else { return }
		
		let docRef = db.collection(Constants.Collections.Shelters).document(id)
	
		do {
			try docRef.setData(from: shelter)
			completion(id)
		}
		catch {
			print(error)
			completion(nil)
		}
	}
	
	public func getShelter(with id: String, completion: @escaping (_ shelter:Shelter?) -> Void) {
		let docRef = db.collection(Constants.Collections.Shelters).document(id)

		 docRef.getDocument { document, error in
			 if let error = error as NSError? {
				 print(error)
				 completion(nil)
				 return
			 }
			 else {
				 if let document = document {
					 do {
						 let shelter = try document.data(as: Shelter.self)
						 completion(shelter)
					 }
					 catch {
						 print(error)
						 completion(nil)
					 }
				 }
			 }
		 }
	}
	
	public func getShelters(completion: @escaping (_ shelter:[Shelter]) -> Void) {
		let collectionRef = db.collection(Constants.Collections.Shelters)
		
		collectionRef.getDocuments() { (querySnapshot, err) in
			if let err = err {
				print("Error getting documents: \(err)")
				completion([])
			} else {
				if let documents = querySnapshot?.documents {
					let shelters: [Shelter] = documents.compactMap { document in
						return try? document.data(as: Shelter.self)
					}
					completion(shelters)
				}
				completion([])
			}
		}
		
	}
}
