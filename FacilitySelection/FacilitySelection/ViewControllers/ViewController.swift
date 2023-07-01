//
//  ViewController.swift
//  FacilitySelection
//
//  Created by Richa Kalani on 28/06/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var tableView: UITableView!
    private var facilitiesViewModel: FacilitiesViewModel!
    @IBOutlet weak var button: UIButton!
    var facilitesDataSource: [[Any]]? = [[]]
    var currentSectionIndex = 0
    var selectedFacilities: Facility?
    var selectedFacilitiesArray: [Facility?] = []
    var exclustionsDataSource: [[Exclusion]] = []
    var selectedFacilityId: String? = ""
    var selectionOptionId: String? = ""
    var excludedFacilityId: String? = ""
    var excludedOptionId: String? = ""
    var selectedContents: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.register(UINib(nibName: "FacilitiesTableViewCell", bundle: nil), forCellReuseIdentifier: FacilitiesTableViewCell.facilitiesTableViewCellId)
        button.isHidden = true
        callToGetApiResponse()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let index = self.tableView.indexPathForSelectedRow{
            self.tableView.deselectRow(at: index, animated: true)
        }
    }
    
    
    @IBAction func nextButtonAction(_ sender: Any) {
        if currentSectionIndex < ((facilitesDataSource?.first?.count ?? 3)-1) {
            currentSectionIndex = currentSectionIndex + 1
            self.updateUI()
        } else {
            let alert = UIAlertController(title: "Alert", message: "You have selected \(selectedContents[0]) with \(selectedContents[1]) and \(selectedContents[2])", preferredStyle: .alert)
            self.present(alert, animated: true)
            
        }
        
    }
    
    func callToGetApiResponse() {
        self.facilitiesViewModel = FacilitiesViewModel()
        self.facilitiesViewModel.bindViewModelToController = {
            self.updateDataSource()
            DispatchQueue.main.async {
                self.updateUI()
            }
        }
    }
    
    func updateDataSource() {
        self.facilitesDataSource = [self.facilitiesViewModel.facilitesData.facilities]
        self.exclustionsDataSource = self.facilitiesViewModel.facilitesData.exclusions
        selectedFacilities = facilitesDataSource?[0][currentSectionIndex] as? Facility
        selectedFacilitiesArray.append(selectedFacilities)
    }
    
    //MARK: TableView delegate and datasource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let facilities = selectedFacilitiesArray as? [Facility], facilities.isEmpty == false {
            let options = facilities[section].options
            return options.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FacilitiesTableViewCell.facilitiesTableViewCellId) as? FacilitiesTableViewCell
        if let facilities = selectedFacilitiesArray as? [Facility], facilities.isEmpty == false {
            let options = facilities[indexPath.section].options
            cell?.nameLabel.text = options[indexPath.row].name
            cell?.iconImageView.image = UIImage(named: options[indexPath.row].icon)
            cell?.backgroundColor = .white
            self.button.isUserInteractionEnabled = false
            self.button.isEnabled = false
            if selectedContents.isEmpty == false {
                for contentName in selectedContents {
                    if contentName == cell?.nameLabel.text {
                        cell?.backgroundColor = .systemGray4
                    }
                }
                
            }
        }
        return cell ?? FacilitiesTableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return selectedFacilitiesArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if let facilities = selectedFacilitiesArray as? [Facility], facilities.isEmpty == false {
            let facility = facilities[section]
            let header = "Please select \(facility.name)"
            return header
        }
        return ""
    }
    
    func updateUI() {
        
        if currentSectionIndex < facilitesDataSource?.first?.count ?? 3 {
            if currentSectionIndex > 0 {
                selectedFacilities = facilitesDataSource?[0][currentSectionIndex] as? Facility
                selectedFacilitiesArray.append(selectedFacilities)
                
            }
            for section in selectedFacilitiesArray {
                if section?.facilityID == self.excludedFacilityId {
                    selectedFacilitiesArray = selectedFacilitiesArray.map { section in
                        guard let originalSection = section else {
                            return nil
                        }
                        let updatedOptions = originalSection.options.filter { option in
                            option.id != excludedOptionId
                        }
                        let updatedSection = Facility(facilityID: originalSection.facilityID, name: originalSection.name, options: updatedOptions)
                        return updatedSection
                    }.compactMap { $0 }
                }
            }
            self.tableView.reloadData()
            self.setButtonProperties(title: "Next")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedFacilityId = selectedFacilitiesArray[indexPath.section]?.facilityID
        self.selectionOptionId = selectedFacilitiesArray[indexPath.section]?.options[indexPath.row].id
        for section in exclustionsDataSource {
            if selectedFacilityId == section[0].facilityID && selectionOptionId == section[0].optionsID {
                excludedFacilityId = section[1].facilityID
                excludedOptionId = section[1].optionsID
            }
        }
        self.selectedContents.append(selectedFacilitiesArray[indexPath.section]?.options[indexPath.row].name ?? "")
        self.button.isUserInteractionEnabled = true
        self.button.isEnabled = true
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        self.selectedFacilityId = nil
        self.selectionOptionId = nil
        self.excludedFacilityId = nil
        self.excludedOptionId = nil
        self.selectedContents.removeLast()
        self.updateUI()
    }
    
    func setButtonProperties(title: String) {
        self.button.isHidden = false
        self.button.setTitle(title, for: .normal)
    }
}
    
    
