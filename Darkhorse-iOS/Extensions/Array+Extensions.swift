import Foundation

// MARK: - Array+Equatable
public extension Array where Element: Equatable {
  var uniqueElementsInOrder: [Element] {
    var uniqueValues: [Element] = []
    forEach { item in
      if !uniqueValues.contains(item) {
        uniqueValues += [item]
      }
    }
    return uniqueValues
  }
}

// MARK: - Array+Hashable
public extension Array where Element: Hashable {
  func uniqueArray() -> Array {
    return Array(Set(self))
  }
  
  var uniques: Array {
    var buffer = Array()
    var added = Set<Element>()
    for elem in self {
      if !added.contains(elem) {
        buffer.append(elem)
        added.insert(elem)
      }
    }
    return buffer
  }
}

// MARK: - Array+Comparable
public extension Array where Element: Comparable {
  // MARK: - Swap an item in array with the current if it satisfies the scenario. Do this until complete acension and descension exists.
  func selectionSort(by areInIncreasingOrder: ((Element, Element) -> Bool) = (<)) -> [Element] {
    var data = self
    
    for i in 0..<(data.count-1) {
      var key = i // 1
      
      for j in i+1..<data.count where areInIncreasingOrder(data[j], data[key]) { // 2
        key = j
      }
      
      guard i != key else { continue }
      
      data.swapAt(i, key) // 3
    }
    
    return data
  }
  
  // MARK: - Sort array by moving values 1 x 1 to the end of the array until ascencion or descension exists.
  func bubbleSort(by areInIncreasingOrder: ((Element, Element) -> Bool) = (<)) -> [Element] {
    var data = self
    for i in 0..<(data.count-1) {
      for j in 0..<(data.count-i-1) where areInIncreasingOrder(data[j+1], data[j]) {
        data.swapAt(j, j + 1)
      }
    }
    return data
  }
  
  // MARK: - Like sorting a deck of cards. Pull card out and order while keeping a reference to the new order, then replace until acension or descension exists.
  // Best for small itemsets
  func insertionSort(by areInIncreasingOrder: ((Element, Element) -> Bool) = (<)) -> [Element] {
    var data = self
    
    for i in 1..<data.count { // 1
      let key = data[i] // 2
      var j = i - 1
      
      while j >= 0 && areInIncreasingOrder(key, data[j]) { // 3
        data[j+1] = data[j] // 4
        
        j = j - 1
      }
      
      data[j + 1] = key // 5
    }
    
    return data
  }
  
  //  MARK: - Merge sort is the most efficient by splitting the data into chucnks and performing sorting accordingly until ascension or descension exists.
  private func merge(left: [Element], right: [Element], by areInIncreasingOrder: ((Element, Element) -> Bool) = (<)) -> [Element] {
    var output: [Element] = []
    
    var mutableLeft = left
    var mutableRight = right
    while mutableLeft.count > 0 && mutableRight.count > 0 {
      
      if let firstElement = mutableLeft.first, let secondElement = mutableRight.first {
        
        if !areInIncreasingOrder(firstElement, secondElement) {
          output.append(secondElement)
          mutableRight.remove(at: 0)
        } else {
          output.append(firstElement)
          mutableLeft.remove(at: 0)
        }
      }
    }
    
    output.append(contentsOf: mutableLeft)
    output.append(contentsOf: mutableRight)
    
    return output
  }
  
  private func _emMergeSort(data: [Element], by areInIncreasingOrder: ((Element, Element) -> Bool) = (<)) -> [Element] {
    if data.count < 2 { return data }
    
    let leftArray = Array(data[..<Int(data.count / 2)]) // 1
    let rightArray = Array(data[Int(data.count / 2)..<data.count]) // 2
    return merge(left: _emMergeSort(data: leftArray, by: areInIncreasingOrder), right: _emMergeSort(data: rightArray, by: areInIncreasingOrder), by: areInIncreasingOrder) // 3
  }
  
  func emMergeSort(by: ((Element, Element) -> Bool) = (<)) -> [Element] {
    let data = self
    return _emMergeSort(data: data, by: by)
  }
  
  // MARK: - Similar to the merge sort but uses less space to achieve complete ascension or descension. However its best on small sets of data.
  private func _quickSort(_ array: [Element], by areInIncreasingOrder: ((Element, Element) -> Bool)) -> [Element] {
    if array.count < 2 { return array } // 0
    
    var data = array
    
    let pivot = data.remove(at: 0) // 1
    let left = data.filter { areInIncreasingOrder($0, pivot) } // 2
    let right = data.filter { !areInIncreasingOrder($0, pivot) } // 3
    let middle = [pivot]
    
    return _quickSort(left, by: areInIncreasingOrder) + middle + _quickSort(right, by: areInIncreasingOrder) // 4
  }
  
