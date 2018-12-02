#if os(iOS) || os(tvOS)
import UIKit
#elseif os(macOS)
import Cocoa
#else
#error("OS not supported")
#endif

/// Indicator on whether a constraint should be actived after initializion or not.
public enum Activity {
    /// The constraint will be left as it is currently (inactive by default).
    case `default`
    /// The constraint will be activated.
    case on
    /// The constraint will be deactivated.
    case off
    
    /// Modify the activity of the given constraint depending on the stored value.
    internal func setting(constraint: NSLayoutConstraint) -> NSLayoutConstraint {
        switch self {
        case .on: constraint.isActive = true
        case .off: constraint.isActive = false
        case .default: break
        }
        return constraint
    }
}
