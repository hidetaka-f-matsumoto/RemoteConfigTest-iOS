//
//  CurrentUser.swift
//  RemoteConfigTest
//
//  Created by Hidetaka Matsumoto on 2022/08/14.
//

import Foundation

class CurrentUser {
    var instanceId = ""

    private init() {}

    static let shared = CurrentUser()
}
