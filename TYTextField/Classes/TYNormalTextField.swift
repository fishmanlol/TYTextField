//
//  TYTextField.swift
//  TYTextField
//
//  Created by Yi Tong on 12/23/19.
//  Copyright © 2019 Yi Tong. All rights reserved.
//
import SnapKit

public class TYNormalTextField: UIView {
    internal weak var _textField: _TextField!
    internal var hasLabel = false
    internal lazy var label: UILabel = {
        let label = createLabel()
        hasLabel = true
        return label
    }()
    
    //MARK: - Public properties
    public weak var delegate: TYTextFieldDelegate?
    
    //MARK: - Label
    public var labelColor: UIColor? {
        didSet {
            updateLabelColor()
        }
    }
    
    public var labelText: String? {
        didSet {
            updateLabelText()
        }
    }
    
    public var labelFont: UIFont? {
        didSet {
            updateLabelFont()
        }
    }
    
    public var labelAttributedText: NSAttributedString? {
        didSet {
            updateLabelAttributedText()
        }
    }
    
    //MARK: - Left and right view
    public var leftView: UIView? {
        didSet {
            didChangeLeftView()
        }
    }
    
    public var rightView: UIView? {
        didSet {
            didChangeRightView()
        }
    }
    
    public var clearButtonMode: UITextField.ViewMode = .never {
        didSet {
            didChangeClearButtonMode()
        }
    }
    
    //MARK: - Border
    ///No effect for TYPinCodeTextField
    public var borderStyle: BorderStyle = .singleLine {
        didSet {
            _textField._borderStyle = borderStyle
        }
    }
    
    public var borderWidth: CGFloat = 1 {
        didSet {
            _textField._borderWidth = borderWidth
        }
    }
    
    //MARK: - Color
    public var colorWhenNormal: UIColor? {
        didSet {
            updateLabelColor()
            _textField.colorWhenNormal = colorWhenNormal
        }
    }
    
    public var colorWhenEditing: UIColor? {
        didSet {
            updateLabelColor()
            _textField.colorWhenEditing = colorWhenEditing
        }
    }
    
    //MARK: - Text
    public var text: String? {
        set {
            _textField.text = newValue
        }
        
        get {
            return _textField.text
        }
    }
    
    ///Use **colorWhenNormal** or **colorWhenEditing** make textColor change along with editing state
    public var textColor: UIColor? {
        set {
            _textField._textColor = newValue
        }
        
        get {
            return _textField.textColor
        }
    }
    
    public var textFont: UIFont? {
        set {
            _textField.font = newValue
        }
        
        get {
            return _textField.font
        }
    }
    
    public var attributedText: NSAttributedString? {
        set {
            _textField.attributedText = newValue
        }
        
        get {
            return _textField.attributedText
        }
    }
    
    public var autocorrectionType: UITextAutocorrectionType = .default {
        didSet {
            _textField.autocorrectionType = autocorrectionType
        }
    }
    
    public var autocapitalizationType: UITextAutocapitalizationType = .none {
        didSet {
            _textField.autocapitalizationType = autocapitalizationType
        }
    }
    
    public var keyboardType: UIKeyboardType = .default {
        didSet {
            _textField.keyboardType = keyboardType
        }
    }
    
    public var returnKeyType: UIReturnKeyType = .default {
        didSet {
            _textField.returnKeyType = returnKeyType
        }
    }
    
    public var textContentType: UITextContentType! {
        get {
            return _textField.textContentType
        }
        
        set {
            _textField.textContentType = newValue
        }
    }
    
    public override func becomeFirstResponder() -> Bool {
        return _textField.becomeFirstResponder()
    }

    public override func resignFirstResponder() -> Bool {
        return _textField.resignFirstResponder()
    }
    
    public override var isFirstResponder: Bool {
        return _textField.isFirstResponder
    }
    
    public override var tintColor: UIColor! {
        didSet {
            _textField.tintColor = tintColor
        }
    }
    
