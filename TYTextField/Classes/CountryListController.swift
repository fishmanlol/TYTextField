//
//  AreaListController.swift
//  TYTextField
//
//  Created by tongyi on 12/31/19.
//  Copyright © 2019 Yi Tong. All rights reserved.
//
import PhoneNumberKit

class CountryListController: UITableViewController {
    
    var selectedCountry: Country?
    var countries: [Country] = []
    let phoneNumberKit = PhoneNumberKit()
    let cellID = "COUNTRYCELL"
    var onComplete: ((Country) -> Void)?
    
    //MARK: - Initialization
    init(selectedCountry: Country? = nil) {
        self.selectedCountry = selectedCountry
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUp()
    }
    
    //MARK: - Action
    @objc func didDoneItemTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Private
    private func setUp() {
        view.backgroundColor = .white
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(didDoneItemTapped))
        navigationItem.title = "Country List"
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        
        countries = getCouontries()
    }
    
    private func getCouontries() -> [Country] {
        let pairs = getCountryShortAndFullNamePairs()
        var countries: [Country] = []
        
        for (fullName, shortName) in pairs {
            if let code = phoneNumberKit.countryCode(for: shortName) {
                countries.append(Country(code: Int(code), fullName: fullName, shortName: shortName))
            }
        }
        
        return countries
    }
    
    private func getCountryShortAndFullNamePairs() -> [(String, String)] {
        
        guard let path = Bundle.current.path(forResource: "countries", ofType: nil) else {
            return []
        }
        
        var countryPair: [(String, String)] = []
        
        if let contents = try? String(contentsOfFile: path, encoding: .utf8) {
            let countries = contents.components(separatedBy: .newlines)
            
            for country in countries {
                let countryItem = country.components(separatedBy: "----")
                if countryItem.count == 2 {
                    countryPair.append((countryItem[0], countryItem[1]))
                }
            }
        }
        
        return countryPair
    }
}

