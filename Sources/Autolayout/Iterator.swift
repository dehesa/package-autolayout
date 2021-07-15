/// Iterator for a two value sequence.
public struct LayoutIteratorPair<T>: IteratorProtocol {
  /// The values that will be returned.
  private let values: (T, T)
  /// The index for the last value retrieved.
  private var counter = 0

  /// Creates an iterator from two values.
  @usableFromInline init(_ first: T, _ second: T) {
    self.values = (first, second)
  }
  /// Creates an iterator from a tuple with two values.
  @usableFromInline init(values: (T,T)) {
    self.values = values
  }

  public mutating func next() -> T? {
    defer { self.counter &+= 1 }
    switch self.counter {
    case 0: return self.values.0
    case 1: return self.values.1
    default: return nil
    }
  }

  func map<V>(with operation: (T)->V) -> (V,V) {
    (operation(self.values.0), operation(self.values.1))
  }

  @discardableResult func zipMap<V,W>(_ values: (V,V), operation: (T,V)->W) -> (W,W) {
    (operation(self.values.0, values.0), operation(self.values.1, values.1))
  }
}

/// Iterator for a four value sequence.
public struct LayoutIteratorQuartet<T>: IteratorProtocol {
  /// The values that will be returned.
  private let values: (T, T, T, T)
  /// The index for the last value retrieved
  private var counter = 0

  /// Creates an iterator from four values.
  @usableFromInline init(_ first: T, _ second: T, _ third: T, _ fourth: T) {
    self.values = (first, second, third, fourth)
  }
  /// Creates an iterator from a tuple with four values.
  @usableFromInline init(values: (T,T,T,T)) {
    self.values = values
  }

  public mutating func next() -> T? {
    defer { self.counter &+= 1 }
    switch self.counter {
    case 0: return self.values.0
    case 1: return self.values.1
    case 2: return self.values.2
    case 3: return self.values.3
    default: return nil
    }
  }

  func map<V>(with operation: (T)->V) -> (V,V,V,V) {
    (operation(self.values.0), operation(self.values.1), operation(self.values.2), operation(self.values.3))
  }

  func zipMap<V>(_ values: (V,V,V,V), operation: (T,V)->()) {
    operation(self.values.0, values.0)
    operation(self.values.1, values.1)
    operation(self.values.1, values.2)
    operation(self.values.1, values.3)
  }
}
