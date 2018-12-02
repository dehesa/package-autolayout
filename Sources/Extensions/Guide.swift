#if os(iOS) || os(tvOS)
import UIKit
public typealias Guide = UILayoutGuide
#elseif os(macOS)
import Cocoa
public typealias Guide = NSLayoutGuide
#else
#error("OS not supported")
#endif

extension Guide {
    /// Packages the top, left, bottom, and right layout anchors into a single group.
    public var edgeAnchor: AnchorQuartet {
        return .init(top: self.topAnchor, first: self.leftAnchor, bottom: self.bottomAnchor, second: self.rightAnchor)
    }
    
    /// Packages the top, leading, bottom, and trailing layout anchors into a single group.
    public var directionalEdgeAnchor: AnchorQuartet {
        return .init(top: self.topAnchor, first: self.leadingAnchor, bottom: self.bottomAnchor, second: self.trailingAnchor)
    }
    
    /// Packages the width and height layout anchors into a single group.
    public var sizeAnchor: AnchorPair<NSLayoutDimension,NSLayoutDimension> {
        return .init(self.widthAnchor, self.heightAnchor)
    }
    
    /// Packages the center X and Y layout anchors into a single group.
    public var centerAnchor: AnchorPair<NSLayoutXAxisAnchor,NSLayoutYAxisAnchor> {
        return .init(self.centerXAnchor, self.centerYAnchor)
    }
    
    /// Packages the top and bottom layout anchors into a single group.
    public var verticalAnchor: AnchorPair<NSLayoutYAxisAnchor,NSLayoutYAxisAnchor> {
        return .init(self.topAnchor, self.bottomAnchor)
    }
    
    /// Packages the left and right layout anchors into a single group.
    public var horizontalAnchor: AnchorPair<NSLayoutXAxisAnchor,NSLayoutXAxisAnchor> {
        return .init(self.leftAnchor, self.rightAnchor)
    }
    
    /// Packages the leading and trailing layout anchors into a single group.
    public var directionalAnchor: AnchorPair<NSLayoutXAxisAnchor,NSLayoutXAxisAnchor> {
        return .init(self.leadingAnchor, self.trailingAnchor)
    }
}
