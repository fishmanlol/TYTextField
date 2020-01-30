//
//  CountryListController+.swift
//  TYTextField
//
//  Created by tongyi on 12/31/19.
//  Copyright © 2019 Yi Tong. All rights reserved.
//

import Foundation

//MARK: - Datasource
extension CountryListController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        let country = countries[indexPath.row]
        configure(cell, with: country)
        return cell
    }
}

//MARK: - Delegate
extension CountryListController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let country = countries[indexPath.row]
        onComplete?(country)
        dismiss(animated: true, completion: nil)
    }
}

//MARK: - Private
extension CountryListController {
    private func configure(_ cell: UITableViewCell, with country: Country) {
        cell.textLabel?.text = country.fullNameAndCodeString()
        if country == selectedCountry {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
    }
}
