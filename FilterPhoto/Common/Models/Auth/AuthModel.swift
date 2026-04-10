//
//  AuthModel.swift
//  FilterPhoto
//
//  Created by Grigory G. on 01.06.23.
//

// MARK: - Auth Models
struct SignupRequest: OptionalEncodable {
    let email: String
    let password: String
}

struct SignupResponse: Decodable {
    //
}
