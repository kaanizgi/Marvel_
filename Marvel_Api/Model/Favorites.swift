//
//  Favorites.swift
//  Marvel_Api
//
//  Created by Kaan İzgi on 16.01.2022.
//

import Foundation
import RealmSwift

class Favorite: Object {
    @objc dynamic var id = ""
    @objc dynamic var name = ""
    @objc dynamic var thumbnail = ""
    @objc dynamic var detail = ""
}
