import Foundation
import UIKit

extension String {
    var djb2hash: Int {
        let unicodeScalars = self.unicodeScalars.map { $0.value }
        return unicodeScalars.reduce(5381) {
            ($0 << 5) &+ $0 &+ Int($1)
        }
    }

    var sdbmhash: Int {
        let unicodeScalars = self.unicodeScalars.map { $0.value }
        return unicodeScalars.reduce(0) {
            Int($1) &+ ($0 << 6) &+ ($0 << 16) - $0
        }
    }

    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return ceil(boundingBox.height)
    }

    func width(withConstraintedHeight height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return ceil(boundingBox.width)
    }

    func isEmptyTrimmingSpaces() -> Bool {
        return self.trimmingCharacters(in: CharacterSet(charactersIn: " ")).isEmpty
    }

    var parseJSONString: [String: AnyObject]? {
        let data = self.data(using: String.Encoding.utf8, allowLossyConversion: false)
        if let jsonData = data {
            do {
                return try JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: AnyObject]
            } catch let error as NSError {
                print(error)
            }
            return nil
        }
        return nil
    }

    var isBlank: Bool {
        get {
            let trimmed = trimmingCharacters(in: CharacterSet.whitespaces)
            return trimmed.isEmpty
        }
    }

    //Validate Email

    var isEmail: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil
        } catch {
            return false
        }
    }

    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }

  var isAlphabet: Bool {
      return !isEmpty && range(of: "[^a-zA-Z]", options: .regularExpression) == nil
  }

    //validate Password
    var isValidPassword: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[a-zA-Z_0-9\\-_,;.:#+*?=!§$%&/()@]+$", options: .caseInsensitive)
            if(regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil){

                if(self.count>=6 && self.count <= 20) {
                    return true
                }else{
                    return false
                }
            }else{
                return false
            }
        } catch {
            return false
        }
    }

    //validate Phone Number
    var isPhoneNumber: Bool {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: self, options: [], range: NSMakeRange(0, self.count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.count
            } else {
                return false
            }
        } catch {
            return false
        }
    }

    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }

    func startsWith(string: String) -> Bool {
        guard let range = range(of: string, options:[.caseInsensitive]) else {
            return false
        }
        return range.lowerBound == startIndex
    }

    func substring(_ from: Int) -> String {
        return self.substring(from: self.index(self.startIndex, offsetBy: from))
    }

    var length: Int {
        return utf16.count
    }

    func equalsIgnoreCase(str:String)->Bool{
        var isEqual:Bool = false
        if(self.caseInsensitiveCompare(str) == ComparisonResult.orderedSame){
            isEqual = true
        }
        return isEqual
    }

    var westernArabicNumeralsOnly: String {
        let pattern = UnicodeScalar("0")..."9"
        return String(unicodeScalars
            .flatMap { pattern ~= $0 ? Character($0) : nil })
    }

  func convertToDictionary() -> [String: Any]? {
    let jsonData = self.data(using: .utf8)!
    let dictionary = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableLeaves)
    return dictionary as? [String : Any]
  }
}

extension String {
    //    public static func getLocalizedTextFor(key: String, module: String = DeltaUIKitModule.name) -> String {
    //        return getLocalizedText(key: key, module: module)
    //    }
    //
    //    public static func getTextFor(key: String, module: String = DeltaUIKitModule.name) -> String {
    //        return getText(key: key, module: module)
    //    }
}

// String + Time extensions
extension String {
  func dateFromFormat(_ format: String) -> Date? {
    let formatter = DateFormatter()
    formatter.locale = Locale.autoupdatingCurrent
    formatter.calendar = Calendar.autoupdatingCurrent
    formatter.dateFormat = format
    return formatter.date(from: self)
  }
}

extension String {  
  /// Regular string.
  public var regular: NSMutableAttributedString {
    return NSMutableAttributedString(string: self, attributes: [.font: UIFont.systemFont(ofSize: UIFont.systemFontSize)])
  }
  
