//
//  UIView+Additions.swift
//  Gumbo
//
//  Created by Michael Westbrooks on 7/18/18.
//  Copyright © 2018 RedRooster Technologies Inc. All rights reserved.
//

import UIKit

extension UIView {
  
  static var identifier: String {
    return String(describing: self)
  }
  
  // Using a function since `var image` might conflict with an existing variable
  // (like on `UIImageView`)
  var asImage: UIImage {
    if #available(iOS 10.0, *) {
      let renderer = UIGraphicsImageRenderer(bounds: bounds)
      return renderer.image { rendererContext in
        layer.render(in: rendererContext.cgContext)
      }
    }
    else {
      UIGraphicsBeginImageContext(self.frame.size)
      self.layer.render(in:UIGraphicsGetCurrentContext()!)
      let image = UIGraphicsGetImageFromCurrentImageContext()
      UIGraphicsEndImageContext()
      return UIImage(cgImage: image!.cgImage!)
    }
  }
  
  func loadNib(nibName: String) -> UIView {
    let bundle = Bundle(for: type(of: self))
    //let nibName = type(of: self).description().components(separatedBy: ".").last!
    let nib = UINib(nibName: nibName, bundle: bundle)
    return nib.instantiate(withOwner: self, options: nil).first as! UIView
  }
  
  func addGradientLayer(using colors: [CGColor]) {
    applyClipsToBounds(true)
    self.backgroundColor = .clear
    let gradientLayer = CAGradientLayer()
    gradientLayer.frame = self.bounds
    gradientLayer.colors = colors
    //  gradientLayer.locations = [0.0, 1.0]
    gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
    gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)
    guard let button = self as? UIButton else {
      self.layer.insertSublayer(gradientLayer,
                                at: 0)
      return
    }
    button.layer.insertSublayer(gradientLayer,
                                below: button.imageView?.layer)
  }
  
  func applyBorder(color: UIColor) {
    self.layer.borderColor = color.cgColor
  }
  
  func applyBorder(width: CGFloat) {
    self.layer.borderWidth = width
  }
  
  func applyBorder(withColor color: UIColor, andThickness width: CGFloat) {
    self.layer.borderColor = color.cgColor
    self.layer.borderWidth = width
  }
  
  func applyCornerRadius(_ radius: CGFloat = 0.50) {
    applyClipsToBounds(true)
    self.layer.cornerRadius = self.frame.height * radius
  }
  
  func applyClipsToBounds(_ bool: Bool = true) {
    self.clipsToBounds = bool
  }
  
  func applyMaskToBounds(_ bool: Bool = true) {
    self.layer.masksToBounds = bool
  }
  
  public func convertToImage() -> UIImage {
    UIGraphicsBeginImageContext(bounds.size)
    drawHierarchy(in: bounds, afterScreenUpdates: false)
    let image = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return image!
  }
  
  public func applyTopCornerStyle(_ cornerRadius: CGFloat) {
    let maskPath = UIBezierPath(roundedRect: self.bounds,
                                byRoundingCorners: [.topLeft, .topRight],
                                cornerRadii: CGSize(width: cornerRadius,
                                                    height: cornerRadius))
    let maskLayer = CAShapeLayer()
    maskLayer.frame = self.bounds
    maskLayer.path = maskPath.cgPath
    self.layer.mask = maskLayer
  }
  
  public func applyBottomCornerStyle(_ cornerRadius: CGFloat) {
    let maskPath = UIBezierPath(roundedRect: self.bounds,
                                byRoundingCorners: [.bottomLeft, .bottomRight],
                                cornerRadii: CGSize(width: cornerRadius,
                                                    height: cornerRadius))
    let maskLayer = CAShapeLayer()
    maskLayer.frame = self.bounds
    maskLayer.path = maskPath.cgPath
    self.layer.mask = maskLayer
  }
  
  enum LayoutDirection {
    case horizontal
    case vertical
  }
  
  @objc func clear() {
    subviews.forEach { (view) in
      view.removeFromSuperview()
    }
  }
  
  public func makeHeightZero() {
    let verticalSpaceConstraint = self.superview!.constraints.filter({(constraint) -> Bool in
      return constraint.secondItem as? UIView == self && constraint.secondAttribute == NSLayoutConstraint.Attribute.bottom
    }).first
    
    let superViewHeightConstraint = self.superview!.constraints.filter({(constraint) -> Bool in
      return constraint.firstAttribute == NSLayoutConstraint.Attribute.height
    }).first
    
    superViewHeightConstraint?.constant -= verticalSpaceConstraint?.constant ?? 0 + self.frame.height
    verticalSpaceConstraint?.constant = 0
    
    let heightConstraint = self.constraints.filter({(constraint) -> Bool in
      return constraint.firstAttribute == NSLayoutConstraint.Attribute.height
    }).first
    if heightConstraint != nil {self.removeConstraint(heightConstraint!)}
    
    let constH = NSLayoutConstraint(item: self,
                                    attribute: NSLayoutConstraint.Attribute.height,
                                    relatedBy: NSLayoutConstraint.Relation.equal,
                                    toItem: nil,
                                    attribute: NSLayoutConstraint.Attribute.notAnAttribute,
                                    multiplier: 1, constant: 0)
    
    self.addConstraint(constH)
    self.isHidden = true
  }
  
  public func removeHeightConstraint() {
    let constHt = self.constraints.filter { $0.firstAttribute == .height}.first
    if let htConstFound = constHt {
      self.removeConstraint(htConstFound)
    }
  }
  
  public func setHeightConstraint(constant: CGFloat) {
    removeHeightConstraint()
    let constH = NSLayoutConstraint(item: self,
                                    attribute: .height,
                                    relatedBy: .equal,
                                    toItem: nil,
                                    attribute: .notAnAttribute,
                                    multiplier: 1,
                                    constant: constant)
    self.addConstraint(constH)
  }
  
  @objc public func addSubViewWithFillConstraints(_ subView: UIView) {
    addSubview(subView)
    fillConstraintsWithConstants(subView)
  }
  
  public func addSubViewAtCenter(_ subView: UIView) {
    addSubview(subView)
    constraintView(subView, forAttribute: .centerX)
    constraintView(subView, forAttribute: .centerY)
    constraintView(subView, forAttribute: .height)
    constraintView(subView, forAttribute: .width)
  }
  
  public func centerSubView(_ subView: UIView) {
    addSubview(subView)
    constraintView(subView, forAttribute: .centerX)
    constraintView(subView, forAttribute: .centerY)
    constraintView(subView, forAttribute: .height)
  }
  
  func constraintAdjacentSubviews(firstView: UIView,
                                  secondView: UIView,
                                  spacing: CGFloat = 0,
                                  priority: UILayoutPriority = .required,
                                  direction: LayoutDirection) {
    var const = NSLayoutConstraint()
    
    switch direction {
      case .horizontal:
        const = NSLayoutConstraint(item: firstView,
                                   attribute: .trailing,
                                   relatedBy: .equal,
                                   toItem: secondView,
                                   attribute: .leading,
                                   multiplier: 1,
                                   constant: 0)
      case .vertical:
        const = NSLayoutConstraint(item: firstView,
                                   attribute: .bottom,
                                   relatedBy: .equal,
                                   toItem: secondView,
                                   attribute: .top,
                                   multiplier: 1,
                                   constant: 0)
    }
    
    const.priority = priority
    addConstraint(const)
  }
  
  public func fillConstraintsWithConstants(_ target: UIView,
                                           leading: CGFloat = 0,
                                           trailing: CGFloat = 0,
                                           top: CGFloat = 0,
                                           bottom: CGFloat = 0) {
    constraintView(target, forAttribute: .leading, constant: leading)
    constraintView(target, forAttribute: .top, constant: top)
    constraintView(target, forAttribute: .trailing, constant: trailing)
    constraintView(target, forAttribute: .bottom, constant: bottom)
  }
  
  public func constraintView(_ target: UIView,
                             forAttribute attrib: NSLayoutConstraint.Attribute,
                             multiplier: CGFloat = 1,
                             constant: CGFloat = 0,
                             priority: UILayoutPriority = .required ) {
    let constraint = NSLayoutConstraint(item: target,
                                        attribute: attrib,
                                        relatedBy: .equal,
                                        toItem: self,
                                        attribute: attrib,
                                        multiplier: multiplier,
                                        constant: constant)
    constraint.priority = priority
    addConstraint(constraint)
  }
  
  public func removeAllConstraintsInGraph() {
    self.subviews.forEach {(view) in
      view.removeAllConstraintsInGraph()
    }
    self.constraints.forEach { (constraint) in
      self.removeConstraint(constraint)
    }
  }
}