    //MARK: - Size
    public override var intrinsicContentSize: CGSize {
        let (width, height) = subviews.reduce((0, 0)) { (max($0.0,  $1.intrinsicContentSize.width), $0.1 + $1.intrinsicContentSize.height) }
        return CGSize(width: width, height: height)
    }
    //MARK: - Initializations
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUp(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    //MARK: - Helpers
    private func setUp(frame: CGRect) {
        self._textField = createTextField(frame: frame)
        _textField._delegate = self
        _textField.delegate = self
        _textField.setContentCompressionResistancePriority(.required, for: .horizontal)
        addSubview(_textField)
        _textField.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    private func updateLabelColor() {
        if isFirstResponder {
            label.textColor = labelColor ?? colorWhenEditing ?? colorWhenNormal ?? UIColor.black
        } else {
            label.textColor = labelColor ?? colorWhenNormal ?? UIColor.black
        }
    }
    
    private func updateLabelText() {
        label.text = labelText
    }
    
    private func updateLabelFont() {
        label.font = labelFont
    }
    
    private func updateLabelAttributedText() {
        label.attributedText = labelAttributedText
    }
    
    private func didChangeLeftView() {
        if leftView == nil {
            _textField.leftView = nil
            _textField.leftViewMode = .never
        } else {
            _textField.leftView = leftView
            _textField.leftViewMode = .always
        }
    }
    
    private func didChangeRightView() {
        if rightView == nil {
            _textField.rightView = nil
            _textField.rightViewMode = .never
        } else {
            _textField.rightView = rightView
            _textField.rightViewMode = .always
        }
    }
    
    private func didChangeClearButtonMode() {
        _textField.clearButtonMode = clearButtonMode
    }
    
    ///Subclass override this function for TYPinCodeText to provide customize textField
    func createTextField(frame: CGRect) -> _TextField {
        let tf = _TextField(frame: frame, type: .normal)
        return tf
    }
    
    private func createLabel() -> UILabel {
        let label = UILabel()
        self.label = label
        addSubview(label)
        
        label.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview()
        }
        
        return label
    }
    
    public enum BorderStyle {
        case rounded
        case singleLine
        case none
    }
}

//MARK: - _TextFieldDelegate
extension TYNormalTextField: _TextFieldDelegate {
    func _textFieldPinCodeComplete(_ textField: _TextField) {
        delegate?.pinCodeTextFieldDidComplete(self as! TYPinCodeTextField)
    }
    
    //Change label color along with editing state if labelColor nil
    func _textFieldDidBecomeFirstResponder(_ textField: _TextField) {
        if labelColor == nil {
            label.textColor = colorWhenEditing ?? colorWhenNormal
        }
    }
    
    //Change label color along with editing state if labelColor nil
    func _textFieldDidResignFirstResponder(_ textField: _TextField) {
        if labelColor == nil {
            label.textColor = colorWhenNormal
        }
    }
}

//MARK: - UITextFieldDelgate
extension TYNormalTextField: UITextFieldDelegate {
    public func textFieldDidEndEditing(_ textField: UITextField) {
        delegate?.textFieldDidEndEditing(self)
    }
    
    public func textFieldDidBeginEditing(_ textField: UITextField) {
        delegate?.textFieldDidBeginEditing(self)
    }
    
    public func textFieldDidChangeSelection(_ textField: UITextField) {
        delegate?.textFieldDidChangeSelection(self)
    }
    
    public func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return delegate?.textFieldShouldClear(self) ?? true
    }
    
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return delegate?.textFieldShouldReturn(self) ?? true
    }
    
    public func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        return delegate?.textFieldShouldEndEditing(self) ?? true
    }
    
    public func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return delegate?.textFieldShouldEndEditing(self) ?? true
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
        delegate?.textFieldDidEndEditing(self)
    }
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        return delegate?.textField(self, shouldChangeCharactersIn: range, replacementString: string) ?? true
    }
}

extension UIView {
    func pinToInside(subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[subview]|", metrics: nil, views: ["subview": subview]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[subview]|", metrics: nil, views: ["subview": subview]))
    }
}
