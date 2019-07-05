//
//  UserData.swift
//  ThingsToDoRealm
//
//  Created by Sunil Gurung on 1/7/19.
//  Copyright © 2019 Sunil Gurung. All rights reserved.
//

import Foundation
import RealmSwift

class UserObject: Object {
    @objc dynamic var name = ""
    @objc dynamic var address = ""
}