@objc extension UIView {
  public func constraint(_ view: UIView) -> Constraint {
    return Constraint(self, view: view)
  }
  
}

@objc public class Constraint: NSObject {
  let view: UIView
  let superView: UIView
  
  public init(_ superView: UIView, view: UIView) {
    self.view = view
    self.superView = superView
    
    self.view.translatesAutoresizingMaskIntoConstraints = false
  }
  
  // MARK: Align Top Edges
  
  @discardableResult public func alignTopEdges(by constant: CGFloat, priority: UILayoutPriority) -> Self {
    removeConstraints(onView: view, forAttributes: [.top])
    superView.constraintView(view, forAttribute: .top, constant: constant, priority: priority)
    return self
  }
  
  @objc @discardableResult public func alignTopEdges(by constant: CGFloat) -> Self {
    return alignTopEdges(by: constant, priority: .required)
  }
  
  @objc @discardableResult public func alignTopEdges() -> Self {
    return alignTopEdges(by: 0, priority: .required)
  }
  
  // MARK: Align Bottom Edges
  
  @discardableResult public func alignBottomEdges(by constant: CGFloat, priority: UILayoutPriority) -> Self {
    removeConstraints(onView: view, forAttributes: [.bottom])
    superView.constraintView(view, forAttribute: .bottom, constant: constant, priority: priority)
    return self
  }
  
