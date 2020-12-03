//
//  ErrorMessage.swift
//  Followers
//
//  Created by Jorge Enrique Bautista Ocampo on 2020-12-02.
//

import Foundation

enum JBError: String, Error {
    case invalidUsername = "This username created an invalid request, please try again"
    case unableToComplete = "Unable to complete your request. Please check your connection"
    case invalidResponse = "Invalid response from the server, please try again"
    case invalidData = "Data received from the server was invalid. Please try again"
}
