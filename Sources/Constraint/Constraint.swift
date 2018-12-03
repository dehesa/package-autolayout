#if os(iOS) || os(tvOS)
import UIKit
#elseif os(macOS)
import Cocoa
#else
#error("OS not supported")
#endif

public protocol LayoutConstraint {
    associatedtype Identifier
    
    func activating(_ isActive: Bool) -> Self
    func identifying(_ identifier: Identifier) -> Self
}

public protocol LayoutConstraintGroup: LayoutConstraint {
    associatedtype Constraints
    
    static func make(with constraints: Self.Constraints) -> Self
    
    var all: Self.Constraints { get }
    func identifying(root: String, _ identifiers: Identifier) -> Self
}

extension LayoutConstraintGroup where Self.Constraints == (NSLayoutConstraint, NSLayoutConstraint), Self.Identifier == (String, String) {
    public func activating(_ isActive: Bool) -> Self {
        let all = self.all
        all.0.isActive = isActive
        all.1.isActive = isActive
        return self
    }
    
    public func identifying(_ identifier: Identifier) -> Self {
        let all = self.all
        all.0.identifier = identifier.0
        all.1.identifier = identifier.1
        return self
    }
    
    public func identifying(root: String, _ identifiers: Identifier) -> Self {
        let all = self.all
        all.0.identifier = root.appending(identifiers.0)
        all.1.identifier = root.appending(identifiers.1)
        return self
    }
}

extension LayoutConstraintGroup where Self.Constraints == (NSLayoutConstraint, NSLayoutConstraint, NSLayoutConstraint, NSLayoutConstraint), Self.Identifier == (String, String, String, String) {
    public func activating(_ isActive: Bool) -> Self {
        let all = self.all
        all.0.isActive = isActive
        all.1.isActive = isActive
        all.2.isActive = isActive
        all.3.isActive = isActive
        return self
    }
    
    public func identifying(_ identifier: Identifier) -> Self {
        let all = self.all
        all.0.identifier = identifier.0
        all.1.identifier = identifier.1
        all.2.identifier = identifier.2
        all.3.identifier = identifier.3
        return self
    }
    
    public func identifying(root: String, _ identifiers: Identifier) -> Self {
        let all = self.all
        all.0.identifier = root.appending(identifiers.0)
        all.1.identifier = root.appending(identifiers.1)
        all.2.identifier = root.appending(identifiers.2)
        all.3.identifier = root.appending(identifiers.3)
        return self
    }
}