  @objc @discardableResult public func alignBottomEdges(by constant: CGFloat) -> Self {
    return alignBottomEdges(by: constant, priority: .required)
  }
  
  @objc @discardableResult public func alignBottomEdges() -> Self {
    return alignBottomEdges(by: 0, priority: .required)
  }
  
  // MARK: Align Left Edges
  
  @discardableResult public func alignLeftEdges(by constant: CGFloat, priority: UILayoutPriority) -> Self {
    removeConstraints(onView: view, forAttributes: [.leading])
    superView.constraintView(view, forAttribute: .leading, constant: constant, priority: priority)
    return self
  }
  
  @objc @discardableResult public func alignLeftEdges(by constant: CGFloat) -> Self {
    return alignLeftEdges(by: constant, priority: .required)
  }
  
  @objc @discardableResult public func alignLeftEdges() -> Self {
    return alignLeftEdges(by: 0, priority: .required)
  }
  
  // MARK: Align Right Edges
  
  @discardableResult public func alignRightEdges(by constant: CGFloat, priority: UILayoutPriority) -> Self {
    removeConstraints(onView: view, forAttributes: [.trailing])
    superView.constraintView(view, forAttribute: .trailing, constant: constant, priority: priority)
    return self
  }
  
  @objc @discardableResult public func alignRightEdges(by constant: CGFloat) -> Self {
    return alignRightEdges(by: constant, priority: .required)
  }
  
  @objc @discardableResult public func alignRightEdges() -> Self {
    return alignRightEdges(by: 0, priority: .required)
  }
  
  // MARK: Center
  
  @discardableResult public func center() -> Self {
    return self.centerHorizontally().centerVertically()
  }
  
  @discardableResult public func centerHorizontally() -> Self {
    return centerHorizontally(offset: 0)
  }
  
  @discardableResult public func centerHorizontally(offset: CGFloat) -> Self {
    superView.constraintView(view, forAttribute: .centerX, constant: offset)
    return self
  }
  
