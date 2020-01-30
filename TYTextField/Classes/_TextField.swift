//
//  _TextField.swift
//  TYTextField
//
//  Created by Yi Tong on 12/23/19.
//  Copyright © 2019 Yi Tong. All rights reserved.
//
import CoreGraphics

class _TextField: UITextField {
    //MARK: - Properties
    weak var _delegate: _TextFieldDelegate?
    let type: TYTextFieldType
    //MARK: - pin code
    internal var pinCodeCount: UInt
    internal var lineLength: CGFloat = 20
    internal var currentIndex: Int? {//Before and include current index will be rendered as tintcolor
        didSet {
            setNeedsDisplay()
        }
    }
    
    internal var _font: UIFont = UIFont.monospacedDigitSystemFont(ofSize: 17, weight: .regular) {
        didSet {
            setNeedsDisplay()
        }
    }
    
    //MARK: - style
    internal var _borderStyle: TYNormalTextField.BorderStyle = .singleLine {
        didSet {
            setNeedsDisplay()
        }
    }
    
    internal var colorWhenNormal: UIColor? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    internal var colorWhenEditing: UIColor? {
        didSet {
            setNeedsDisplay()
        }
    }
    
    internal var _borderWidth: CGFloat = 1 {
        didSet {
            setNeedsDisplay()
        }
    }
    
    internal var _textColor: UIColor? {
        didSet {
            textColor = _textColor
        }
    }
    
