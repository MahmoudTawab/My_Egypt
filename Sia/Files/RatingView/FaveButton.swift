//
//  FaveButton.swift
//  Cargood
//
//  Created by Mahmoud Abd El Tawab on 10/29/19.
//  Copyright © 2019 Mahmoud Abd El Tawab. All rights reserved.
//

import Foundation
import UIKit

precedencegroup ConstrPrecedence {
    associativity: left
    higherThan: AssignmentPrecedence
}

//infix operator >>- { associativity left precedence 160 }
infix operator >>- : ConstrPrecedence


struct Constraint{
    var identifier: String?
    
    #if swift(>=4.2)
    var attribute: NSLayoutConstraint.Attribute = .centerX
    var secondAttribute: NSLayoutConstraint.Attribute = .notAnAttribute
    #else
    var attribute: NSLayoutAttribute = .centerX
    var secondAttribute: NSLayoutAttribute = .notAnAttribute
    #endif
    
    var constant: CGFloat = 0
    var multiplier: CGFloat = 1
    
    #if swift(>=4.2)
    var relation: NSLayoutConstraint.Relation = .equal
    #else
    var relation: NSLayoutRelation = .equal
    #endif
}

#if swift(>=4.2)
func attributes(_ attrs:NSLayoutConstraint.Attribute...) -> [NSLayoutConstraint.Attribute]{
    return attrs
}
#else
func attributes(_ attrs:NSLayoutAttribute...) -> [NSLayoutAttribute]{
return attrs
}
#endif

@discardableResult func >>- <T: UIView> (lhs: (T,T), apply: (inout Constraint) -> () ) -> NSLayoutConstraint {
    var const = Constraint()
    apply(&const)
    
    const.secondAttribute = .notAnAttribute == const.secondAttribute ? const.attribute : const.secondAttribute
    
    let constraint = NSLayoutConstraint(item: lhs.0,
                                        attribute: const.attribute,
                                        relatedBy: const.relation,
                                        toItem: lhs.1,
                                        attribute: const.secondAttribute,
                                        multiplier: const.multiplier,
                                        constant: const.constant)
    
    constraint.identifier = const.identifier
    
    NSLayoutConstraint.activate([constraint])
    return constraint
}


@discardableResult  func >>- <T: UIView> (lhs: T, apply: (inout Constraint) -> () ) -> NSLayoutConstraint {
    var const = Constraint()
    apply(&const)
    
    let constraint = NSLayoutConstraint(item: lhs,
                                        attribute: const.attribute,
                                        relatedBy: const.relation,
                                        toItem: nil,
                                        attribute: const.attribute,
                                        multiplier: const.multiplier,
                                        constant: const.constant)
    constraint.identifier = const.identifier
    
    NSLayoutConstraint.activate([constraint])
    return constraint
}


#if swift(>=4.2)
func >>- <T:UIView> (lhs: (T,T),attributes: [NSLayoutConstraint.Attribute]){
    for attribute in attributes{
        lhs >>- { (i: inout Constraint) in
            i.attribute = attribute
        }
    }
}
#else
func >>- <T:UIView> (lhs: (T,T),attributes: [NSLayoutAttribute]){
for attribute in attributes{
lhs >>- { (i: inout Constraint) in
i.attribute = attribute
}
}
}
#endif

#if swift(>=4.2)
func >>- <T:UIView> (lhs: T, attributes: [NSLayoutConstraint.Attribute]){
    for attribute in attributes{
        lhs >>- { (i: inout Constraint) in
            i.attribute = attribute
        }
    }
}
#else
func >>- <T:UIView> (lhs: T, attributes: [NSLayoutAttribute]){
for attribute in attributes{
lhs >>- { (i: inout Constraint) in
i.attribute = attribute
}
}
}
#endif


typealias Easing        = (_ t:CGFloat,_ b:CGFloat,_ c:CGFloat,_ d:CGFloat)-> CGFloat
typealias ElasticEasing = (_ t:CGFloat,_ b:CGFloat,_ c:CGFloat,_ d:CGFloat,_ a:CGFloat,_ p:CGFloat)-> CGFloat