  /// Bold string.
  public var bold: NSMutableAttributedString {
    return NSMutableAttributedString(string: self, attributes: [.font: UIFont.boldSystemFont(ofSize: UIFont.systemFontSize)])
  }
  
  /// Underlined string
  public var underline: NSMutableAttributedString {
    return NSMutableAttributedString(string: self, attributes: [.underlineStyle: NSUnderlineStyle.single.rawValue])
  }
  
  /// Strikethrough string.
  public var strikethrough: NSMutableAttributedString {
    return NSMutableAttributedString(string: self, attributes: [.strikethroughStyle: NSNumber(value: NSUnderlineStyle.single.rawValue as Int)])
  }
  
  /// Italic string.
  public var italic: NSMutableAttributedString {
    return NSMutableAttributedString(string: self, attributes: [.font: UIFont.italicSystemFont(ofSize: UIFont.systemFontSize)])
  }
  
  /// Add color to string.
  ///
  /// - Parameter color: text color.
  /// - Returns: a NSAttributedString versions of string colored with given color.
  public func colored(with color: UIColor) -> NSMutableAttributedString {
    return NSMutableAttributedString(string: self, attributes: [.foregroundColor: color])
  }
}

// These could typically be commented out
extension String {
//  subscript (i: Int) -> Character {
//    return self[index(startIndex, offsetBy: i)]
//  }
//
//  var containsAlphabets: Bool {
//    //Checks if all the characters inside the string are alphabets
//    let set = CharacterSet.letters
//    return self.utf16.contains {
//      guard let unicode = UnicodeScalar($0) else { return false }
//      return set.contains(unicode)
//    }
//  }
}

extension NSString {
  //    func isValidUsername() -> Bool {
  //        return (self.length >= 6
  //            && self.length <= 32
  //            && !self.isNumeric())
  //    }
  //
  //    func isValidPassword() -> Bool {
  //        return (self.length >= 8
  //            && self.length <= 20
  //            && self.isFollowingPasswordConstraints())
  //    }

  //    @objc public static func getLocalizedTextFor(key: String, module: String = DeltaUIKitModule.name) -> String {
  //        return getLocalizedText(key: key, module: module)
  //    }
  //
  //    @objc public static func getTextFor(key: String, module: String = DeltaUIKitModule.name) -> String {
  //        return getText(key: key, module: module)
  //    }
}

/*
 1. getLocalizedTextFor method reads from Localizable.strings
 file of the given module
 2. getTextFor method reads from the ModuleName.strings file
 which should be used when localizable string value are
 same across different targets
 */

//private func getLocalizedText(key: String, module: String) -> String {
//    if let bundle = Bundle(identifier: DeltaUIKitModule.defaultModule.moduleBundleMap.getBundleIdentifier(module: module)) {
//        return bundle.localizedString(forKey: key, value: "", table: nil)
//    }
//    return key
//}
//
//private func getText(key: String, module: String) -> String {
//    if let bundle = Bundle(identifier: DeltaUIKitModule.defaultModule.moduleBundleMap.getBundleIdentifier(module: module)) {
//        return bundle.localizedString(forKey: key, value: "", table: module)
//    }
//    return key
//}

//
//  NSAttributedString+Extensions.swift
//
//  Created by Ben Kreeger on 12/11/15.
//
// The MIT License (MIT)
//
// Copyright (c) 2014-2016 Oven Bits, LLC
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

extension NSAttributedString {
  /**
   Returns a new mutable string with characters from a given character set removed.
   See http://panupan.com/2012/06/04/trim-leading-and-trailing-whitespaces-from-nsmutableattributedstring/
   - Parameters:
   - charSet: The character set with which to remove characters.
   - returns: A new string with the matching characters removed.
   */
  public func trimmingCharacters(in set: CharacterSet) -> NSAttributedString {
    let modString = NSMutableAttributedString(attributedString: self)
    modString.trimCharacters(in: set)
    return NSAttributedString(attributedString: modString)
  }
}


