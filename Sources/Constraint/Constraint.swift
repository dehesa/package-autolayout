/// Protocol defining the basic functionality of a constraint (or group of constraints).
public protocol LayoutConstraint {
    /// The constant used on the layout constraint expressions.
    associatedtype Constant: LayoutConstant
    /// Type that will identify this constraint (or group of constraints).
    associatedtype Identifier
    
    /// The constant added to the multiplied second attribute participating in the constraint.
    /// Unlike the other properties, the constant can be modified after constraint creation. Setting the constant on an existing constraint performs much better than removing the constraint and adding a new one that's exactly like the old except that it has a different constant.
    var constant: Constant { get set }
    /// Enables/Disables a constraint (or group of constraints) and returns the receiving object.
    /// - parameter isActivie: Boolean indicating whether the constraint will be active after calling this function.
    /// - returns: The modified constraint.
    @discardableResult
    func activating(_ isActive: Bool) -> Self
    /// Identifies the receiving constraint (or group of constraints) with the passed argument.
    /// - parameter identifier: Instance identifying the constraint (or group of constraints).
    /// - returns: The modified constraint.
    @discardableResult
    func identifying(_ identifier: Identifier) -> Self
    /// Set the priority of the receiving constraint (or group of constraints) with the passed argument.
    /// - parameter priority: Priority to set on all constraint.
    /// - returns: The modified constraint.
    @discardableResult
    func prioritizing(_ priority: LayoutPriority) -> Self
}

/// Defines a group where all constraints work to target the same objective.
public protocol LayoutConstraintGroup: LayoutConstraint where Self.Constant: LayoutConstantGroup {
    /// All the constraints working together.
    associatedtype Members
    
    /// Returns all members of the receiving constraint group.
    var all: Self.Members { get }
    /// Perform the given operation on each and every member.
    /// - parameter operation: The operation to be perform in a member.
    func setMembers(with operation: (NSLayoutConstraint)->())
    /// Set the identifier of every constraint in the group by joining `root` to each identifier element.
    /// - parameter root: The `String` root to be preppended on all constraints.
    /// - parameter identifiers: The elements identifying each member.
    @discardableResult
    func identifying(root: String, _ identifiers: Identifier) -> Self
    /// Static function similar to an initializer.
    /// - parameter members: The constraint members of this layout constraint group.
    /// - returns: The created group containing the passed members.
    static func make(with members: Self.Members) -> Self
}

extension LayoutConstraintGroup {
    @discardableResult
    public func activating(_ isActive: Bool) -> Self {
        self.setMembers { $0.isActive = isActive }
        return self
    }
    
    @discardableResult
    public func prioritizing(_ priority: LayoutPriority) -> Self {
        self.setMembers { $0.priority = priority }
        return self
    }
}

extension LayoutConstraintGroup where Self.Members == (NSLayoutConstraint, NSLayoutConstraint), Self.Constant.Members == (CGFloat,CGFloat), Self.Identifier == (String, String) {
    public func setMembers(with operation: (NSLayoutConstraint)->()) {
        let all = self.all
        operation(all.0)
        operation(all.1)
    }
    
    public var constant: Self.Constant {
        get {
            let constraints = self.all
            var result: Self.Constant = .init()
            result.set(with: (constraints.0.constant, constraints.1.constant))
            return result
        }
        set {
            let constraints = self.all
            let constants = newValue.all
            constraints.0.constant = constants.0
            constraints.1.constant = constants.1
        }
    }
    
    public func identifying(_ identifier: Self.Identifier) -> Self {
        let all = self.all
        all.0.identifier = identifier.0
        all.1.identifier = identifier.1
        return self
    }
    
    public func identifying(root: String, _ identifiers: Self.Identifier) -> Self {
        let all = self.all
        all.0.identifier = root.appending(identifiers.0)
        all.1.identifier = root.appending(identifiers.1)
        return self
    }
}

extension LayoutConstraintGroup where Self.Members == (NSLayoutConstraint, NSLayoutConstraint, NSLayoutConstraint, NSLayoutConstraint), Self.Constant.Members == (CGFloat,CGFloat,CGFloat,CGFloat), Self.Identifier == (String, String, String, String) {
    public func setMembers(with operation: (NSLayoutConstraint)->()) {
        let all = self.all
        operation(all.0)
        operation(all.1)
        operation(all.2)
        operation(all.3)
    }
    
    public var constant: Self.Constant {
        get {
            let constraints = self.all
            var result: Self.Constant = .init()
            result.set(with: (constraints.0.constant,
                              constraints.1.constant,
                              constraints.2.constant,
                              constraints.3.constant))
            return result
        }
        set {
            let (constraints, constants) = (self.all, newValue.all)
            constraints.0.constant = constants.0
            constraints.1.constant = constants.1
            constraints.2.constant = constants.2
            constraints.3.constant = constants.3
        }
    }
    
    public func identifying(_ identifier: Self.Identifier) -> Self {
        let all = self.all
        all.0.identifier = identifier.0
        all.1.identifier = identifier.1
        all.2.identifier = identifier.2
        all.3.identifier = identifier.3
        return self
    }
    
    public func identifying(root: String, _ identifiers: Self.Identifier) -> Self {
        let all = self.all
        all.0.identifier = root.appending(identifiers.0)
        all.1.identifier = root.appending(identifiers.1)
        all.2.identifier = root.appending(identifiers.2)
        all.3.identifier = root.appending(identifiers.3)
        return self
    }
}
