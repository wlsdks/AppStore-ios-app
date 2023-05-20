//
//  Feature.swift
//  AppStore
//
//  Created by 최진안 on 2023/05/20.
//

import Foundation

struct Feature: Decodable {
    let type: String
    let appName: String
    let description: String
    let imageURL: String
}