  @objc @discardableResult public func centerVertically() -> Self {
    return centerVertically(offset: 0)
  }
  
  @discardableResult public func centerVertically(offset: CGFloat) -> Self {
    superView.constraintView(view, forAttribute: .centerY, constant: offset)
    return self
  }
  
  // MARK: Fit and Fill
  
  @discardableResult public func fill(top: CGFloat, bottom: CGFloat, left: CGFloat, right: CGFloat) -> Constraint {
    superView.fillConstraintsWithConstants(view, leading: left, trailing: right, top: top, bottom: bottom)
    return Constraint(superView, view: view)
  }
  
  @discardableResult public func fill() -> Constraint {
    return fill(top: 0, bottom: 0, left: 0, right: 0)
  }
  
  @discardableResult public func fitContent() -> Constraint {
    let priority = UILayoutPriority(UILayoutPriority.defaultLow.rawValue + 1.0)
    view.setContentHuggingPriority(priority, for: .horizontal)
    view.setContentHuggingPriority(priority, for: .vertical)
    return Constraint(superView, view: view)
  }
  
  // MARK: Size
  
  @objc @discardableResult public func width(_ constant: CGFloat) -> Constraint {
    return constrain(attribute: .width, to: constant, relatedBy: .equal)
  }
  
  @discardableResult public func minWidth(_ constant: CGFloat) -> Constraint {
    return constrain(attribute: .width, to: constant, relatedBy: .greaterThanOrEqual)
  }
  
  @objc @discardableResult public func height(_ constant: CGFloat) -> Constraint {
    return constrain(attribute: .height, to: constant)
  }
  
  @discardableResult public func minHeight(_ constant: CGFloat) -> Constraint {
    return constrain(attribute: .height, to: constant, relatedBy: .greaterThanOrEqual)
  }
  
  @objc @discardableResult public func heightToWidth(multiplier: CGFloat) -> Self {
    removeConstraints(onView: view, forAttributes: [.height])
    view.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: multiplier).isActive = true
    return self
  }
  
  @discardableResult public func matchParentWidth() -> Self {
    removeConstraints(onView: view, forAttributes: [.width])
    superView.constraintView(view, forAttribute: .width, constant: 0)
    return self
  }
  
  // MARK: Place Next
  
  @discardableResult public func placeNext(_ nextView: UIView, by constant: CGFloat, priority: UILayoutPriority) -> Constraint {
    superView.constraintAdjacentSubviews(firstView: view, secondView: nextView, spacing: constant, priority: priority, direction: .horizontal)
    return Constraint(superView, view: nextView)
  }
  
  @discardableResult public func placeNext(_ nextView: UIView, priority: UILayoutPriority) -> Constraint {
    return placeNext(nextView, by: 0, priority: priority)
  }
  
  @discardableResult public func placeNext(_ nextView: UIView) -> Constraint {
    return placeNext(nextView, by: 0, priority: .required)
  }
  
  // MARK: Place Above
  
  @discardableResult public func placeAbove(_ lowerView: UIView, by constant: CGFloat, priority: UILayoutPriority) -> Constraint {
    superView.constraintAdjacentSubviews(firstView: view, secondView: lowerView, spacing: constant, priority: priority, direction: .vertical)
    return Constraint(superView, view: lowerView)
  }
  
  @discardableResult public func placeAbove(_ lowerView: UIView) -> Constraint {
    return placeAbove(lowerView, by: 0, priority: .required)
  }
  
  // MARK: Remove Constraints
  
  private func removeConstraints(onView view: UIView, forAttributes: [NSLayoutConstraint.Attribute]) {
    forAttributes.forEach { (attrib) in
      let const = view.constraints.filter {$0.firstAttribute == attrib}
      superView.removeConstraints(const)
    }
  }
  
  // MARK: Internal helpers
  
  private func constrain(attribute: NSLayoutConstraint.Attribute, to value: CGFloat, relatedBy relation: NSLayoutConstraint.Relation = .equal) -> Constraint {
    removeConstraints(onView: view, forAttributes: [attribute])
    view.addConstraint(NSLayoutConstraint(item: view,
                                          attribute: attribute,
                                          relatedBy: relation,
                                          toItem: nil,
                                          attribute: .notAnAttribute,
                                          multiplier: 1, constant: value))
    return Constraint(superView, view: view)
  }
}

