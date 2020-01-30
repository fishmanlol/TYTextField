//
//  TYPasswordTextField.swift
//  TYTextField
//
//  Created by Yi Tong on 12/23/19.
//  Copyright © 2019 Yi Tong. All rights reserved.
//

public class TYPasswordTextField: TYNormalTextField {
    private weak var hideButton: UIButton!
    private var canSetRightView = true
    
    var hide: Bool = true {
        didSet {
            didChangeState()
        }
    }
    
    override func createTextField(frame: CGRect) -> _TextField {
        return _TextField(frame: frame, type: .password)
    }
    
    public override var rightView: UIView? {
        didSet {
            didChangeRightView()
        }
    }
    
    //MARK: - initialization
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    //MARK: - Helpers
    private func setUp() {
        rightView = createHideButton()
        hide = true
    }
    
    private func createHideButton() -> UIButton {
        let button = UIButton(type: .system)
        button.addTarget(self, action: #selector(didTapHideButton), for: .touchUpInside)
        button.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        self.hideButton = button
        return button
    }
    
    private func didChangeState() {
        if hide {
            hideButton.setTitle("show", for: .normal)
            _textField.isSecureTextEntry = true
        } else {
            hideButton.setTitle("hide", for: .normal)
            _textField.isSecureTextEntry = false
        }
    }
    
    //only can be set once in TYPasswordTextField
    private func didChangeRightView() {
        if canSetRightView {
            super.rightView = rightView
            canSetRightView = false
        } else {
            print("You can not set rightView in TYPasswordTextField")
        }
    }
    
    @objc private func didTapHideButton(button: UIButton) {
        hide = !hide
    }
}