extension NSMutableAttributedString {
  /**
   Modifies this instance of the string to remove characters from a given character set from
   the beginning and end of the string.
   See http://panupan.com/2012/06/04/trim-leading-and-trailing-whitespaces-from-nsmutableattributedstring/
   - Parameters:
   - charSet: The character set with which to remove characters.
   */
  public func trimCharacters(in set: CharacterSet) {
    var range = (string as NSString).rangeOfCharacter(from: set)
    
    // Trim leading characters from character set.
    while range.length != 0 && range.location == 0 {
      replaceCharacters(in: range, with: "")
      range = (string as NSString).rangeOfCharacter(from: set)
    }
    
    // Trim trailing characters from character set.
    range = (string as NSString).rangeOfCharacter(from: set, options: .backwards)
    while range.length != 0 && NSMaxRange(range) == length {
      replaceCharacters(in: range, with: "")
      range = (string as NSString).rangeOfCharacter(from: set, options: .backwards)
    }
  }
  
}


extension NSMutableAttributedString {
  
  fileprivate var range: NSRange {
    return NSRange(location: 0, length: length)
  }
  
  fileprivate var paragraphStyle: NSMutableParagraphStyle? {
    return attributes(at: 0, effectiveRange: nil)[NSAttributedString.Key.paragraphStyle] as? NSMutableParagraphStyle
  }
  
}

// MARK: - Font
extension NSMutableAttributedString {
  /**
   Applies a font to the entire string.
   
   - parameter font: The font.
   */
  @discardableResult
  public func font(_ font: UIFont) -> Self {
    addAttribute(NSAttributedString.Key.font, value: font, range: range)
    return self
  }
  
  /**
   Applies a font to the entire string.
   
   - parameter name: The font name.
   - parameter size: The font size.
   
   Note: If the specified font name cannot be loaded, this method will fallback to the system font at the specified size.
   */
  @discardableResult
  public func font(name: String, size: CGFloat) -> Self {
    addAttribute(NSAttributedString.Key.font, value: UIFont(name: name, size: size) ?? .systemFont(ofSize: size), range: range)
    return self
  }
}

// MARK: - Paragraph style
extension NSMutableAttributedString {
  
  /**
   Applies a text alignment to the entire string.
   
   - parameter alignment: The text alignment.
   */
  @discardableResult
  public func alignment(_ alignment: NSTextAlignment) -> Self {
    let paragraphStyle = self.paragraphStyle ?? NSMutableParagraphStyle()
    paragraphStyle.alignment = alignment
    
    addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
    
    return self
  }
  
  /**
   Applies line spacing to the entire string.
   
   - parameter lineSpacing: The line spacing amount.
   */
  @discardableResult
  public func lineSpacing(_ lineSpacing: CGFloat) -> Self {
    let paragraphStyle = self.paragraphStyle ?? NSMutableParagraphStyle()
    paragraphStyle.lineSpacing = lineSpacing
    
    addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
    
    return self
  }
  
  /**
   Applies paragraph spacing to the entire string.
   
   - parameter paragraphSpacing: The paragraph spacing amount.
   */
  @discardableResult
  public func paragraphSpacing(_ paragraphSpacing: CGFloat) -> Self {
    let paragraphStyle = self.paragraphStyle ?? NSMutableParagraphStyle()
    paragraphStyle.paragraphSpacing = paragraphSpacing
    
    addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
    
    return self
  }
  
  /**
   Applies a line break mode to the entire string.
   
   - parameter mode: The line break mode.
   */
  @discardableResult
  public func lineBreak(_ mode: NSLineBreakMode) -> Self {
    let paragraphStyle = self.paragraphStyle ?? NSMutableParagraphStyle()
    paragraphStyle.lineBreakMode = mode
    
    addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
    
    return self
  }
  
  /**
   Applies a line height multiplier to the entire string.
   
   - parameter multiple: The line height multiplier.
   */
  @discardableResult
  public func lineHeight(multiple: CGFloat) -> Self {
    let paragraphStyle = self.paragraphStyle ?? NSMutableParagraphStyle()
    paragraphStyle.lineHeightMultiple = multiple
    
    addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
    
    return self
  }
  
