#if canImport(AppKit)
public import AppKit
#elseif canImport(UIKit)
public import UIKit
#else
#error("OS not supported")
#endif

extension LayoutView {
  /// Packages the width and height layout anchors into a single group.
  public var sizeAnchor: LayoutSizeAnchor {
    .init(self.widthAnchor, self.heightAnchor)
  }

  /// Packages the center X and Y layout anchors into a single group.
  public var centerAnchor: LayoutCenterCenterAnchor {
    .init(self.centerXAnchor, self.centerYAnchor)
  }

  /// Packages the top and bottom layout anchors into a single group.
  public var verticalAnchor: LayoutVerticalAnchor {
    .init(self.topAnchor, self.bottomAnchor)
  }

  /// Packages the left and right layout anchors into a single group.
  public var horizontalAnchor: LayoutHorizontalAnchor {
    .init(self.leftAnchor, self.rightAnchor)
  }

  /// Packages the leading and trailing layout anchors into a single group.
  public var directionalAnchor: LayoutDirectionalAnchor {
    .init(self.leadingAnchor, self.trailingAnchor)
  }

  /// Packages the top, left, bottom, and right layout anchors into a single group.
  public var edgeAnchor: LayoutEdgeAnchor {
    .init(self.topAnchor, self.leftAnchor, self.bottomAnchor, self.rightAnchor)
  }

  /// Packages the top, leading, bottom, and trailing layout anchors into a single group.
  public var directionalEdgeAnchor: LayoutDirectionalEdgeAnchor {
    .init(self.topAnchor, self.leadingAnchor, self.bottomAnchor, self.trailingAnchor)
  }
}