  func quickSort(by areInIncreasingOrder: ((Element, Element) -> Bool) = (<)) -> [Element] {
    return _quickSort(self, by: areInIncreasingOrder)
  }
}

// MARK: - Array+NSAttributedString
extension Array where Element: NSAttributedString {
  func joined(separator: NSAttributedString) -> NSAttributedString {
    var isFirst = true
    return self.reduce(NSMutableAttributedString()) {
      (r, e) in
      if isFirst {
        isFirst = false
      } else {
        r.append(separator)
      }
      r.append(e)
      return r
    }
  }
  
  func joined(separator: String) -> NSAttributedString {
    return joined(separator: NSAttributedString(string: separator))
  }
}

extension Array {
  
  @discardableResult
  mutating func append(_ newArray: Array) -> CountableRange<Int> {
    let range = count..<(count + newArray.count)
    self += newArray
    return range
  }
  
  @discardableResult
  mutating func insert(_ newArray: Array, at index: Int) -> CountableRange<Int> {
    let mIndex = Swift.max(0, index)
    let start = Swift.min(count, mIndex)
    let end = start + newArray.count
    
    let left = self[0..<start]
    let right = self[start..<count]
    self = left + newArray + right
    return start..<end
  }
  
  mutating func remove<T: AnyObject> (_ element: T) {
    let anotherSelf = self
    
    removeAll(keepingCapacity: true)
    
    anotherSelf.each { (index: Int, current: Element) in
      if (current as! T) !== element {
        self.append(current)
      }
    }
  }
  
  func each(_ exe: (Int, Element) -> ()) {
    for (index, item) in enumerated() {
      exe(index, item)
    }
  }
}

extension Array where Element: Equatable {
  
  /// Remove Dublicates
  var unique: [Element] {
    // Thanks to https://github.com/sairamkotha for improving the method
    return self.reduce([]){ $0.contains($1) ? $0 : $0 + [$1] }
  }
  
  /// Check if array contains an array of elements.
  ///
  /// - Parameter elements: array of elements to check.
  /// - Returns: true if array contains all given items.
  public func contains(_ elements: [Element]) -> Bool {
    guard !elements.isEmpty else { // elements array is empty
      return false
    }
    var found = true
    for element in elements {
      if !contains(element) {
        found = false
      }
    }
    return found
  }
  
  /// All indexes of specified item.
  ///
  /// - Parameter item: item to check.
  /// - Returns: an array with all indexes of the given item.
  public func indexes(of item: Element) -> [Int] {
    var indexes: [Int] = []
    for index in 0..<self.count {
      if self[index] == item {
        indexes.append(index)
      }
    }
    return indexes
  }
  
  /// Remove all instances of an item from array.
  ///
  /// - Parameter item: item to remove.
  public mutating func removeAll(_ item: Element) {
    self = self.filter { $0 != item }
  }
  
  /// Creates an array of elements split into groups the length of size.
  /// If array can’t be split evenly, the final chunk will be the remaining elements.
  ///
  /// - parameter array: to chunk
  /// - parameter size: size of each chunk
  /// - returns: array elements chunked
  public func chunk(size: Int = 1) -> [[Element]] {
    var result = [[Element]]()
    var chunk = -1
    for (index, elem) in self.enumerated() {
      if index % size == 0 {
        result.append([Element]())
        chunk += 1
      }
      result[chunk].append(elem)
    }
    return result
  }
}

extension Array {
  
  /// Random item from array.
  public var randomItem: Element? {
    if self.isEmpty { return nil }
    let index = Int(arc4random_uniform(UInt32(count)))
    return self[index]
  }
  
  /// Shuffled version of array.
  public var shuffled: [Element] {
    var arr = self
    for _ in 0..<10 {
      arr.sort { (_,_) in arc4random() < arc4random() }
    }
    return arr
  }
  
  /// Shuffle array.
  public mutating func shuffle() {
    // https://gist.github.com/ijoshsmith/5e3c7d8c2099a3fe8dc3
    for _ in 0..<10 {
      sort { (_,_) in arc4random() < arc4random() }
    }
  }
  
  /// Element at the given index if it exists.
  ///
  /// - Parameter index: index of element.
  /// - Returns: optional element (if exists).
  public func item(at index: Int) -> Element? {
    guard index >= 0 && index < count else { return nil }
    return self[index]
  }
}
