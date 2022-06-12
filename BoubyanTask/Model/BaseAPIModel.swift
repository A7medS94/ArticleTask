//
//  BaseAPIModel.swift
//  BoubyanTask
//
//  Created by Ahmed Samir on 11/06/2022.
//

import Foundation

class BaseAPIModel<T:Codable>: Codable {
    let status, copyright: String?
    let num_results: Int?
    let results: T?
}
