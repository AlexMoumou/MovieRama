//
//  Environment.swift
//  MovieRama
//
//  Created by Alex Moumoulidis on 1/12/23.
//

import Foundation

public enum Environment {
    enum Keys {
        static let apiKey = "API_KEY"
        static let baseUrl = "BASE_URL"
    }
    
    private static let infoDictionary: [String: Any] = {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("info.plist was not found!")
        }
        return dict
    }()
    
    static let apikey: String = {
        guard let apiKeyStr = Environment.infoDictionary[Keys.apiKey] as? String else {
            fatalError("You need to set a value for API_KEY in info plist!")
        }
        return apiKeyStr
    }()
    
    static let baseUrl: URL = {
        guard let baseUrlStr = Environment.infoDictionary[Keys.baseUrl] as? String, let baseURL = URL(string: baseUrlStr) else {
            fatalError("You need to set a valid url as string for BASE_URL in info plist!")
        }
        return baseURL
    }()
}