// ELASTIC EASING

struct Elastic{
    static var EaseIn :Easing    = { (_t,b,c,d) -> CGFloat in
        var t = _t
        
        if t==0{ return b }
        t/=d
        if t==1{ return b+c }
        
        let p = d * 0.3
        let a = c
        let s = p/4
        
        t -= 1
        return -(a*pow(2,10*t) * sin( (t*d-s)*(2*(.pi))/p )) + b;
    }
    
    static var EaseOut :Easing   = { (_t,b,c,d) -> CGFloat in
        var t = _t
        
        if t==0{ return b }
        t/=d
        if t==1{ return b+c}
        
        let p = d * 0.3
        let a = c
        let s = p/4
        
        return (a*pow(2,-10*t) * sin( (t*d-s)*(2*(.pi))/p ) + c + b);
    }
    
    static var EaseInOut :Easing = { (_t,b,c,d) -> CGFloat in
        var t = _t
        if t==0{ return b}
        
        t = t/(d/2)
        if t==2{ return b+c }
        
        let p = d * (0.3*1.5)
        let a = c
        let s = p/4
        
        if t < 1 {
            t -= 1
            return -0.5*(a*pow(2,10*t) * sin((t*d-s)*(2*(.pi))/p )) + b;
        }
        t -= 1
        return a*pow(2,-10*t) * sin( (t*d-s)*(2*(.pi))/p )*0.5 + c + b;
    }
}


extension Elastic{
    static var ExtendedEaseIn :ElasticEasing    = { (_t,b,c,d,_a,_p) -> CGFloat in
        var t = _t
        var a = _a
        var p = _p
        var s:CGFloat = 0.0
        
        if t==0{ return b }
        
        t /= d
        if t==1{ return b+c }
        
        if a < abs(c) {
            a=c;  s = p/4
        }else {
            s = p/(2*(.pi)) * asin (c/a);
        }
        
        t -= 1
        return -(a*pow(2,10*t) * sin( (t*d-s)*(2*(.pi))/p )) + b;
    }
    
    
    static var ExtendedEaseOut :ElasticEasing    = { (_t,b,c,d,_a,_p) -> CGFloat in
        var s:CGFloat = 0.0
        var t = _t
        var a = _a
        var p = _p
        
        if t==0 { return b }
        
        t /= d
        if t==1 {return b+c}
        
        if a < abs(c) {
            a=c;  s = p/4;
        }else {
            s = p/(2*(.pi)) * asin (c/a)
        }
        return (a*pow(2,-10*t) * sin( (t*d-s)*(2*(.pi))/p ) + c + b)
    }
    
    
    static var ExtendedEaseInOut :ElasticEasing    = { (_t,b,c,d,_a,_p) -> CGFloat in
        var s:CGFloat = 0.0
        var t = _t
        var a = _a
        var p = _p
        
        if t==0{ return b }
        
        t /= d/2
        
        if t==2{ return b+c }
        
        if a < abs(c) {
            a=c; s=p/4;
        }else {
            s = p/(2*(.pi)) * asin (c/a)
        }
        
        if t < 1 {
            t -= 1
            return -0.5*(a*pow(2,10*t) * sin( (t*d-s)*(2*(.pi))/p )) + b;
        }
        t -= 1
        return a*pow(2,-10*t) * sin( (t*d-s)*(2*(.pi))/p )*0.5 + c + b;
    }
}



public typealias DotColors = (first: UIColor, second: UIColor)
public protocol FaveButtonDelegate {
    func faveButton(_ faveButton: FaveButton, didSelected selected: Bool)
    func faveButtonDotColors(_ faveButton: FaveButton) -> [DotColors]?
}


// MARK: Default implementation
public extension FaveButtonDelegate {
    func faveButtonDotColors(_ faveButton: FaveButton) -> [DotColors]?{ return nil }
}

