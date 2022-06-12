//
//  Environment.swift
//  BoubyanTask
//
//  Created by Ahmed Samir on 11/06/2022.
//

import Foundation

public enum Environment {
    
    // MARK: - Keys
    enum Keys {
        enum Plist {
            static let baseURL = "BASE_URL"
        }
    }
    
    // MARK: - Plist
    private static let infoDictionary: [String: Any] = {
        guard let value = Bundle.main.infoDictionary else {
            fatalError("Plist file not found")
        }
        return value
    }()
    
    // MARK: - Plist values
    static let baseURL: URL = {
        guard let value = Environment.infoDictionary[Keys.Plist.baseURL] as? String else {
            fatalError("Base URL not set in plist for this environment")
        }
        return URL(string: value)!
    }()
    
    // MARK: - API KEY
    static let apiKey: String = {
        return "Ed6eNgq5SaGa5kfnINudR3qRFG4nByOJ"
    }()
}
