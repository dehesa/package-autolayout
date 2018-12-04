#if canImport(UIKit)
import UIKit
internal typealias LayoutGuide = UILayoutGuide
#elseif canImport(Cocoa)
import Cocoa
internal typealias LayoutGuide = NSLayoutGuide
#else
#error("OS not supported")
#endif

extension LayoutGuide {
    /// Packages the width and height layout anchors into a single group.
    public var sizeAnchor: SizeAnchor {
        return .init(self.widthAnchor, self.heightAnchor)
    }
    
    /// Packages the center X and Y layout anchors into a single group.
    public var centerAnchor: CenterAnchor {
        return .init(self.centerXAnchor, self.centerYAnchor)
    }
    
    /// Packages the top and bottom layout anchors into a single group.
    public var verticalAnchor: VerticalAnchor {
        return .init(self.topAnchor, self.bottomAnchor)
    }
    
    /// Packages the left and right layout anchors into a single group.
    public var horizontalAnchor: HorizontalAnchor {
        return .init(self.leftAnchor, self.rightAnchor)
    }
    
    /// Packages the leading and trailing layout anchors into a single group.
    public var directionalAnchor: DirectionalAnchor {
        return .init(self.leadingAnchor, self.trailingAnchor)
    }
    
    /// Packages the top, left, bottom, and right layout anchors into a single group.
    public var edgeAnchor: EdgeAnchor {
        return .init(self.topAnchor, self.leftAnchor, self.bottomAnchor, self.rightAnchor)
    }
    
    /// Packages the top, leading, bottom, and trailing layout anchors into a single group.
    public var directionalEdgeAnchor: DirectionalEdgeAnchor {
        return .init(self.topAnchor, self.leadingAnchor, self.bottomAnchor, self.trailingAnchor)
    }
}
