<p align="center">
    <img src="Assets/Autolayout.png" alt="Logo & Name"/>
</p>

Non verbose way to create constraints and work with anchors.

![Swift 4.2.x](https://img.shields.io/badge/Swift-4.2-orange.svg) ![platforms](https://img.shields.io/badge/platforms-iOS%20%7C%20macOS%20%7C%20tvOS-lightgrey.svg) [![License](http://img.shields.io/:license-mit-blue.svg)](http://doge.mit-license.org)

This framework provides:
- **Operators** (custom and overloads) for anchors and constraints.
  Let you define constraints simply and clearly.
  ```swift
  view.topAnchor == superview.topAnchor ~ .high + 10
  ```
  It also lets you store the constraint after definition.
  ```swift
  let constraint = view.topAnchor == superview.topAnchor ~ .high ↑ "CustomIdentifier"
  ```
- **Anchor groups**.
  Autolayout provide group of anchors that usually perform similar operations. Such as horizontal anchors (left, right), directional anchors (leading, trailing), edge anchors (top, left, bottom, right), etc.
  ```swift
  scrollview.edgeAnchor == superview.edgeAnchor
  ```
  It lets you work with anchor groups similarly than you would work with simple anchors.
  ```swift
  scrollview.edgeAnchor == superview.edgeAnchor + 5 ~ .low
  ```
- **Constraint containers**.
  It let you store or access easily constraints created through anchor groups.
  ```swift
  let container = view.directionalEdgeAnchor >= superview.directionalEdgeAnchor + 3 ~ .required
  container.leading.constant = 10
  container.bottom.isActive = true
  ```
  Autolayout lets you perform normal constraint operations on the whole constraint container.
  ```swift
  container.constant = 10
  ```
- **Compile-time constraint creation checks**.
  You can only perform operations on compatible types. For example, none of following lines will compile:
  ```swift
  view.horizontalAnchor == superview.directionalAnchor
  view.sizeAnchor >= superview.verticalAnchor
  ```
License
=======

This code and tool is under the MIT License. See LICENSE file in this repository.

> Any ideas and contributions welcome!

## Disclaimer
This framework was initially influenced by [Anchorage](https://github.com/Raizlabs/Anchorage) by [Raizlabs](https://www.raizlabs.com). Although the syntax is similar, Autolayout provide a completely different internals and generics system to facilitate compile-time checks and group operations (such as activity or constant settings).

In any case, [Anchorage](https://github.com/Raizlabs/Anchorage) is still a great tool that I thoroughly recommend to anyone ;)
