//
//  ViewController.swift
//  Refugees
//
//  Created by Christian Graver on 02/03/2022.
//

import UIKit
import FirebaseAuth

class AuthViewController: UIViewController {
	
	@IBOutlet var phoneNumberTextField: UITextField!
	@IBOutlet var verifyLabel: UILabel!
	
	@IBOutlet var authCodeLabel: UILabel!
	@IBOutlet var authCodeTextField: UITextField!
	@IBOutlet var authCodeOkButton: UIButton!
	@IBOutlet var errorTextView: UITextView!
	
	// MARK: - Init
	class func instantiate() -> AuthViewController {
			let name = "\(AuthViewController.self)"
			let storyboard = UIStoryboard(name: name, bundle: nil)
			let vc = storyboard.instantiateViewController(withIdentifier: name) as! AuthViewController
			return vc
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		authCodeLabel.isHidden = true
		authCodeTextField.isHidden = true
		authCodeOkButton.isHidden = true
		errorTextView.isHidden = true
	}
	@IBAction func okPressed(_ sender: Any) {
		guard let number = phoneNumberTextField.text,
					!number.isEmpty else {
						return
					}
		handlePhone(number)
	}
	
	@IBAction func authCodeOkPressed(_ sender: Any) {
		guard let authCode = authCodeTextField.text,
					!authCode.isEmpty else {
						return
					}
		handleAuth(authCode)
	}
	
	private func handlePhone(_ number: String) {
		PhoneAuthProvider.provider()
			.verifyPhoneNumber(number, uiDelegate: nil) { verificationID, error in
				if let error = error {
					self.verifyLabel.text = error.localizedDescription
					return
				}
				self.verifyLabel.text = "code \(verificationID ?? "??")"
				self.authCodeLabel.isHidden = false
				self.authCodeTextField.isHidden = false
				self.authCodeOkButton.isHidden = false
				
				UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
			}
	}
	
	private func handleAuth(_ code: String) {
		guard let verificationID = UserDefaults.standard.string(forKey: "authVerificationID") else {
			return
		}
		
		let credential = PhoneAuthProvider.provider().credential(
			withVerificationID: verificationID,
			verificationCode: code
		)
		
		Auth.auth().signIn(with: credential) { authResult, error in
			if let error = error {
				self.errorTextView.text = error.localizedDescription
			}
			
			//User is signed in
			self.errorTextView.text = "You signed in!"
			
		}
	}
}

