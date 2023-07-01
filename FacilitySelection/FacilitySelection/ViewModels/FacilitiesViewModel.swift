//
//  FacilitiesViewModel.swift
//  FacilitySelection
//
//  Created by Richa Kalani on 28/06/23.
//

import Foundation

class FacilitiesViewModel: NSObject {
    private var apiService: APIService!
    private(set) var facilitesData: FacilitySelection! {
        didSet {
            self.bindViewModelToController()
        }
    }
    var bindViewModelToController: (() -> ()) = {}
    
    override init() {
        super.init()
        self.apiService = APIService()
        getFacilitiesData()
        
    }
    
    func getFacilitiesData() {
        self.apiService.apiCallToGetFacilitiesData { (data) in
            self.facilitesData = data
        }
    }
}
