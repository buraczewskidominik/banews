//
//  UIView+Autolayout.swift
//  BANews
//
//  Created by Dominik Buraczewski on 22/11/2021.
//

import UIKit

typealias Constraint = (_ layoutView: UIView) -> NSLayoutConstraint

extension UIView {

    /// Adds constraints using NSLayoutAnchors, based on description provided in params.
    /// Please refer to helper equal funtions for info how to generate constraints easily.
    ///
    /// - Parameter constraintDescription: closure that returns [Constraint]
    /// - Returns: created constraints
    @discardableResult
    func addConstraints(_ constraintDescription: (UIView) -> [Constraint]) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        let constraints: [Constraint] = constraintDescription(self)
        let nsLayoutConstraints = constraints.map { $0(self) }
        NSLayoutConstraint.activate(nsLayoutConstraints)
        return nsLayoutConstraints
    }

    /// Describes constraint that is equal to constraint from other view.
    /// Example: `equalTo(labelView, \.centerXAnchor, \.centerXAnchor) will align
    /// view centerXAnchor to labelView centerXAnchor`
    ///
    /// - Parameters:
    ///   - view: that constrain should relate to
    ///   - fromAnchor: constraints key path of current view
    ///   - toAnchor: constraints key path of related view
    ///   - constant: value
    /// - Returns: created constraint
    func equalTo<Anchor, Axis>(
        _ view: UIView,
        _ fromAnchor: KeyPath<UIView, Anchor>,
        _ toAnchor: KeyPath<UIView, Anchor>,
        constant: CGFloat = 0
    ) -> Constraint where Anchor: NSLayoutAnchor<Axis> {
        return { layoutView in
            layoutView[keyPath: fromAnchor].constraint(equalTo: view[keyPath: toAnchor], constant: constant)
        }
    }

    /// Describes constraint that is equal to constraint from other view.
    /// Example: `equalTo(labelView, \.centerXAnchor) will align view centerXAnchor to superview centerXAnchor`
    ///
    /// - Parameters:
    ///   - view: that constrain should relate to
    ///   - fromAnchor: constraints key path of current view
    ///   - toAnchor: constraints key path of related view
    ///   - constant: value
    /// - Returns: created constraint
    func equalTo<Anchor>(
        _ view: UIView,
        _ fromAnchor: KeyPath<UIView, Anchor>,
        _ toAnchor: KeyPath<UIView, Anchor>,
        constant: CGFloat = 0
    ) -> Constraint where Anchor: NSLayoutXAxisAnchor {
        return { layoutView in
            layoutView[keyPath: fromAnchor].constraint(equalTo: view[keyPath: toAnchor], constant: constant)
        }
    }

    /// Describes constraint that is equal to constraint from other view.
    /// Example: `equalTo(labelView, \.heightAnchor, \.heightAnchor) will align
    /// view heightAnchor to labelView heightAnchor`
    ///
    /// - Parameters:
    ///   - view: that constrain should relate to
    ///   - fromAnchor: constraints key path of current view
    ///   - toAnchor: constraints key path of related view
    ///   - multiplier: value
    /// - Returns: created constraint
    func equalTo<LayoutDimension>(
        _ view: UIView,
        _ fromAnchor: KeyPath<UIView, LayoutDimension>,
        _ toAnchor: KeyPath<UIView, LayoutDimension>,
        multiplier: CGFloat = 1
    ) -> Constraint where LayoutDimension: NSLayoutDimension {
        return { layoutView in
            layoutView[keyPath: fromAnchor].constraint(equalTo: view[keyPath: toAnchor], multiplier: multiplier)
        }
    }

    /// Describes constraint that is greater than or equal to constraint from other view.
    ///
    /// - Parameters:
    ///   - view: that constrain should relate to
    ///   - fromAnchor: constraints key path of current view
    ///   - toAnchor: constraints key path of related view
    ///   - constant: value
    /// - Returns: created constraint
    func greaterThanOrEqualTo<Anchor, Axis>(
        _ view: UIView,
        _ fromAnchor: KeyPath<UIView, Anchor>,
        _ toAnchor: KeyPath<UIView, Anchor>,
        constant: CGFloat = 0) -> Constraint where Anchor: NSLayoutAnchor<Axis> {
        return { layoutView in
            layoutView[keyPath: fromAnchor]
                .constraint(greaterThanOrEqualTo: view[keyPath: toAnchor], constant: constant)
        }
    }

    /// Describes constraint that is less than or equal to constraint from other view.
    ///
    /// - Parameters:
    ///   - view: that constrain should relate to
    ///   - fromAnchor: constraints key path of current view
    ///   - toAnchor: constraints key path of related view
    ///   - constant: value
    /// - Returns: created constraint
    func lessThanOrEqualTo<Anchor, Axis>(
        _ view: UIView,
        _ fromAnchor: KeyPath<UIView, Anchor>,
        _ toAnchor: KeyPath<UIView, Anchor>,
        constant: CGFloat = 0) -> Constraint where Anchor: NSLayoutAnchor<Axis> {
        return { layoutView in
            layoutView[keyPath: fromAnchor]
                .constraint(lessThanOrEqualTo: view[keyPath: toAnchor], constant: constant)
        }
    }

    /// Describes constraint that is greater than or equal to constraint from other view.
    ///
    /// - Parameters:
    ///   - view: that constrain should relate to
    ///   - fromAnchor: constraints key path of current view
    ///   - toAnchor: constraints key path of related view
    ///   - constant: value
    /// - Returns: created constraint
    func greaterThanOrEqualTo<Anchor>(
        _ view: UIView,
        _ fromAnchor: KeyPath<UIView, Anchor>,
        _ toAnchor: KeyPath<UIView, Anchor>,
        constant: CGFloat = 0
    ) -> Constraint where Anchor: NSLayoutXAxisAnchor {
        return { layoutView in
            layoutView[keyPath: fromAnchor]
                .constraint(greaterThanOrEqualTo: view[keyPath: toAnchor], constant: constant)
        }
    }

    /// Describes constraint that is less than or equal to constraint from other view.
    ///
    /// - Parameters:
    ///   - view: that constrain should relate to
    ///   - fromAnchor: constraints key path of current view
    ///   - toAnchor: constraints key path of related view
    ///   - constant: value
    /// - Returns: created constraint
    func lessThanOrEqualTo<Anchor>(
        _ view: UIView,
        _ fromAnchor: KeyPath<UIView, Anchor>,
        _ toAnchor: KeyPath<UIView, Anchor>,
        constant: CGFloat = 0
    ) -> Constraint where Anchor: NSLayoutXAxisAnchor {
        return { layoutView in
            layoutView[keyPath: fromAnchor]
                .constraint(lessThanOrEqualTo: view[keyPath: toAnchor], constant: constant)
        }
    }

    /// Describes constraint that is greater than or equal to constraint from other view.
    ///
    /// - Parameters:
    ///   - view: that constrain should relate to
    ///   - fromAnchor: constraints key path of current view
    ///   - toAnchor: constraints key path of related view
    ///   - constant: value
    /// - Returns: created constraint
    func greaterThanOrEqualTo<LayoutDimension>(
        _ view: UIView,
        _ fromAnchor: KeyPath<UIView, LayoutDimension>,
        _ toAnchor: KeyPath<UIView, LayoutDimension>,
        constant: CGFloat = 0
    ) -> Constraint where LayoutDimension: NSLayoutDimension {
        return { layoutView in
            layoutView[keyPath: fromAnchor]
                .constraint(greaterThanOrEqualTo: view[keyPath: toAnchor], constant: constant)
        }
    }

    /// Describes constraint that is greater than or equal to constraint from other view.
    ///
    /// - Parameters:
    ///   - view: that constrain should relate to
    ///   - fromAnchor: constraints key path of current view
    ///   - toAnchor: constraints key path of related view
    ///   - multiplier: value
    /// - Returns: created constraint
    func greaterThanOrEqualTo<LayoutDimension>(
        _ view: UIView,
        _ fromAnchor: KeyPath<UIView, LayoutDimension>,
        _ toAnchor: KeyPath<UIView, LayoutDimension>,
        multiplier: CGFloat
    ) -> Constraint where LayoutDimension: NSLayoutDimension {
        return { layoutView in
            layoutView[keyPath: fromAnchor]
                .constraint(greaterThanOrEqualTo: view[keyPath: toAnchor], multiplier: multiplier)
        }
    }

    /// Describes constraint that is equal to constraint from superview.
    /// Example: `equal(\.leadingAnchor) will align view leadingAnchor to superview leadingAnchor with defined constant`
    ///
    /// - Parameters:
    ///   - anchor: constraints key path of current view
    ///   - constant: value
    /// - Returns: created constraint
    /// - Warning: This method uses force-unwrap on view's superview!
    func equal<Anchor, Axis>(
        _ anchor: KeyPath<UIView, Anchor>,
        constant: CGFloat = 0
    ) -> Constraint where Anchor: NSLayoutAnchor<Axis> {
        return equalTo(superview!, anchor, anchor, constant: constant)
    }

    /// Describes constraint that is equal to constraint from superview.
    /// Example: `equal(\.leadingAnchor) will align view leadingAnchor to superview leadingAnchor`
    ///
    /// - Parameters:
    ///   - anchor: constraints key path of current view
    ///   - constant: value
    /// - Returns: created constraint
    /// - Warning: This method uses force-unwrap on view's superview!
    func equal<Anchor>(
        _ anchor: KeyPath<UIView, Anchor>,
        constant: CGFloat = 0
    ) -> Constraint where Anchor: NSLayoutXAxisAnchor {
        return equalTo(superview!, anchor, anchor, constant: constant)
    }

    /// Describes constraint that is equal to constraint from superview.
    /// Example: `equal(\.heightAnchor, multiplier: 0.5) will align
    /// view heightAnchor to superview heightAnchor multiplied by 0.5`
    ///
    /// - Parameters:
    ///   - anchor: constraints key path of current view
    ///   - multiplier: value
    /// - Returns: created constraint
    /// - Warning: This method uses force-unwrap on view's superview!
    func equal<LayoutDimension>(
        _ anchor: KeyPath<UIView, LayoutDimension>,
        multiplier: CGFloat = 1
    ) -> Constraint where LayoutDimension: NSLayoutDimension {
        return equalTo(superview!, anchor, anchor, multiplier: multiplier)
    }

    /// Describes edges that are equal to superview edges
    /// - Returns: created constraints
    func equalEdges() -> [Constraint] {
        [
            equal(.top),
            equal(.bottom),
            equal(.leading),
            equal(.trailing)
        ]
    }

    /// Describes edges that are equal to superview safe area edges
    /// - Returns: created constraints
    /// - Warning: This method uses force-unwrap on view's superview!
    func equalSafeAreaEdges() -> [Constraint] {
        [
            equalTo(superview!, .top, .safeAreaTop),
            equalTo(superview!, .bottom, .safeAreaBottom),
            equal(.leading),
            equal(.trailing)
        ]
    }

    /// Describes constraint that is equal to width or height constant.
    /// Example: `equal(\.heightAnchor, 100) will align view heightAnchor to 100 constant value`
    ///
    /// - Parameters:
    ///   - anchor: constraints key path of current view
    ///   - constant: value
    /// - Returns: created constraint
    func equalConstant<LayoutDimension>(
        _ anchor: KeyPath<UIView, LayoutDimension>,
        _ constant: CGFloat
    ) -> Constraint where LayoutDimension: NSLayoutDimension {
        return { layoutView in
            layoutView[keyPath: anchor].constraint(equalToConstant: constant)
        }
    }

    /// Describes constraint that is greater than or equal to width or height constant.
    /// Example: `greaterThanOrEqualConstant(\.heightAnchor, 100) will align
    /// view heightAnchor to 100 constant value (or greater if valid)`
    ///
    /// - Parameters:
    ///   - anchor: constraints key path of current view
    ///   - constant: value
    /// - Returns: created constraint
    func greaterThanOrEqualConstant<LayoutDimension>(
        _ anchor: KeyPath<UIView, LayoutDimension>,
        _ constant: CGFloat
    ) -> Constraint where LayoutDimension: NSLayoutDimension {
        return { layoutView in
            layoutView[keyPath: anchor].constraint(greaterThanOrEqualToConstant: constant)
        }
    }
}

