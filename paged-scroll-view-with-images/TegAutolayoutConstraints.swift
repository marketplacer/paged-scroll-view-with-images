//
//  TegAlign.swift
//
//  Collection of shortcuts to create autolayout constraints.
//
//  Created by Evgenii Neumerzhitckii on 27/10/2014.
//  Copyright (c) 2014 The Exchange Group Pty Ltd. All rights reserved.
//

import UIKit

class TegAutolayoutConstraints {
  class func centerX(viewOne: UIView, viewTwo: UIView,
    constraintContainer: UIView) -> [NSLayoutConstraint] {

      return center(viewOne, viewTwo: viewTwo, constraintContainer: constraintContainer, vertically: false)
  }

  class func centerY(viewOne: UIView, viewTwo: UIView,
    constraintContainer: UIView) -> [NSLayoutConstraint] {

      return center(viewOne, viewTwo: viewTwo, constraintContainer: constraintContainer, vertically: true)
  }

  private class func center(viewOne: UIView, viewTwo: UIView,
    constraintContainer: UIView, vertically: Bool = false) -> [NSLayoutConstraint] {

      let attribute = vertically ? NSLayoutAttribute.CenterY : NSLayoutAttribute.CenterX

      let constraint = NSLayoutConstraint(
        item: viewOne,
        attribute: attribute,
        relatedBy: NSLayoutRelation.Equal,
        toItem: viewTwo,
        attribute: attribute,
        multiplier: 1,
        constant: 0)

      constraintContainer.addConstraint(constraint)

      return [constraint]
  }

  class func alignSameAttributes(item: AnyObject, toItem: AnyObject,
    constraintContainer: UIView, attribute: NSLayoutAttribute, margin: CGFloat = 0) -> [NSLayoutConstraint] {

      let constraint = NSLayoutConstraint(
        item: item,
        attribute: attribute,
        relatedBy: NSLayoutRelation.Equal,
        toItem: toItem,
        attribute: attribute,
        multiplier: 1,
        constant: margin)

      constraintContainer.addConstraint(constraint)

      return [constraint]
  }

  class func alignToBottomLayoutGuide(item: AnyObject, bottomLayoutGuide: UILayoutSupport,
    constraintContainer: UIView, margin: CGFloat = 0) -> [NSLayoutConstraint] {

      let constraint = NSLayoutConstraint(
        item: item,
        attribute: NSLayoutAttribute.Bottom,
        relatedBy: NSLayoutRelation.Equal,
        toItem: bottomLayoutGuide,
        attribute: NSLayoutAttribute.Top,
        multiplier: 1,
        constant: margin)

      constraintContainer.addConstraint(constraint)

      return [constraint]
  }

  class func aspectRatio(view: UIView, ratio: CGFloat) {
    let constraint = NSLayoutConstraint(
      item: view,
      attribute: NSLayoutAttribute.Width,
      relatedBy: NSLayoutRelation.Equal,
      toItem: view,
      attribute: NSLayoutAttribute.Height,
      multiplier: ratio,
      constant: 0)

    view.addConstraint(constraint)
  }

  class func fillParent(view: UIView, parentView: UIView, margin: CGFloat = 0, vertically: Bool = false) {
    var marginFormat = ""

    if margin != 0 {
      marginFormat = "-\(margin)-"
    }

    var format = "|\(marginFormat)[view]\(marginFormat)|"

    if vertically {
      format = "V:" + format
    }

    let constraints = NSLayoutConstraint.constraintsWithVisualFormat(format,
      options: nil, metrics: nil,
      views: ["view": view])

    parentView.addConstraints(constraints)
  }

  class func twoViewsNextToEachOther(viewOne: UIView, viewTwo: UIView,
    constraintContainer: UIView, margin: CGFloat = 0,
    vertically: Bool = false) -> [NSLayoutConstraint] {

      var marginFormat = ""

      if margin != 0 {
        marginFormat = "-\(margin)-"
      }

      var format = "[viewOne]\(marginFormat)[viewTwo]"

      if vertically {
        format = "V:" + format
      }

      let constraints = NSLayoutConstraint.constraintsWithVisualFormat(format,
        options: nil, metrics: nil,
        views: [ "viewOne": viewOne, "viewTwo": viewTwo ]) as [NSLayoutConstraint]

      constraintContainer.addConstraints(constraints)

      return constraints
  }

  class func equalWidth(viewOne: UIView, viewTwo: UIView,
    constraintContainer: UIView) -> [NSLayoutConstraint] {

      let constraints = NSLayoutConstraint.constraintsWithVisualFormat("[viewOne(==viewTwo)]",
        options: nil, metrics: nil,
        views: ["viewOne": viewOne, "viewTwo": viewTwo]) as [NSLayoutConstraint]

      constraintContainer.addConstraints(constraints)

      return constraints
  }

  class func height(view: UIView, value: CGFloat) -> [NSLayoutConstraint] {
    let constraint = NSLayoutConstraint(
      item: view,
      attribute: NSLayoutAttribute.Height,
      relatedBy: NSLayoutRelation.Equal,
      toItem: nil,
      attribute: NSLayoutAttribute.NotAnAttribute,
      multiplier: 1,
      constant: value)

    view.addConstraint(constraint)

    return [constraint]
  }
}
