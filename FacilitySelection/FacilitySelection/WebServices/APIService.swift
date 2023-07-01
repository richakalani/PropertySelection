//
//  APIService.swift
//  FacilitySelection
//
//  Created by Richa Kalani on 28/06/23.
//

import Foundation

class APIService: NSObject {
    private let sourceURL = URL(string: "https://my-json-server.typicode.com/iranjith4/ad-assignment/db")
    
    func apiCallToGetFacilitiesData(completion: @escaping(FacilitySelection) -> ()) {
        URLSession.shared.dataTask(with: sourceURL!) { data, response, error in
            if let data = data {
                let jsonDecoder = JSONDecoder()
                let facilityData = try! jsonDecoder.decode(FacilitySelection.self, from: data)
                completion(facilityData)
                
            }
        }.resume()
    }
}
