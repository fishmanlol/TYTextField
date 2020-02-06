//
//  TYPhoneTextField.swift
//  TYTextField
//
//  Created by Yi Tong on 12/23/19.
//  Copyright © 2019 Yi Tong. All rights reserved.
//
import PhoneNumberKit

public class TYPhoneTextField: TYNormalTextField {
    private weak var areaView: UIView!
    private weak var areaButton: UIButton!
    private weak var areaLine: UIView!
    private var areaDefaultAttributes: [NSAttributedString.Key: Any] = [:]
    private var canSetLeftView = true
    private let phoneNumberKit = PhoneNumberKit()
    private var country = Country.default {
        didSet {
            didCountryUpdate()
        }
    }
    
    //MARK: - Public
    public var countryCode: String {
        return String(country.code)
    }
    
    public var regionCode: String {
        return country.shortName
    }
    
    public var onlyNumber: String {
        return text?.onlyNumber() ?? ""
    }
    
    public var phoneNumber: String {
        return "+" + countryCode + " " + onlyNumber
    }
    
    public var isValidPhoneNumber: Bool {
        return (try? phoneNumberKit.parse(onlyNumber, withRegion: regionCode, ignoreType: false)) != nil
    }
    
    //MARK: - initialization
     public override init(frame: CGRect) {
         super.init(frame: frame)
         
         setUp()
     }
     
     required init?(coder aDecoder: NSCoder) {
         fatalError()
     }
    
    //MARK: - Overrides
    override func createTextField(frame: CGRect) -> _TextField {
        let _tf = _TextField(frame: frame, type: .phone)
        _tf.addTarget(self, action: #selector(didEditingChanged), for: .editingChanged)
        return _tf
    }
    
    override public var leftView: UIView? {
        didSet {
            didChangeLeftView()
        }
    }
    
    //MARK: - Action
    @objc func didEditingChanged(tf: _TextField) {
        formatText(in: tf)
    }
    
    @objc func didAreaButtonTapped() {
        guard let vc = getFirstViewControllerResponder() else { return }
        let countryListController = CountryListController(selectedCountry: country)
        countryListController.onComplete = { [weak self] (country) in
            guard let weakSelf = self else { return }
            weakSelf.country = country
        }
        
        let countryListNav = UINavigationController(rootViewController: countryListController)
        vc.present(countryListNav, animated: true, completion: nil)
    }
    
    @objc func didCountryUpdate() {
        areaButton.setAttributedTitle(NSAttributedString(string: country.shortNameAndCodeString(), attributes: areaDefaultAttributes), for: .normal)
        
            if self._textField.isFirstResponder {
                let _ = self._textField.resignFirstResponder()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    let _ = self._textField.becomeFirstResponder()
                }
            } else {
                let _ = self._textField.becomeFirstResponder()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    let _ = self._textField.resignFirstResponder()
                }
            }
        
        formatText(in: _textField)
    }
    
     //MARK: - Helpers
     private func setUp() {
        leftView = createAreaView()
        keyboardType = .numberPad
    }
    
    private func formatText(in textField: _TextField) {
        let formatted = formattedNationalPhoneNumber(nationalPhoneNumber: onlyNumber, with: regionCode)
        textField.text = formatted
    }
    
    private func formattedNationalPhoneNumber(nationalPhoneNumber: String, with region: String) -> String {
        guard let phoneNumber = try? phoneNumberKit.parse(onlyNumber, withRegion: region, ignoreType: false) else {
            return onlyNumber
        }
        
        let formatted = phoneNumberKit.format(phoneNumber, toType: .national)
        
        guard formatted.onlyNumber() == onlyNumber else {
            return onlyNumber
        }
        
        return formatted
    }
    
    private func getFirstViewControllerResponder() -> UIViewController? {
        var n: UIResponder? = self
        
        while n != nil && !(n! is UIViewController) {
            n = n?.next
        }
        
        if n is UIViewController {
            return n as? UIViewController
        }
        
        return nil
    }
    
    private func createAreaView() -> UIView {
        let areaView = UIView()
        self.areaView = areaView
        
        let button = UIButton(type: .system)
        button.sizeToFit()
        button.setAttributedTitle(NSAttributedString(string: country.shortNameAndCodeString(), attributes: areaDefaultAttributes), for: .normal)
        button.addTarget(self, action: #selector(didAreaButtonTapped), for: .touchUpInside)
        self.areaButton = button
        areaView.addSubview(button)
        
        let line = UIView()
        line.backgroundColor = .gray
        self.areaLine = line
        areaView.addSubview(line)
        
        button.snp.makeConstraints { (make) in
            make.left.top.bottom.equalToSuperview()
            make.right.equalToSuperview().inset(2)
        }
        
        line.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.top.equalToSuperview().inset(2)
            make.bottom.equalToSuperview().inset(4)
            make.width.equalTo(1)
        }
        
        return areaView
    }
    
    //only can be set once in TYPasswordTextField
    private func didChangeLeftView() {
        if canSetLeftView {
            super.leftView = leftView
            canSetLeftView = false
        } else {
            print("You can not set leftView in TYPhoneTextField")
        }
    }
}