open class FaveButton: UIButton {
    
    fileprivate struct Const{
        static let duration             = 1.0
        static let expandDuration       = 0.1298
        static let collapseDuration     = 0.1089
        static let faveIconShowDelay    = Const.expandDuration + Const.collapseDuration/2.0
        static let dotRadiusFactors     = (first: 0.0633, second: 0.04)
    }
    
    
    @IBInspectable open var normalColor: UIColor     = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    @IBInspectable open var selectedColor: UIColor   = #colorLiteral(red: 0.9827597737, green: 0.5565668941, blue: 0.01189385448, alpha: 1)
    @IBInspectable open var dotFirstColor: UIColor   = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
    @IBInspectable open var dotSecondColor: UIColor  = #colorLiteral(red: 1, green: 0.04806254486, blue: 0.06874565804, alpha: 1)
    @IBInspectable open var circleFromColor: UIColor = #colorLiteral(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
    @IBInspectable open var circleToColor: UIColor   = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
    
    @IBOutlet open weak var delegate: AnyObject?
    
    fileprivate(set) var sparkGroupCount: Int = 7
    
    var faveIconImage:UIImage?
    fileprivate var faveIcon: FaveIcon!
    fileprivate var animationsEnabled = true
    
    override open var isSelected: Bool {
        didSet{
            guard self.animationsEnabled else {
                return
            }
            animateSelect(self.isSelected, duration: Const.duration)
        }
    }
    
    convenience public init(frame: CGRect, faveIconNormal: UIImage?) {
        self.init(frame: frame)
        
        guard let icon = faveIconNormal else{
            fatalError("missing image for normal state")
        }
        faveIconImage = icon
        
        applyInit()
    }
    
    override public init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        applyInit()
    }
    
    public func setSelected(selected: Bool, animated: Bool) {
        guard selected != self.isSelected else {
            return
        }
        guard animated == false else {
            self.isSelected = selected
            return
        }
        
        self.animationsEnabled = false
        self.isSelected = selected
        self.animationsEnabled = true
        
        animateSelect(self.isSelected, duration: 0.0) // trigger state change without animation
    }
}


// MARK: create
extension FaveButton{
    fileprivate func applyInit(){
        
        if nil == faveIconImage{
            #if swift(>=4.2)
            faveIconImage = image(for: UIControl.State())
            #else
            faveIconImage = image(for: UIControlState())
            #endif
        }
        
        guard let faveIconImage = faveIconImage else{
            fatalError("please provide an image for normal state.")
        }
        
        #if swift(>=4.2)
        setImage(UIImage(), for: UIControl.State())
        setTitle(nil, for: UIControl.State())
        #else
        setImage(UIImage(), for: UIControlState())
        setTitle(nil, for: UIControlState())
        #endif
        setImage(UIImage(), for: .selected)
        setTitle(nil, for: .selected)
        
        faveIcon  = createFaveIcon(faveIconImage)
        
        addActions()
    }
    
    //////////////////////////////////////////////////////////////////////
    fileprivate func createFaveIcon(_ faveIconImage: UIImage) -> FaveIcon{
        return FaveIcon.createFaveIcon(self, icon: faveIconImage,color: normalColor)
    }
    
    
    fileprivate func createSparks(_ radius: CGFloat) -> [Spark] {
        var sparks    = [Spark]()
        let step      = 360.0/Double(sparkGroupCount)
        let base      = Double(bounds.size.width)
        let dotRadius = (base * Const.dotRadiusFactors.first, base * Const.dotRadiusFactors.second)
        let offset    = 10.0
        
        for index in 0..<sparkGroupCount{
            let theta  = step * Double(index) + offset
            let colors = dotColors(at: index)
            
            let spark  = Spark.createSpark(self, radius: radius, firstColor: colors.first,secondColor: colors.second, angle: theta,
                                           dotRadius: dotRadius)
            sparks.append(spark)
        }
        return sparks
    }
}


// MARK: utils

