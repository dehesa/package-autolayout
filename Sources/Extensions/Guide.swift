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
    ///
    public var edgeAnchor: AnchorQuartet {
        return .init(top: self.topAnchor, first: self.leftAnchor, bottom: self.bottomAnchor, second: self.rightAnchor)
    }
    
    ///
    public var directionalEdgeAnchor: AnchorQuartet {
        return .init(top: self.topAnchor, first: self.leadingAnchor, bottom: self.bottomAnchor, second: self.trailingAnchor)
    }
    
    ///
    public var sizeAnchor: AnchorPair<NSLayoutDimension,NSLayoutDimension> {
        return .init(self.widthAnchor, self.heightAnchor)
    }
    
    ///
    public var centerAnchor: AnchorPair<NSLayoutXAxisAnchor,NSLayoutYAxisAnchor> {
        return .init(self.centerXAnchor, self.centerYAnchor)
    }
    
    ///
    public var verticalAnchor: AnchorPair<NSLayoutYAxisAnchor,NSLayoutYAxisAnchor> {
        return .init(self.topAnchor, self.bottomAnchor)
    }
    
    ///
    public var horizontalAnchor: AnchorPair<NSLayoutXAxisAnchor,NSLayoutXAxisAnchor> {
        return .init(self.leftAnchor, self.rightAnchor)
    }
    
    public var directionalAnchor: AnchorPair<NSLayoutXAxisAnchor,NSLayoutXAxisAnchor> {
        return .init(self.leadingAnchor, self.trailingAnchor)
    }
}
