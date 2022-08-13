//
//  Article.swift
//  RemoteConfigTest
//
//  Created by Hidetaka Matsumoto on 2022/08/13.
//

import Foundation


struct Article: Decodable {
    var title: String
    var message: String
    var imageUrl: String
}