    //MARK: - initialization
    init(frame: CGRect, type: TYTextFieldType, pinCodeCount: UInt = 0) {
        self.type = type
        self.pinCodeCount = pinCodeCount
        super.init(frame: frame)
        self.addTarget(self, action: #selector(editingChanged), for: .editingChanged)
        self.addTarget(self, action: #selector(editingDidBegin), for: .editingDidBegin)
        self.addTarget(self, action: #selector(editingDidEnd), for: .editingDidEnd)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    //MARK: - Overrides
    override func draw(_ rect: CGRect) {
        if type == .pinCode {//draw pin code style
            //set kern
            let kern = caculateKern(in: rect, count: pinCodeCount)
            setDefaultTextAttribute(key: .kern, value: kern)
            setDefaultTextAttribute(key: .font, value: _font)
            
            let paths = bottomSegementsPaths(in: rect)
            unwrappedNormalColor().setStroke()
            paths.forEach { $0.stroke() }
            
            if isFirstResponder, let currentIndex = currentIndex {
                unwrappedEditingColor().setStroke()
                for i in 0..<paths.count  where i <= currentIndex {
                    paths[i].stroke()
                }
            }
            
            return
        }
        
        if _borderStyle == .singleLine { //Single line style
            let (start, end) = caculateStartEndPoint(in: rect)
            let path = UIBezierPath()

            path.move(to: start)
            path.addLine(to: end)
            path.lineWidth = _borderWidth
            
            if isFirstResponder {
                unwrappedEditingColor().setStroke()
            } else {
                unwrappedNormalColor().setStroke()
            }
            
            path.stroke()
            
            return
        }
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.editingRect(forBounds: bounds)
        if type == .pinCode {
            let offsetX = (lineLength - monospacedDigitSize().width) * 0.5
            return CGRect(x: rect.origin.x + offsetX, y: rect.origin.y, width: rect.width + 1000, height: rect.height)
        }
        
        if type == .phone {
            let space: CGFloat = 6
            return CGRect(x: rect.origin.x + space,
                          y: rect.origin.y,
                          width: rect.width - space, height: rect.height)
        }
        
        return rect
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        let rect = super.textRect(forBounds: bounds)
        if type == .pinCode {
            let offsetX = (lineLength - monospacedDigitSize().width) * 0.5
            
            return CGRect(x: rect.origin.x + offsetX, y: rect.origin.y, width: rect.width + 1000, height: rect.height)
        }
        
        if type == .phone {
            let space: CGFloat = 6
            return CGRect(x: rect.origin.x + space,
                          y: rect.origin.y,
                          width: rect.width - space, height: rect.height)
        }
        
        return rect
    }
    
    override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        if type == .phone {
            return CGRect(x: 0, y: 0, width: caculateLeftViewWidth(), height: bounds.height)
        }
        
        return super.leftViewRect(forBounds: bounds)
    }
    
    //MARK: - Actions
    @objc func editingChanged(_ textField: _TextField) {
        if type == .pinCode { //pin code specific code
            let count = textField.text?.count ?? 0
            currentIndex = count
    
            if currentIndex! >= Int(pinCodeCount) { //reached the limit
                _delegate?._textFieldPinCodeComplete(self)
                endEditing(true)
            }
            
            return
        }
        
        setNeedsDisplay()
    }
    
    @objc func editingDidBegin(_ textField: _TextField) {
        _delegate?._textFieldDidBecomeFirstResponder(self)
        
        //set textColor
        if _textColor == nil {
            textColor = unwrappedEditingColor()
        }
        
        if type == .pinCode { //pin code specific code
            //discard the last one if reached the limit
            let str = text?.prefix(Int(pinCodeCount) - 1) ?? ""
            text = String(str)
            currentIndex = text?.count ?? 0
            return
        }
        
        setNeedsDisplay()
    }
    
    @objc func editingDidEnd(_ textField: _TextField) {
        _delegate?._textFieldDidResignFirstResponder(self)
        
        //set textColor
        if _textColor == nil {
            textColor = unwrappedNormalColor()
        }
        
        if type == .pinCode { //pin code specific code
            currentIndex = (text?.count ?? 0) - 1
            return
        }
        
        setNeedsDisplay()
    }
    
    //MARK: - Helpers
    private func caculateLeftViewWidth() -> CGFloat {
        if let leftView = leftView {
            for subview in leftView.subviews where subview is UIButton {
                let button = subview as! UIButton
                if let currentAttributedTitle = button.currentAttributedTitle {
                    let label = UILabel()
                    label.attributedText = currentAttributedTitle
                    label.sizeToFit()
                    
                    return label.bounds.width + 10
                }
            }
        }
        
        return 0
    }
    
    private func unwrappedNormalColor() -> UIColor {
        return colorWhenNormal ?? UIColor.black
    }
    
    private func unwrappedEditingColor() -> UIColor {
        return colorWhenEditing ?? unwrappedNormalColor()
    }
    
    private func monospacedDigitSize() -> CGSize {
        let dummy = NSAttributedString(string: "0", attributes: [NSAttributedString.Key.font: _font])
        return dummy.size()
    }
    
    private func caculateKern(in rect: CGRect, count: UInt) -> CGFloat {
        guard count > 1 else { return 0 }
        let segements = bottomSegements(in: rect)
        //distance between bottom line
        let q = CGPoint.distance(lhs: segements[0].start, rhs: segements[1].start)
        //width of a character
        let p = monospacedDigitSize().width
        return q - p
    }
    
    private func bottomSegementsPaths(in rect: CGRect) -> [UIBezierPath] {
        return bottomSegements(in: rect).map { line in
            let path = UIBezierPath()
            path.move(to: line.start)
            path.addLine(to: line.end)
            return path
        }
    }
    
    private func bottomSegements(in rect: CGRect) -> [Line] {
        guard pinCodeCount > 0 else { return [] }
        var lines: [Line] = []
        let (start, end) = caculateStartEndPoint(in: rect)
        let bottomLine = Line(start: start, end: end)
        let gapLength = (bottomLine.length - CGFloat(pinCodeCount) * lineLength) / CGFloat(pinCodeCount - 1)
        var segementStart = start
        var segementEnd = start
        for _ in 0..<Int(pinCodeCount) {
            segementEnd = segementStart + CGPoint(x: lineLength, y: 0)
            lines.append(Line(start: segementStart, end: segementEnd))
            segementStart = segementEnd + CGPoint(x: gapLength, y: 0)
        }
        return lines
    }
    
    private func caculateStartEndPoint(in rect: CGRect) -> (CGPoint, CGPoint) {
        return (CGPoint(x: rect.minX, y: rect.maxY - _borderWidth), CGPoint(x: rect.maxX, y: rect.maxY - _borderWidth))
    }
    
    private func setDefaultTextAttribute(key: NSAttributedString.Key, value: Any) {
        defaultTextAttributes[key.rawValue] = value
    }
    
    //MARK: - TYTextFieldType enum
    enum TYTextFieldType {
        case normal
        case password
        case phone
        case pinCode
    }
    
    //MARK: - Line struct
    struct Line: CustomStringConvertible {
        var description: String {
            get {
                "(\(start.x), \(start.y)) -> (\(end.x), \(end.y))"
            }
        }
        
        var start: CGPoint
        var end: CGPoint
        var k: CGFloat? {
            if end.x == start.x {
                return nil
            } else {
                return (end.y - start.y) / (end.x - start.x)
            }
        }
        var length: CGFloat {
            return sqrt((end.x - start.x) * (end.x - start.x) + (end.y - start.y) * (end.y - start.y))
        }
        
        func slice(count: UInt) -> [Line] {
            var lines: [Line] = []
            
            let deltaX = (end.x - start.x) / CGFloat(count)
            let deltaY = (end.y - start.y) / CGFloat(count)
            var tempStart = start
            for _ in 0..<count {
                let tempEnd = CGPoint(x: tempStart.x + deltaX, y: tempStart.y + deltaY)
                lines.append(Line(start: tempStart, end: tempEnd))
                tempStart = tempEnd
            }
            
            return lines
        }
        
        mutating func extend(_ length: CGFloat, anchor: Anchor) {
            switch anchor {
            case .start:
                endExtend(length)
            case .end:
                startExtend(length)
            case .center:
                centerExtend(length)
            }
        }
        
        mutating func extend(to length: CGFloat, anchor: Anchor) {
            switch anchor {
            case .start:
                endExtend(to: length)
            case .end:
                startExtend(to: length)
            case .center:
                centerExtend(to: length)
            }
        }
        
        private mutating func endExtend(_ length: CGFloat) {
            guard let k = k else {
                end = CGPoint(x: end.x, y: end.y + length)
                return
            }
            
            let f: CGFloat = length > 0 ? 1 : -1
            let deltaX = sqrt(length * length / (k*k + 1)) * f
            let deltaY = deltaX * k * f
            
            end = CGPoint(x: end.x + deltaX, y: end.y + deltaY)
        }
        
        private mutating func startExtend(_ length: CGFloat) {
            guard let k = k else {
                start = CGPoint(x: start.x, y: start.y + length)
                return
            }
            
            let f: CGFloat = length > 0 ? 1 : -1
            let deltaX = sqrt(length * length / (k*k + 1)) * f
            let deltaY = deltaX * k * f
            
            start = CGPoint(x: start.x - deltaX, y: start.y - deltaY)
        }
        
        private mutating func centerExtend(_ length: CGFloat) {
            let halfLength = length / 2
            startExtend(halfLength)
            endExtend(halfLength)
        }
        
        private mutating func endExtend(to length: CGFloat) {
            guard let k = k else {
                end = CGPoint(x: end.x, y: end.y > 0 ? length : -length)
                return
            }
            
            let f: CGFloat = length > 0 ? 1 : -1
            let deltaX = sqrt(length * length / (k*k + 1)) * f
            let deltaY = deltaX * k * f
            
            end = CGPoint(x: start.x + deltaX, y: start.y + deltaY)
        }
        
        private mutating func startExtend(to length: CGFloat) {
            guard let k = k else {
                start = CGPoint(x: start.x, y: start.y > 0 ? length : -length)
                return
            }
            
            let f: CGFloat = length > 0 ? 1 : -1
            let deltaX = sqrt(length * length / (k*k + 1)) * f
            let deltaY = deltaX * k * f
            
            start = CGPoint(x: end.x - deltaX, y: end.y - deltaY)
        }
        
        private mutating func centerExtend(to length: CGFloat) {
            let shrink = (self.length - length) / 2
            startExtend(-shrink)
            endExtend(-shrink)
        }
        
        //MARK: - Anchor
        ///The anchor will hold when line extend
        enum Anchor {
            case start
            case end
            case center
        }
    }
}

//MARK: - CGPoint extension
extension CGPoint {
    static func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    
    static func -(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
    
    static func distance(lhs: CGPoint, rhs: CGPoint) -> CGFloat {
        return sqrt((rhs.y - lhs.y) * (rhs.y - lhs.y) + (rhs.x - lhs.x) * (rhs.x - lhs.x))
    }
}
