/// Protocol defining the basic functionality of a constraint (or group of constraints).
public protocol LayoutConstraint {
    /// Type that will identify this constraint (or group of constraints).
    associatedtype Identifier
    /// Enables/Disables a constraint (or group of constraints) and returns the receiving object.
    /// - parameter isActivie: Boolean indicating whether the constraint will be active after calling this function.
    /// - returns: The modified constraint.
    func activating(_ isActive: Bool) -> Self
    /// Identifies the receiving constraint (or group of constraints) with the passed argument.
    /// - parameter identifier: Instance identifying the constraint (or group of constraints).
    /// - returns: The modified constraint.
    func identifying(_ identifier: Identifier) -> Self
    /// Set the priority of the receiving constraint (or group of constraints) with the passed argument.
    /// - parameter priority: Priority to set on all constraint.
    /// - returns: The modified constraint.
    func prioritizing(_ priority: LayoutPriority) -> Self
}

/// Defines a group where all constraints work to target the same objective.
public protocol LayoutConstraintGroup: LayoutConstraint {
    /// All the constraints working together.
    associatedtype Members
    /// Returns all members of the receiving constraint group.
    var all: Self.Members { get }
    /// Perform the given operation on each and every member.
    /// - parameter operation: The operation to be perform in a member.
    func setMembers(with operation: (NSLayoutConstraint)->())
//    func setMembers(_ operation: (NSLayoutConstraint)->())
    /// Set the identifier of every constraint in the group by joining `root` to each identifier element.
    /// - parameter root: The `String` root to be preppended on all constraints.
    /// - parameter identifiers: The elements identifying each member.
    func identifying(root: String, _ identifiers: Identifier) -> Self
    /// Static function similar to an initializer.
    /// - parameter members: The constraint members of this layout constraint group.
    /// - returns: The created group containing the passed members.
    static func make(with members: Self.Members) -> Self
}

extension LayoutConstraintGroup {
    public func activating(_ isActive: Bool) -> Self {
        self.setMembers { $0.isActive = isActive }
        return self
    }
    
    public func prioritizing(_ priority: LayoutPriority) -> Self {
        self.setMembers { $0.priority = priority }
        return self
    }
}

extension LayoutConstraintGroup where Self.Members == (NSLayoutConstraint, NSLayoutConstraint), Self.Identifier == (String, String) {
    public func setMembers(with operation: (NSLayoutConstraint)->()) {
        let all = self.all
        operation(all.0)
        operation(all.1)
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

extension LayoutConstraintGroup where Self.Members == (NSLayoutConstraint, NSLayoutConstraint, NSLayoutConstraint, NSLayoutConstraint), Self.Identifier == (String, String, String, String) {
    public func setMembers(with operation: (NSLayoutConstraint)->()) {
        let all = self.all
        operation(all.0)
        operation(all.1)
        operation(all.2)
        operation(all.3)
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
