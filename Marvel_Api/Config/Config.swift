//
//  Config.swift
//  Marvel_Api
//
//  Created by Kaan İzgi on 15.01.2022.
//

import Foundation
import CryptoSwift
import UIKit


struct App {
    static var serviceurl = "https://gateway.marvel.com/v1/public/"
    static var privatekey = "e45f18f713d2f5dfdb69f3d8e5b717d0822421a8"
    static var publickey = "0fdcc109eb22482e45a584a06a8fd3ca"
    static var hash = "\(ts)\(privatekey)\(publickey)".md5()
    static var ts = "\(Int((Date().timeIntervalSince1970 * 1000.0).rounded()))"
}