  /**
   Applies a first line head indent to the string.
   
   - parameter indent: The first line head indent amount.
   */
  @discardableResult
  public func firstLineHeadIndent(_ indent: CGFloat) -> Self {
    let paragraphStyle = self.paragraphStyle ?? NSMutableParagraphStyle()
    paragraphStyle.firstLineHeadIndent = indent
    
    addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
    
    return self
  }
  
  /**
   Applies a head indent to the string.
   
   - parameter indent: The head indent amount.
   */
  @discardableResult
  public func headIndent(_ indent: CGFloat) -> Self {
    let paragraphStyle = self.paragraphStyle ?? NSMutableParagraphStyle()
    paragraphStyle.headIndent = indent
    
    addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
    
    return self
  }
  
  /**
   Applies a tail indent to the string.
   
   - parameter indent: The tail indent amount.
   */
  @discardableResult
  public func tailIndent(_ indent: CGFloat) -> Self {
    let paragraphStyle = self.paragraphStyle ?? NSMutableParagraphStyle()
    paragraphStyle.tailIndent = indent
    
    addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
    
    return self
  }
  
  /**
   Applies a minimum line height to the entire string.
   
   - parameter height: The minimum line height.
   */
  @discardableResult
  public func minimumLineHeight(_ height: CGFloat) -> Self {
    let paragraphStyle = self.paragraphStyle ?? NSMutableParagraphStyle()
    paragraphStyle.minimumLineHeight = height
    
    addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
    
    return self
  }
  
  /**
   Applies a maximum line height to the entire string.
   
   - parameter height: The maximum line height.
   */
  @discardableResult
  public func maximumLineHeight(_ height: CGFloat) -> Self {
    let paragraphStyle = self.paragraphStyle ?? NSMutableParagraphStyle()
    paragraphStyle.maximumLineHeight = height
    
    addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
    
    return self
  }
  
  /**
   Applies a base writing direction to the entire string.
   
   - parameter direction: The base writing direction.
   */
  @discardableResult
  public func baseWritingDirection(_ direction: NSWritingDirection) -> Self {
    let paragraphStyle = self.paragraphStyle ?? NSMutableParagraphStyle()
    paragraphStyle.baseWritingDirection = direction
    
    addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
    
    return self
  }
  
  /**
   Applies a paragraph spacing before amount to the string.
   
   - parameter spacing: The distance between the paragraph’s top and the beginning of its text content.
   */
  @discardableResult
  public func paragraphSpacingBefore(_ spacing: CGFloat) -> Self {
    let paragraphStyle = self.paragraphStyle ?? NSMutableParagraphStyle()
    paragraphStyle.paragraphSpacingBefore = spacing
    
    addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: range)
    
    return self
  }
}

// MARK: - Foreground color
extension NSMutableAttributedString {
  /**
   Applies the given color over the entire string, as the foreground color.
   
   - parameter color: The color to apply.
   */
  @discardableResult @nonobjc
  public func color(_ color: UIColor, alpha: CGFloat = 1) -> Self {
    addAttribute(NSAttributedString.Key.foregroundColor, value: color.withAlphaComponent(alpha), range: range)
    return self
  }
  
  /**
   Applies the given color over the entire string, as the foreground color.
   
   - parameter color: The color to apply.
   */
  @discardableResult
  public func color(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1) -> Self {
    addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(red: red, green: green, blue: blue, alpha: alpha), range: range)
    return self
  }
  
  /**
   Applies the given color over the entire string, as the foreground color.
   
   - parameter color: The color to apply.
   */
  @discardableResult
  public func color(white: CGFloat, alpha: CGFloat = 1) -> Self {
    addAttribute(NSAttributedString.Key.foregroundColor, value: UIColor(white: white, alpha: alpha), range: range)
    return self
  }
}

// MARK: - Underline, kern, strikethrough, stroke, shadow, text effect
extension NSMutableAttributedString {
  /**
   Applies a single underline under the entire string.
   
   - parameter style: The `NSUnderlineStyle` to apply. Defaults to `.styleSingle`.
   */
  @discardableResult
  public func underline(style: NSUnderlineStyle = .single, color: UIColor? = nil) -> Self {
    addAttribute(NSAttributedString.Key.underlineStyle, value: style.rawValue, range: range)
    
    if let color = color {
      addAttribute(NSAttributedString.Key.underlineColor, value: color, range: range)
    }
    
    return self
  }
  