extension KeyPath where Root == UIView, Value == NSLayoutYAxisAnchor {

    static var top: KeyPath<UIView, NSLayoutYAxisAnchor> {
        \.topAnchor
    }

    static var bottom: KeyPath<UIView, NSLayoutYAxisAnchor> {
        \.bottomAnchor
    }

    static var safeAreaTop: KeyPath<UIView, NSLayoutYAxisAnchor> {
        if #available(iOS 11.0, *) {
            return \.safeAreaLayoutGuide.topAnchor
        } else {
            return top
        }
    }

    static var safeAreaBottom: KeyPath<UIView, NSLayoutYAxisAnchor> {
        if #available(iOS 11.0, *) {
            return \.safeAreaLayoutGuide.bottomAnchor
        } else {
            return bottom
        }
    }

    static var centerY: KeyPath<UIView, NSLayoutYAxisAnchor> {
        \.centerYAnchor
    }
}

extension KeyPath where Root == UIView, Value == NSLayoutXAxisAnchor {

    static var leading: KeyPath<UIView, NSLayoutXAxisAnchor> {
        \.leadingAnchor
    }

    static var trailing: KeyPath<UIView, NSLayoutXAxisAnchor> {
        \.trailingAnchor
    }

    static var centerX: KeyPath<UIView, NSLayoutXAxisAnchor> {
        \.centerXAnchor
    }
}

extension KeyPath where Root == UIView, Value == NSLayoutDimension {

    static var width: KeyPath<UIView, NSLayoutDimension> {
        \.widthAnchor
    }

    static var height: KeyPath<UIView, NSLayoutDimension> {
        \.heightAnchor
    }
}

