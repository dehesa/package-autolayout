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
    /// Packages the left and right layout anchors into a single group.
    public var horizontalAnchor: HorizontalAnchor {
        return .init(left: self.leftAnchor, right: self.rightAnchor)
    }
    
    /// Packages the leading and trailing layout anchors into a single group.
    public var directionalAnchor: DirectionalAnchor {
        return .init(leading: self.leadingAnchor, trailing: self.trailingAnchor)
    }
    
    /// Packages the top and bottom layout anchors into a single group.
    public var verticalAnchor: VerticalAnchor {
        return .init(top: self.topAnchor, bottom: self.bottomAnchor)
    }
    
    /// Packages the center X and Y layout anchors into a single group.
    public var centerAnchor: CenterAnchor {
        return .init(x: self.centerXAnchor, y: self.centerYAnchor)
    }
    
    /// Packages the width and height layout anchors into a single group.
    public var sizeAnchor: SizeAnchor {
        return .init(width: self.widthAnchor, height: self.heightAnchor)
    }
    
    /// Packages the top, left, bottom, and right layout anchors into a single group.
    public var edgeAnchor: EdgeAnchor {
        return .init(top: self.topAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor)
    }
    
    /// Packages the top, leading, bottom, and trailing layout anchors into a single group.
    public var directionalEdgeAnchor: DirectionalEdgeAnchor {
        return .init(top: self.topAnchor, leading: self.leadingAnchor, bottom: self.bottomAnchor, trailing: self.trailingAnchor)
    }
}
