#if os(iOS) || os(tvOS)
import UIKit
#elseif os(macOS)
import Cocoa
#else
#error("OS not supported")
#endif

public struct Expression {
    let anchor: NSLayoutDimension
    let multiplier: CGFloat
    var constant: CGFloat
    var priority: Priority
    
    init(anchor: NSLayoutDimension, multiplier: CGFloat = 1, constant: CGFloat = 0, priority: Priority = .required) {
        self.anchor = anchor
        self.multiplier = multiplier
        self.constant = constant
        self.priority = priority
    }
}

extension Expression {
    func isEqual(to lhs: NSLayoutDimension) -> NSLayoutConstraint {
        let result = lhs.constraint(equalTo: self.anchor, multiplier: self.multiplier, constant: self.constant)
        result.priority = priority
        return result
    }
    
    func isGreater(than lhs: NSLayoutDimension) -> NSLayoutConstraint {
        let result = lhs.constraint(lessThanOrEqualTo: self.anchor, multiplier: self.multiplier, constant: self.constant)
        result.priority = priority
        return result
    }
    
    func isLess(than lhs: NSLayoutDimension) -> NSLayoutConstraint {
        let result = lhs.constraint(greaterThanOrEqualTo: self.anchor, multiplier: self.multiplier, constant: self.constant)
        result.priority = priority
        return result
    }
}
