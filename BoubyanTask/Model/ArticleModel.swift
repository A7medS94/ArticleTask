//
//  ArticleModel.swift
//  BoubyanTask
//
//  Created by Ahmed Samir on 11/06/2022.
//

import Foundation

// MARK: - ArticleModel
class ArticleModel: Codable {
    let uri: String?
    let url: URL?
    let id, asset_id: Int?
    let published_date, updated, section, subsection: String?
    let nytdsection, adx_keywords: String?
    let byline: String?
    let title, abstract: String?
    let des_facet, org_facet, per_facet, geo_facet: [String]?
    let media: [Media]?
    let eta_id: Int?
}

class Media: Codable {
    let type: String?
    let metaData: [MediaData]?
    
    enum CodingKeys: String, CodingKey {
        case type
        case metaData = "media-metadata"
    }
}

class MediaData: Codable {
    let url: URL?
}