  /**
   Applies a kern (spacing) value to the entire string.
   
   - parameter value: The space between each character in the string.
   */
  @discardableResult
  public func kern(_ value: CGFloat) -> Self {
    addAttribute(NSAttributedString.Key.kern, value: value, range: range)
    return self
  }
  
  /**
   Applies a strikethrough to the entire string.
   
   - parameter style: The `NSUnderlineStyle` to apply. Defaults to `.styleSingle`.
   - parameter color: The underline color. Defaults to the color of the text.
   */
  @discardableResult
  public func strikethrough(style: NSUnderlineStyle = .single, color: UIColor? = nil) -> Self {
    addAttribute(NSAttributedString.Key.strikethroughStyle, value: style.rawValue, range: range)
    
    if let color = color {
      addAttribute(NSAttributedString.Key.strikethroughColor, value: color, range: range)
    }
    
    return self
  }
  
  /**
   Applies a stroke to the entire string.
   
   - parameter color: The stroke color.
   - parameter width: The stroke width.
   */
  @discardableResult
  public func stroke(color: UIColor, width: CGFloat) -> Self {
    addAttributes([
      NSAttributedString.Key.strokeColor : color,
      NSAttributedString.Key.strokeWidth : width
    ], range: range)
    
    return self
  }
  
  /**
   Applies a shadow to the entire string.
   
   - parameter color: The shadow color.
   - parameter radius: The shadow blur radius.
   - parameter offset: The shadow offset.
   */
  @discardableResult
  public func shadow(color: UIColor, radius: CGFloat, offset: CGSize) -> Self {
    let shadow = NSShadow()
    shadow.shadowColor = color
    shadow.shadowBlurRadius = radius
    shadow.shadowOffset = offset
    
    addAttribute(NSAttributedString.Key.shadow, value: shadow, range: range)
    
    return self
  }
  
}

// MARK: - Background color
extension NSMutableAttributedString {
  
  /**
   Applies a background color to the entire string.
   
   - parameter color: The color to apply.
   */
  @discardableResult @nonobjc
  public func backgroundColor(_ color: UIColor, alpha: CGFloat = 1) -> Self {
    addAttribute(NSAttributedString.Key.backgroundColor, value: color.withAlphaComponent(alpha), range: range)
    return self
  }
  
  /**
   Applies a background color to the entire string.
   
   - parameter red: The red color component.
   - parameter green: The green color component.
   - parameter blue: The blue color component.
   - parameter alpha: The alpha component.
   */
  @discardableResult
  public func backgroundColor(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat = 1) -> Self {
    addAttribute(NSAttributedString.Key.backgroundColor, value: UIColor(red: red, green: green, blue: blue, alpha: alpha), range: range)
    return self
  }
  
  /**
   Applies a background color to the entire string.
   
   - parameter white: The white color component.
   - parameter alpha: The alpha component.
   */
  @discardableResult
  public func backgroundColor(white: CGFloat, alpha: CGFloat = 1) -> Self {
    addAttribute(NSAttributedString.Key.backgroundColor, value: UIColor(white: white, alpha: alpha), range: range)
    return self
  }
}

extension NSMutableAttributedString {
  
  /**
   Applies a baseline offset to the entire string.
   
   - parameter offset: The offset value.
   */
  @discardableResult
  public func baselineOffset(_ offset: Float) -> Self {
    addAttribute(NSAttributedString.Key.baselineOffset, value: NSNumber(value: offset), range: range)
    return self
  }
}

public func +(lhs: NSMutableAttributedString, rhs: NSAttributedString) -> NSMutableAttributedString {
  let lhs = NSMutableAttributedString(attributedString: lhs)
  lhs.append(rhs)
  return lhs
}

public func +=(lhs: NSMutableAttributedString, rhs: NSAttributedString) {
  lhs.append(rhs)
}
