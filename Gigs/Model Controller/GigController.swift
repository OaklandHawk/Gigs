//
//  GigController.swift
//  Gigs
//
//  Created by Taylor Lyles on 9/4/19.
//  Copyright © 2019 Taylor Lyles. All rights reserved.
//

import Foundation

enum HTTPMethod: String {
	case get = "GET"
	case put = "PUT"
	case post = "POST"
	case delete = "DELETE"
}

enum NetworkError: Error {
	case encodingError
	case responseError
	case otherError
	case noData
	case noDecode
	case signUpError
}

class GigController {
	
	var bearer: Bearer?
	
	let baseURL = URL(string: "https://lambdagigs.vapor.cloud/api")!
	
	func signUp(with user: User, completion: @escaping (NetworkError?) -> (Void)) {
		let signUpURL = baseURL
			.appendingPathComponent("users")
			.appendingPathComponent("signup")
		
		var request = URLRequest(url: signUpURL)
		request.httpMethod = HTTPMethod.post.rawValue
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		
		do {
			request.httpBody = try JSONEncoder().encode(user)
		} catch {
			NSLog("Error encoding user object: \(error)")
			completion(.encodingError)
			return
		}
		
		URLSession.shared.dataTask(with: request) { (_, response, error) in
			if let response = response as? HTTPURLResponse,
				response.statusCode != 200 {
				completion(.responseError)
				return
			}
			
			if let error = error {
				NSLog("Error signing up: \(error)")
				completion(.signUpError)
				return
			}
			completion(nil)
		}.resume()
	}
	
	func logIn(with user: User, completion: @escaping (Error?) -> ()) {
		let logInUrl = baseURL
			.appendingPathComponent("users")
			.appendingPathComponent("login")
		
		var request = URLRequest(url: logInUrl)
		request.httpMethod = HTTPMethod.post.rawValue
		request.setValue("application/json", forHTTPHeaderField: "Content-Type")
		
		do {
			request.httpBody = try JSONEncoder().encode(user)
		} catch {
			NSLog("Error encoding user object: \(error)")
			completion(error)
			return
		}
		
		URLSession.shared.dataTask(with: request) { (data, response, error) in
			
			if let response = response as? HTTPURLResponse,
				response.statusCode != 200 {
				completion(NSError())
				return
			}
			
			if let error = error {
				NSLog("Error logging in: \(error)")
				completion(error)
				return
			}
			
			guard let data = data else {
				completion(NSError(domain: "No data recieved", code: -1, userInfo: nil))
				return
			}
			
			do {
				let bearer = try JSONDecoder().decode(Bearer.self, from: data)
				self.bearer = bearer
				completion(nil)
			} catch {
				NSLog("Token not recieved: \(error)")
				completion(error)
				return
			}
		}.resume()
	}
}

