//
//  KeyLoader.swift
//  Climatiz
//
//  Created by Joel Lacerda on 07/08/25.
//

import Foundation

struct KeyLoader {
    static func getAPIKey() -> String {
        guard let url = Bundle.main.url(forResource: "Secrets", withExtension: "plist"),
              let data = try? Data(contentsOf: url),
              let plist = try? PropertyListSerialization.propertyList(from: data, options: [], format: nil) as? [String: Any],
              let apiKey = plist["API_KEY"] as? String else {
            fatalError("Could not find API_KEY in Secrets.plist. Please check your configuration.")
        }
        return apiKey
    }
}