extension FaveButton{
    fileprivate func dotColors(at index: Int) -> DotColors{
        if case let delegate as FaveButtonDelegate = delegate , nil != delegate.faveButtonDotColors(self){
            let colors     = delegate.faveButtonDotColors(self)!
            let colorIndex = 0..<colors.count ~= index ? index : index % colors.count
            
            return colors[colorIndex]
        }
        return DotColors(self.dotFirstColor, self.dotSecondColor)
    }
}


// MARK: actions
extension FaveButton{
    func addActions(){
        self.addTarget(self, action: #selector(toggle(_:)), for: .touchUpInside)
    }
    
    @objc func toggle(_ sender: FaveButton){
        sender.isSelected = !sender.isSelected
        
        guard case let delegate as FaveButtonDelegate = self.delegate else{
            return
        }
        
        let delay = DispatchTime.now() + Double(Int64(Double(NSEC_PER_SEC) * Const.duration)) / Double(NSEC_PER_SEC)
        DispatchQueue.main.asyncAfter(deadline: delay){
            delegate.faveButton(sender, didSelected: sender.isSelected)
        }
    }
}


// MARK: animation
extension FaveButton {
    fileprivate func animateSelect(_ isSelected: Bool, duration: Double) {
        let color  = isSelected ? selectedColor : normalColor
        
        faveIcon.animateSelect(isSelected, fillColor: color, duration: duration, delay: duration > 0.0 ? Const.faveIconShowDelay : 0.0)
        
        guard duration > 0.0 else {
            return
        }
        
        if isSelected{
            let radius           = bounds.size.scaleBy(1.3).width/2 // ring radius
            let igniteFromRadius = radius*0.8
            let igniteToRadius   = radius*1.1
            
            let ring   = Ring.createRing(self, radius: 0.01, lineWidth: 3, fillColor: self.circleFromColor)
            let sparks = createSparks(igniteFromRadius)
            
            ring.animateToRadius(radius, toColor: circleToColor, duration: Const.expandDuration, delay: 0)
            ring.animateColapse(radius, duration: Const.collapseDuration, delay: Const.expandDuration)
            
            sparks.forEach{
                $0.animateIgniteShow(igniteToRadius, duration:0.4, delay: Const.collapseDuration/3.0)
                $0.animateIgniteHide(0.7, delay: 0.2)
            }
        }
    }
}



class FaveIcon: UIView {
    
    var iconColor: UIColor = .gray
    var iconImage: UIImage!
    var iconLayer: CAShapeLayer!
    var iconMask:  CALayer!
    var contentRegion: CGRect!
    var tweenValues: [CGFloat]?
    