extension UIView {
  func applyPrimaryGradient() {
    let array: [UIColor] = [.gradientColor1, .gradientColor2, .gradientColor3]
    let colorArray: [CGColor] = array.map { color in
      return color.cgColor
    }
    addGradientLayer(using: colorArray)
  }
}

extension UIView {
  static var bundle: Bundle? {
    let podBundle = Bundle(for: self)
    guard let bundleURL = podBundle.url(forResource: "Darkhorse-iOS", withExtension: "bundle") else { return nil }
    return Bundle(url: bundleURL)
  }
  
  static func loadNib(nibName: String = String(describing: self)) -> UIView {
    let bundle = Bundle(for: type(of: self) as! AnyClass)
    //let nibName = type(of: self).description().components(separatedBy: ".").last!
    let nib = UINib(nibName: nibName, bundle: bundle)
    return nib.instantiate(withOwner: self, options: nil).first as! UIView
  }
}


// MARK: - Global Toast for Map View or any other view

public extension UIView {
  
//  private struct ToastKeys {
//    static var toastAreEmpty = "sfmap.toast.toastAreEmpty"
//    static var currentToastTag = "sfmap.toast.currentToastTag"
//    static var activeToasts = "sfmap.toast.activeToasts"
//    static var queue = "sfmap.toast.queue"
//  }
//
//  struct ToastStyle {
//    public init() {}
//
//    public var backgroundColor: UIColor = UIColor.black.withAlphaComponent(0.8)
//    public var titleColor: UIColor = .white
//    public var messageColor: UIColor = .white
//
//    public var titleAlignment: NSTextAlignment = .left
//    public var messageAlignment: NSTextAlignment = .left
//    public var titleFont: UIFont = .boldSystemFont(ofSize: 16.0)
//    public var messageFont: UIFont = .systemFont(ofSize: 16.0)
//
//    public var titleNumberOfLines = 0
//    public var messageNumberOfLines = 0
//
//    public var horizontalPadding: CGFloat = 10.0
//    public var verticalPadding: CGFloat = 10.0
//    public var cornerRadius: CGFloat = 10.0
//
//    public var maxHeightPercentage: CGFloat = 0.8 {
//      didSet {
//        maxHeightPercentage = max(min(maxHeightPercentage, 1.0), 0.0)
//      }
//    }
//    public var maxWidthPercentage: CGFloat = 0.8 {
//      didSet {
//        maxWidthPercentage = max(min(maxWidthPercentage, 1.0), 0.0)
//      }
//    }
//
//    public var imageSize = CGSize(width: 80.0, height: 80.0)
//
//    public var fadeDuration: TimeInterval = 0.2
//  }
//
//  enum ToastPosition {
//    case top
//    case bottomCenter
//    case bottomLeft
//    case bottomRight
//
//    fileprivate func centerPoint(forToast toast: UIView, inSuperView toastSuperView: UIView) -> CGPoint
//    {
//      let toastStyle = ToastStyle()
//      let topPadding: CGFloat = toastStyle.verticalPadding + toastSuperView.safeAreaInsets.top
//      let bottomPadding: CGFloat = toastStyle.verticalPadding + toastSuperView.safeAreaInsets.bottom + 30.0
//      let leftPadding: CGFloat = toastStyle.horizontalPadding + toastSuperView.safeAreaInsets.left
//      let rightPadding: CGFloat = toastStyle.horizontalPadding + toastSuperView.safeAreaInsets.right
//
//      switch self {
//        case .top:
//          return CGPoint(x: toastSuperView.bounds.size.width / 2.0, y: (toast.frame.size.height / 2.0) + topPadding)
//        case .bottomLeft:
//          return CGPoint(x: (toast.frame.size.width / 2.0) + leftPadding, y: (toastSuperView.bounds.size.height - (toast.frame.size.height / 2.0)) - bottomPadding)
//        case .bottomCenter:
//          return CGPoint(x: toastSuperView.bounds.size.width / 2.0, y: (toastSuperView.bounds.size.height - (toast.frame.size.height / 2.0)) - bottomPadding)
//        case .bottomRight:
//          return CGPoint(x: (toastSuperView.bounds.size.width - (toast.frame.size.width / 2.0)) - rightPadding, y: (toastSuperView.bounds.size.height - (toast.frame.size.height / 2.0)) - bottomPadding)
//      }
//    }
//  }
//
//  private var activeToasts: NSMutableArray {
//    get {
//      if let activeToasts = objc_getAssociatedObject(self, &ToastKeys.activeToasts) as? NSMutableArray {
//        return activeToasts
//      } else {
//        let activeToasts = NSMutableArray()
//        objc_setAssociatedObject(self, &ToastKeys.activeToasts, activeToasts, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//        return activeToasts
//      }
//    }
//  }
//
//  private var toastQueue: NSMutableArray {
//    if let queue = objc_getAssociatedObject(self, &ToastKeys.queue) as? NSMutableArray {
//      return queue
//    } else {
//      let queue = NSMutableArray()
//      objc_setAssociatedObject(self, &ToastKeys.queue, queue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//      return queue
//    }
//  }
//
//  var currentToastViewIndex: Int? {
//    get {
//      if let toastView = activeToasts.firstObject as? UIView {
//        return self.subviews.firstIndex(of: toastView)
//      } else { return nil }
//    }
//  }
//
////  // MARK: - Make toast alert to show at a given toast position on the View
////  func createToast(toShowWithMessage message: String?, atPosition position: ToastPosition, title: String?, showLoadingIndicator: Bool = false, image: UIImage?, duration: TimeInterval, completions: () -> Void)
////  {
////    let toast = createToast(withMessage: message, title: title, image: image)
////    showToast(atPosition: position, toast: toast, duration: duration, completion: completions)
////  }
////
////  // MARK: - Make toast alert to show at a given point on the View
////  func createToast(toShowWithMessage message: String?, atPoint point: CGPoint, title: String?, showLoadingIndicator: Bool = false, image: UIImage?, duration: TimeInterval, completions: () -> Void)
////  {
////    let toast = createToast(withMessage: message, title: title, image: image)
////    showToast(atPoint: point, toast: toast, duration: duration, completion: completions)
////  }
////
////  // MARK: - Create the toast view to display
////  func createToast(withMessage message: String?, title: String?, image: UIImage?) -> ToastView
////  {
////    let toastStyle = ToastStyle()
////    let toastWrapper = ToastView(withMessage: message, title: title, image: image, style: toastStyle, parentViewBounds: self.bounds)
////
////    objc_setAssociatedObject(self, &ToastKeys.currentToastTag, toastWrapper.restorationIdentifier, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
////
////    return toastWrapper
////  }
////
////  // MARK: - Show the toast at position within the View
////  func showToast(atPosition position: ToastPosition, toast: ToastView, duration: TimeInterval, completion: () -> Void)
////  {
////    let point = position.centerPoint(forToast: toast, inSuperView: self)
////    showToast(atPoint: point, toast: toast, duration: duration, completion: completion)
////  }
////
////  // MARK: - Show the toast at point within the View with a completion handler
////  func showToast(atPoint point: CGPoint, toast: ToastView, duration: TimeInterval, completion: () -> Void)
////  {
////    if activeToasts.count > 0 {
////      toastQueue.add(toast)
////      for case let toastView as ToastView in activeToasts {
////        shiftToastUp(toastView, height: toast.frame.size.height)
////      }
////      showToast(toast, point: point, duration: duration)
////    } else {
////      showToast(toast, point: point, duration: duration)
////    }
////  }
////
////  // MARK: - Private show/hide toast methods
////  private func showToast(_ toast: ToastView, point: CGPoint, duration: TimeInterval)
////  {
////    toast.center = point
////    toast.alpha = 0.0
////
////    let recognizer = UITapGestureRecognizer(target: self, action: #selector(UIView.handleToastTapped(_:)))
////    toast.addGestureRecognizer(recognizer)
////    toast.isUserInteractionEnabled = true
////    toast.isExclusiveTouch = true
////
////    activeToasts.add(toast)
////    self.addSubview(toast)
////
////    UIView.animate(withDuration: 0.2, delay: 0.0, options: [.curveEaseOut, .allowUserInteraction], animations: {
////      toast.alpha = 1.0
////    }) { _ in
////      let timer = Timer(timeInterval: duration, target: self, selector: #selector(UIView.toastTimerDidFinish(_:)), userInfo: toast, repeats: false)
////      RunLoop.main.add(timer, forMode: .common)
////    }
////  }
////
////  func shiftToastUp(_ toast: ToastView, height: CGFloat)
////  {
////    let toastStyle = ToastStyle()
////    let newYPosition = toast.frame.origin.y - (height + toastStyle.verticalPadding)
////    let topPadding = toastStyle.verticalPadding + self.safeAreaInsets.top
////    if newYPosition < topPadding {
////      hideToast(toast)
////    } else {
////      toast.frame = CGRect(x: toast.frame.origin.x, y: newYPosition, width: toast.frame.size.width, height: toast.frame.size.height)
////    }
////  }
////
////  func shiftToastDown(_ toast: ToastView, height: CGFloat)
////  {
////    let toastStyle = ToastStyle()
////    toast.frame = CGRect(x: toast.frame.origin.x, y: toast.frame.origin.y + (height + toastStyle.verticalPadding), width: toast.frame.size.width, height: toast.frame.size.height)
////  }
////
////  func hideToast()
////  {
////    guard let activeToast = activeToasts.firstObject as? UIView else { return }
////    hideToast(activeToast)
////  }
////
////  func hideToast(_ toast: UIView)
////  {
////    guard activeToasts.contains(toast) else { return }
////    hideToast(toast, fromTap: false)
////  }
////
////  func hideToast(_ toast: UIView, fromTap: Bool)
////  {
////    //    if let timer = objc_getAssociatedObject(toast, &ToastKeys.timer) as? Timer {
////    //      timer.invalidate
////    //    }
////
////    let toastIndex = activeToasts.index(of: toast)
////    guard toastIndex > -1  else { return }
////    let toastStyle = ToastStyle()
////
////    for case let selectedToast as ToastView in activeToasts {
////      let selectedToastIndex = activeToasts.index(of: selectedToast)
////      if selectedToastIndex > -1, toastIndex > selectedToastIndex {
////        shiftToastDown(selectedToast, height: selectedToast.frame.size.height)
////      }
////    }
////
////    UIView.animate(withDuration: toastStyle.fadeDuration, delay: 0.0, options: [.curveEaseIn, .beginFromCurrentState], animations: {
////      toast.alpha = 0.0
////    }) { _ in
////      toast.removeFromSuperview()
////      self.activeToasts.remove(toast)
////    }
////  }
////
////  func hideAllToast(clearQueue: Bool = true)
////  {
////    if clearQueue {
////      clearToastQueue()
////    }
////
////    activeToasts.compactMap { $0 as? UIView }.forEach { hideToast($0) }
////  }
////
////  func clearToastQueue()
////  {
////    toastQueue.removeAllObjects()
////  }
////
////  @objc
////  private func handleToastTapped(_ recognizer: UITapGestureRecognizer)
////  {
////    guard let toast = recognizer.view as? ToastView else { return }
////    hideToast(toast, fromTap: true)
////  }
////
////  @objc
////  private func toastTimerDidFinish(_ timer: Timer)
////  {
////    guard let toast = timer.userInfo as? UIView else { return }
////    hideToast(toast)
////    print("timer finished")
////  }
}
