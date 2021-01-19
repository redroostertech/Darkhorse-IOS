import UIKit

// MARK: - Properties
extension UITextField {
  func addLeftPaddingWithAction(title: String,
                                action: Selector) -> UIButton {
    let button = UIButton(type: .system)
    button.frame = CGRect(x: .zero,
                          y: .zero,
                          width: 45.0,
                          height: self.bounds.height)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle(title,
                    for: .normal)
    button.setTitleColor(.black,
                         for: .normal)
    button.addTarget(nil,
                     action: action,
                     for: .touchUpInside)
    button.titleLabel?.textAlignment = .center
    self.leftViewMode = .always
    self.leftView = button
    return button
  }
  
  public typealias TextFieldConfig = (UITextField) -> Swift.Void
  
  public func config(textField configurate: TextFieldConfig?) {
    configurate?(self)
  }
  
  func left(image: UIImage?, color: UIColor = .black) {
    if let image = image {
      leftViewMode = .always
      let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
      imageView.contentMode = .scaleAspectFit
      imageView.image = image
      imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
      imageView.tintColor = color
      leftView = imageView
    } else {
      leftViewMode = .never
      leftView = nil
    }
  }
  
  func right(image: UIImage?, color: UIColor = .black) {
    if let image = image {
      rightViewMode = .always
      let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 20, height: 20))
      imageView.contentMode = .scaleAspectFit
      imageView.image = image
      imageView.image = imageView.image?.withRenderingMode(.alwaysTemplate)
      imageView.tintColor = color
      rightView = imageView
    } else {
      rightViewMode = .never
      rightView = nil
    }
  }
}

public extension UITextField {
  
  /// Set placeholder text color.
  ///
  /// - Parameter color: placeholder text color.
  public func setPlaceHolderTextColor(_ color: UIColor) {
    self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: color])
  }
  
  /// Set placeholder text and its color
  func placeholder(text value: String, color: UIColor = .red) {
    self.attributedPlaceholder = NSAttributedString(string: value, attributes: [ NSAttributedString.Key.foregroundColor : color])
  }
}

extension UITextField {
  func addLeftPadding(withWidth width: CGFloat) {
    let padding = UIView(frame: CGRect(x: .zero,
                                       y: .zero,
                                       width: width,
                                       height: self.bounds.height))
    self.leftViewMode = .always
    self.leftView = padding
  }
  
  func addRightPadding(withWidth width: CGFloat) {
    let padding = UIView(frame: CGRect(x: .zero,
                                       y: .zero,
                                       width: width,
                                       height: self.bounds.height))
    self.rightViewMode = .always
    self.rightView = padding
  }
  
  public func addHorizontalLine(_ sender: UITextField) {
    let horizontalLine = UIView(frame: CGRect(x: sender.frame.origin.x , y: sender.frame.maxY - 5, width: sender.frame.width, height: 1))
    horizontalLine.backgroundColor = .black
    horizontalLine.layer.zPosition = 1000
    sender.addSubview(horizontalLine)
    
    print("Size of UIElement \(sender)")
    print(sender.frame.width)
  }
  
  @IBInspectable var placeHolderColor: UIColor? {
    get {
      return self.placeHolderColor
    }
    set {
      self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
    }
  }
}