    init(region: CGRect, icon: UIImage, color: UIColor) {
        self.iconColor      = color
        self.iconImage      = icon
        self.contentRegion  = region
        super.init(frame: CGRect.zero)
        
        applyInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: create
extension FaveIcon{
    
    class func createFaveIcon(_ onView: UIView, icon: UIImage, color: UIColor) -> FaveIcon{
        let faveIcon = Init(FaveIcon(region:onView.bounds, icon: icon, color: color)){
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.backgroundColor                           = .clear
        }
        onView.addSubview(faveIcon)
        
        (faveIcon, onView) >>- [.centerX,.centerY]
        
        faveIcon >>- [.width,.height]
        
        return faveIcon
    }
    
    func applyInit(){
        let maskRegion  = contentRegion.size.scaleBy(0.7).rectCentered(at: contentRegion.center)
        let shapeOrigin = CGPoint(x: -contentRegion.center.x, y: -contentRegion.center.y)
        
        
        iconMask = Init(CALayer()){
            $0.contents      = iconImage.cgImage
            $0.contentsScale = UIScreen.main.scale
            $0.bounds        = maskRegion
        }
        
        iconLayer = Init(CAShapeLayer()){
            $0.fillColor = iconColor.cgColor
            $0.path      = UIBezierPath(rect: CGRect(origin: shapeOrigin, size: contentRegion.size)).cgPath
            $0.mask      = iconMask
        }
        
        self.layer.addSublayer(iconLayer)
    }
}


// MARK : animation
extension FaveIcon{
    
    func animateSelect(_ isSelected: Bool = false, fillColor: UIColor, duration: Double = 0.5, delay: Double = 0){
        let animate = duration > 0.0
        
        if nil == tweenValues && animate {
            tweenValues = generateTweenValues(from: 0, to: 1.0, duration: CGFloat(duration))
        }
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        iconLayer.fillColor = fillColor.cgColor
        CATransaction.commit()
        
        let selectedDelay = isSelected ? delay : 0
        
        if isSelected {
            self.alpha = 0
            UIView.animate(
                withDuration: 0,
                delay: selectedDelay,
                options: .curveLinear,
                animations: {
                    self.alpha = 1
            }, completion: nil)
        }
        
        guard animate else {
            return
        }
        
        let scaleAnimation = Init(CAKeyframeAnimation(keyPath: "transform.scale")){
            $0.values    = tweenValues!
            $0.duration  = duration
            $0.beginTime = CACurrentMediaTime()+selectedDelay
        }
        iconMask.add(scaleAnimation, forKey: nil)
    }
    
    
    
    func generateTweenValues(from: CGFloat, to: CGFloat, duration: CGFloat) -> [CGFloat]{
        var values         = [CGFloat]()
        let fps            = CGFloat(60.0)
        let tpf            = duration/fps
        let c              = to-from
        let d              = duration
        var t              = CGFloat(0.0)
        let tweenFunction  = Elastic.ExtendedEaseOut
        
        while(t < d){
            let scale = tweenFunction(t, from, c, d, c+0.001, 0.39988)  // p=oscillations, c=amplitude(velocity)
            values.append(scale)
            t += tpf
        }
        return values
    }
}




extension CGRect{
    var center: CGPoint {
        return CGPoint( x: self.size.width/2.0,y: self.size.height/2.0)
    }
}

extension CGSize{
    func rectCentered(at:CGPoint) -> CGRect{
        let dx = self.width/2
        let dy = self.height/2
        let origin = CGPoint(x: at.x - dx, y: at.y - dy )
        return CGRect(origin: origin, size: self)
    }
    
    func scaleBy(_ factor:CGFloat) -> CGSize{
        return CGSize(width: self.width*factor, height: self.height*factor)
    }
}

extension Double {
    var degrees: Double {
        return self * (.pi) / 180.0
    }
    
    var radians: Double {
        return self * 180.0 / (.pi)
    }
}



internal func Init<T>( _ object: T, block: (T) throws -> ()) rethrows -> T{
    try block(object)
    return object
}



class Ring: UIView {
    
    fileprivate struct Const{
        static let collapseAnimation = "collapseAnimation"
        static let sizeKey           = "sizeKey"
    }
    
    var fillColor: UIColor!
    var radius: CGFloat!
    var lineWidth: CGFloat!
    var ringLayer: CAShapeLayer!
    
    init(radius: CGFloat, lineWidth:CGFloat, fillColor: UIColor) {
        self.fillColor = fillColor
        self.radius    = radius
        self.lineWidth = lineWidth
        super.init(frame: CGRect.zero)
        
        applyInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: create
extension Ring{
    
    class func createRing(_ faveButton: FaveButton, radius: CGFloat, lineWidth: CGFloat, fillColor: UIColor) -> Ring{
        
        let ring = Init(Ring(radius: radius, lineWidth:lineWidth, fillColor: fillColor)){
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.backgroundColor                           = .clear
        }
        
        faveButton.superview?.insertSubview(ring, belowSubview: faveButton)
        
        (ring,faveButton) >>- [.centerX, .centerY]
        
        attributes(.width, .height).forEach{ attr in
            ring >>- {
                $0.attribute  = attr
                $0.constant   = radius * 2
                $0.identifier = Const.sizeKey
            }
        }
        
        return ring
    }
    
    
    fileprivate func applyInit(){
        let centerView = Init(UIView(frame: CGRect.zero)){
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.backgroundColor                           = .clear
        }
        self.addSubview(centerView)
        
        (centerView, self) >>- [ .centerY, .centerX ]
        
        centerView >>- [.width, .height]
        
        let circle = createRingLayer(radius, lineWidth: lineWidth, fillColor: .clear, strokeColor: fillColor)
        centerView.layer.addSublayer(circle)
        
        self.ringLayer = circle
    }
    
    
    fileprivate func createRingLayer(_ radius: CGFloat, lineWidth: CGFloat, fillColor: UIColor, strokeColor: UIColor) -> CAShapeLayer{
        let circle = UIBezierPath(arcCenter: CGPoint.zero, radius: radius - lineWidth/2, startAngle: 0, endAngle: 2*(.pi), clockwise: true)
        
        let ring = Init(CAShapeLayer()){
            $0.path         = circle.cgPath
            $0.fillColor    = fillColor.cgColor
            $0.lineWidth    = 0
            $0.strokeColor  = strokeColor.cgColor
        }
        return ring
    }
}

// MARK : animation
extension Ring{
    
    func animateToRadius(_ radius: CGFloat, toColor: UIColor, duration: Double, delay: Double = 0){
        self.layoutIfNeeded()
        
        self.constraints.filter{ $0.identifier == Const.sizeKey }.forEach{
            $0.constant = radius * 2
        }
        
        let fittedRadius = radius - lineWidth/2
        
        let fillColorAnimation  = animationFillColor(self.fillColor, toColor: toColor, duration: duration, delay: delay)
        let lineWidthAnimation  = animationLineWidth(lineWidth, duration: duration, delay: delay)
        let lineColorAnimation  = animationStrokeColor(toColor, duration: duration, delay: delay)
        let circlePathAnimation = animationCirclePath(fittedRadius, duration: duration, delay: delay)
        
        UIView.animate(
            withDuration: duration,
            delay: delay,
            options: .curveLinear,
            animations: {
                self.layoutIfNeeded()
        }, completion: nil)
        
        
        ringLayer.add(fillColorAnimation, forKey: nil)
        ringLayer.add(lineWidthAnimation, forKey: nil)
        ringLayer.add(lineColorAnimation, forKey: nil)
        ringLayer.add(circlePathAnimation, forKey: nil)
    }
    
    
    func animateColapse(_ radius: CGFloat, duration: Double, delay: Double = 0){
        let lineWidthAnimation  = animationLineWidth(0, duration: duration, delay: delay)
        let circlePathAnimation = animationCirclePath(radius, duration: duration, delay: delay)
        
        circlePathAnimation.delegate = self
        circlePathAnimation.setValue(Const.collapseAnimation, forKey: Const.collapseAnimation)
        
        ringLayer.add(lineWidthAnimation, forKey: nil)
        ringLayer.add(circlePathAnimation, forKey: nil)
    }
    
    
    fileprivate func animationFillColor(_ fromColor:UIColor, toColor: UIColor, duration: Double, delay: Double = 0) -> CABasicAnimation{
        let animation = Init(CABasicAnimation(keyPath: "fillColor")){
            $0.fromValue      = fromColor.cgColor
            $0.toValue        = toColor.cgColor
            $0.duration       = duration
            $0.beginTime      = CACurrentMediaTime() + delay
            #if swift(>=4.2)
            $0.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
            #else
            $0.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            #endif
            
        }
        
        return animation
    }
    
    
    fileprivate func animationStrokeColor(_ strokeColor: UIColor, duration: Double, delay: Double) -> CABasicAnimation{
        let animation = Init(CABasicAnimation(keyPath: "strokeColor")){
            $0.toValue             = strokeColor.cgColor
            $0.duration            = duration
            $0.beginTime           = CACurrentMediaTime() + delay
            #if swift(>=4.2)
            $0.fillMode            = CAMediaTimingFillMode.forwards
            $0.timingFunction      = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
            #else
            $0.fillMode            = kCAFillModeForwards
            $0.timingFunction      = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            #endif
            $0.isRemovedOnCompletion = false
            
        }
        return animation
    }
    
    
    fileprivate func animationLineWidth(_ lineWidth: CGFloat, duration: Double, delay: Double = 0) -> CABasicAnimation{
        let animation = Init(CABasicAnimation(keyPath: "lineWidth")){
            $0.toValue              = lineWidth
            $0.duration             = duration
            $0.beginTime            = CACurrentMediaTime() + delay
            $0.isRemovedOnCompletion  = false
            #if swift(>=4.2)
            $0.fillMode             = CAMediaTimingFillMode.forwards
            $0.timingFunction       = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
            #else
            $0.fillMode             = kCAFillModeForwards
            $0.timingFunction       = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            #endif
        }
        return animation
    }
    
    
    fileprivate func animationCirclePath(_ radius: CGFloat, duration: Double, delay: Double) -> CABasicAnimation{
        let path = UIBezierPath(arcCenter: CGPoint.zero, radius: radius, startAngle: 0, endAngle: 2*(.pi), clockwise: true)
        
        let animation = Init(CABasicAnimation(keyPath: "path")){
            $0.toValue              = path.cgPath
            $0.duration             = duration
            $0.beginTime            = CACurrentMediaTime() + delay
            $0.isRemovedOnCompletion  = false
            #if swift(>=4.2)
            $0.fillMode             = CAMediaTimingFillMode.forwards
            $0.timingFunction       = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
            #else
            $0.fillMode             = kCAFillModeForwards
            $0.timingFunction       = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseOut)
            #endif
        }
        return animation
    }
}


// MARK: CAAnimationDelegate
extension Ring : CAAnimationDelegate{
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if let _ = anim.value(forKey: Const.collapseAnimation){
            self.removeFromSuperview()
        }
    }
}



internal typealias DotRadius = (first: Double, second: Double)

class Spark: UIView {
    
    fileprivate struct Const{
        static let distance           = (vertical: 4.0, horizontal: 0.0)
        static let expandKey          = "expandKey"
        static let dotSizeKey         = "dotSizeKey"
    }
    
    
    var radius: CGFloat
    var firstColor: UIColor
    var secondColor: UIColor
    var angle: Double
    
    var dotRadius: DotRadius!
    
    fileprivate var dotFirst:  UIView!
    fileprivate var dotSecond: UIView!
    
    
    fileprivate var distanceConstraint: NSLayoutConstraint?
    
    init(radius: CGFloat, firstColor: UIColor, secondColor: UIColor, angle: Double, dotRadius: DotRadius){
        self.radius      = radius
        self.firstColor  = firstColor
        self.secondColor = secondColor
        self.angle       = angle
        self.dotRadius   = dotRadius
        super.init(frame: CGRect.zero)
        
        applyInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: create
extension Spark{
    
    class func createSpark(_ faveButton: FaveButton, radius: CGFloat, firstColor: UIColor, secondColor: UIColor, angle: Double, dotRadius: DotRadius) -> Spark{
        
        let spark = Init(Spark(radius: radius, firstColor: firstColor, secondColor: secondColor, angle: angle, dotRadius: dotRadius)){
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.backgroundColor                           = .clear
            $0.layer.anchorPoint                         = CGPoint(x: 0.5, y: 1)
            $0.alpha                                     = 0.0
        }
        faveButton.superview?.insertSubview(spark, belowSubview: faveButton)
        
        (spark, faveButton) >>- [.centerX, .centerY]
        
        let width = CGFloat((dotRadius.first * 2.0 + dotRadius.second * 2.0) + Const.distance.horizontal)
        spark >>- {
            $0.attribute  = .width
            $0.constant   =  width
        }
        
        let height = CGFloat(Double(radius) + (dotRadius.first * 2.0 + dotRadius.second * 2.0))
        spark >>- {
            $0.attribute  = .height
            $0.constant   =  height
            $0.identifier =  Const.expandKey
        }
        
        return spark
    }
    
    
    fileprivate func applyInit(){
        dotFirst  = createDotView(dotRadius.first,  fillColor: firstColor)
        dotSecond = createDotView(dotRadius.second, fillColor: secondColor)
        
        
        (dotFirst, self) >>- [.trailing]
        attributes(.width, .height).forEach{ attr in
            dotFirst >>- {
                $0.attribute  = attr
                $0.constant   = CGFloat(dotRadius.first * 2.0)
                $0.identifier = Const.dotSizeKey
            }
        }
        
        (dotSecond,self) >>- [.leading]
        attributes(.width,.height).forEach{ attr in
            dotSecond >>- {
                $0.attribute  = attr
                $0.constant   = CGFloat(dotRadius.second * 2.0)
                $0.identifier = Const.dotSizeKey
            }
        }
        
        (dotSecond,self) >>- {
            $0.attribute = .top
            $0.constant  = CGFloat(dotRadius.first * 2.0 + Const.distance.vertical)
        }
        
        distanceConstraint = (dotFirst, dotSecond) >>- {
            $0.attribute       = .bottom
            $0.secondAttribute = .top
            $0.constant        =  0
        }
        
        self.transform = CGAffineTransform(rotationAngle: CGFloat(angle.degrees))
    }
    
    
    fileprivate func createDotView(_ radius: Double, fillColor: UIColor) -> UIView{
        let dot = Init(UIView(frame: CGRect.zero)){
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.backgroundColor                           = fillColor
            $0.layer.cornerRadius                        = CGFloat(radius)
        }
        
        self.addSubview(dot)
        return dot
    }
    
}

// MARK: animation
extension Spark{
    func animateIgniteShow(_ radius: CGFloat, duration:Double, delay: Double = 0){
        self.layoutIfNeeded()
        
        let diameter = (dotRadius.first * 2.0) + (dotRadius.second * 2.0)
        let height   = CGFloat(Double(radius) + diameter + Const.distance.vertical)
        
        if let constraint = self.constraints.filter({ $0.identifier == Const.expandKey }).first{
            constraint.constant = height
        }
        
        UIView.animate(withDuration: 0, delay: delay, options: .curveLinear, animations: {
            self.alpha = 1
        }, completion: nil)
        
        UIView.animate(withDuration: duration * 0.7, delay: delay, options: .curveEaseOut, animations: {
            self.layoutIfNeeded()
        }, completion: nil)
    }
    
    
    func animateIgniteHide(_ duration: Double, delay: Double = 0){
        self.layoutIfNeeded()
        distanceConstraint?.constant = CGFloat(-Const.distance.vertical)
        
        UIView.animate(
            withDuration: duration*0.5,
            delay: delay,
            options: .curveEaseOut,
            animations: {
                self.layoutIfNeeded()
        }, completion: { succeed in
        })
        
        UIView.animate(
            withDuration: duration,
            delay: delay,
            options: .curveEaseOut,
            animations: {
                self.dotSecond.backgroundColor = self.firstColor
                self.dotFirst.backgroundColor  = self.secondColor
        }, completion: nil)
        
        
        for dot in [dotFirst, dotSecond]{
            dot?.setNeedsLayout()
            dot?.constraints.filter{ $0.identifier == Const.dotSizeKey }.forEach{
                $0.constant = 0
            }
        }
        
        UIView.animate(
            withDuration: duration,
            delay: delay,
            options: .curveEaseOut,
            animations: {
                self.dotSecond.layoutIfNeeded()
        }, completion:nil)
        
        
        UIView.animate(
            withDuration: duration*1.7,
            delay: delay ,
            options: .curveEaseOut,
            animations: {
                self.dotFirst.layoutIfNeeded()
        }, completion: { succeed  in
            
            self.removeFromSuperview()
        })
    }
}

