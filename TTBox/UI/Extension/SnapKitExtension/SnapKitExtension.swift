//
//  SnapKitExtension.swift
//  TTBox
//
//  Created by Mr.hong on 2020/12/23.
//

import Foundation

//import SnapKit

public enum ConstraintAxis: Int {
    case horizontal
    case vertical
}

#if os(iOS) || os(tvOS)
    import UIKit
    public typealias ConstraintEdgeInsets = UIEdgeInsets
#else
    import AppKit
    extension NSEdgeInsets {
        public static let zero = NSEdgeInsetsZero
    }
    public typealias ConstraintEdgeInsets = NSEdgeInsets

#endif

public struct ConstraintArrayDSL {
    @discardableResult
    public func prepareConstraints(_ closure: (_ make: ConstraintMaker) -> Void) -> [Constraint] {
        var constraints = [Constraint]()
        for view in self.array {
            constraints.append(contentsOf: view.snp.prepareConstraints(closure))
        }
        return constraints
    }

    public func makeConstraints(_ closure: (_ make: ConstraintMaker) -> Void) {
        for view in self.array {
            view.snp.makeConstraints(closure)
        }
    }

    public func remakeConstraints(_ closure: (_ make: ConstraintMaker) -> Void) {
        for view in self.array {
            view.snp.remakeConstraints(closure)
        }
    }

    public func updateConstraints(_ closure: (_ make: ConstraintMaker) -> Void) {
        for view in self.array {
            view.snp.updateConstraints(closure)
        }
    }

    public func removeConstraints() {
        for view in self.array {
            view.snp.removeConstraints()
        }
    }

    /// distribute with fixed spacing
    ///
    /// - Parameters:
    ///   - axisType: which axis to distribute items along
    ///   - fixedSpacing: the spacing between each item
    ///   - leadSpacing: the spacing before the first item and the container
    ///   - tailSpacing: the spacing after the last item and the container
    public func distributeViewsAlong(
        axisType: ConstraintAxis, fixedSpacing: CGFloat = 0, leadSpacing: CGFloat = 0,
        tailSpacing: CGFloat = 0
    ) {

        guard self.array.count > 1, let tempSuperView = commonSuperviewOfViews() else {
            return
        }

        if axisType == .horizontal {
            var prev: ConstraintView?
            for (i, v) in self.array.enumerated() {
                v.snp.makeConstraints({ (make) in
                    guard let prev = prev else {  //first one
                        make.left.equalTo(tempSuperView).offset(leadSpacing)
                        return
                    }
                    make.width.equalTo(prev)
                    make.left.equalTo(prev.snp.right).offset(fixedSpacing)
                    if i == self.array.count - 1 {  //last one
                        make.right.equalTo(tempSuperView).offset(-tailSpacing)
                    }
                })
                prev = v
            }
        } else {
            var prev: ConstraintView?
            for (i, v) in self.array.enumerated() {
                v.snp.makeConstraints({ (make) in
                    guard let prev = prev else {  //first one
                        make.top.equalTo(tempSuperView).offset(leadSpacing)
                        return
                    }
                    make.height.equalTo(prev)
                    make.top.equalTo(prev.snp.bottom).offset(fixedSpacing)
                    if i == self.array.count - 1 {  //last one
                        make.bottom.equalTo(tempSuperView).offset(-tailSpacing)
                    }
                })
                prev = v
            }
        }
    }

    /// distribute with fixed item size
    ///
    /// - Parameters:
    ///   - axisType: which axis to distribute items along
    ///   - fixedItemLength: the fixed length of each item
    ///   - leadSpacing: the spacing before the first item and the container
    ///   - tailSpacing: the spacing after the last item and the container
    public func distributeViewsAlong(
        axisType: ConstraintAxis, fixedItemLength: CGFloat = 0, leadSpacing: CGFloat = 0,
        tailSpacing: CGFloat = 0
    ) {

        guard self.array.count > 1, let tempSuperView = commonSuperviewOfViews() else {
            return
        }

        if axisType == .horizontal {
            var prev: ConstraintView?
            for (i, v) in self.array.enumerated() {
                v.snp.makeConstraints({ (make) in
                    make.width.equalTo(fixedItemLength)
                    if prev != nil {
                        if i == self.array.count - 1 {  //last one
                            make.right.equalTo(tempSuperView).offset(-tailSpacing)
                        } else {
                            let offset =
                                (CGFloat(1) - (CGFloat(i) / CGFloat(self.array.count - 1)))
                                * (fixedItemLength + leadSpacing) - CGFloat(i) * tailSpacing
                                / CGFloat(self.array.count - 1)
                            make.right.equalTo(tempSuperView).multipliedBy(
                                CGFloat(i) / CGFloat(self.array.count - 1)
                            ).offset(offset)
                        }
                    } else {  //first one
                        make.left.equalTo(tempSuperView).offset(leadSpacing)
                    }
                })
                prev = v
            }
        } else {
            var prev: ConstraintView?
            for (i, v) in self.array.enumerated() {
                v.snp.makeConstraints({ (make) in
                    make.height.equalTo(fixedItemLength)
                    if prev != nil {
                        if i == self.array.count - 1 {  //last one
                            make.bottom.equalTo(tempSuperView).offset(-tailSpacing)
                        } else {
                            let offset =
                                (CGFloat(1) - (CGFloat(i) / CGFloat(self.array.count - 1)))
                                * (fixedItemLength + leadSpacing) - CGFloat(i) * tailSpacing
                                / CGFloat(self.array.count - 1)
                            make.bottom.equalTo(tempSuperView).multipliedBy(
                                CGFloat(i) / CGFloat(self.array.count - 1)
                            ).offset(offset)
                        }
                    } else {  //first one
                        make.top.equalTo(tempSuperView).offset(leadSpacing)
                    }
                })
                prev = v
            }
        }
    }

    /// distribute Sudoku with fixed item size
    ///
    /// - Parameters:
    ///   - fixedItemWidth: the fixed width of each item
    ///   - fixedItemLength: the fixed length of each item
    ///   - warpCount: the warp count in the super container
    ///   - edgeInset: the padding in the super container
    public func distributeSudokuViews(
        fixedItemWidth: CGFloat, fixedItemHeight: CGFloat, warpCount: Int,
        edgeInset: ConstraintEdgeInsets = .zero
    ) {

        guard self.array.count > 1, warpCount >= 1, let tempSuperView = commonSuperviewOfViews()
        else {
            return
        }

        let remainder = self.array.count % warpCount
        let quotient = self.array.count / warpCount

        let rowCount = (remainder == 0) ? quotient : (quotient + 1)
        let columnCount = warpCount

        for (i, v) in self.array.enumerated() {

            let currentRow = i / warpCount
            let currentColumn = i % warpCount

            v.snp.makeConstraints({ (make) in
                make.width.equalTo(fixedItemWidth)
                make.height.equalTo(fixedItemHeight)
                if currentRow == 0 {  //fisrt row
                    make.top.equalTo(tempSuperView).offset(edgeInset.top)
                }
                if currentRow == rowCount - 1 {  //last row
                    make.bottom.equalTo(tempSuperView).offset(-edgeInset.bottom)
                }

                if currentRow != 0 && currentRow != rowCount - 1 {  //other row
                    let offset =
                        (CGFloat(1) - CGFloat(currentRow) / CGFloat(rowCount - 1))
                        * (fixedItemHeight + edgeInset.top) - CGFloat(currentRow) * edgeInset.bottom
                        / CGFloat(rowCount - 1)
                    make.bottom.equalTo(tempSuperView).multipliedBy(
                        CGFloat(currentRow) / CGFloat(rowCount - 1)
                    ).offset(offset)
                }

                if currentColumn == 0 {  //first col
                    make.left.equalTo(tempSuperView).offset(edgeInset.left)
                }
                if currentColumn == columnCount - 1 {  //last col
                    make.right.equalTo(tempSuperView).offset(-edgeInset.right)
                }

                if currentColumn != 0 && currentColumn != columnCount - 1 {  //other col
                    let offset =
                        (CGFloat(1) - CGFloat(currentColumn) / CGFloat(columnCount - 1))
                        * (fixedItemWidth + edgeInset.left) - CGFloat(currentColumn)
                        * edgeInset.right / CGFloat(columnCount - 1)
                    make.right.equalTo(tempSuperView).multipliedBy(
                        CGFloat(currentColumn) / CGFloat(columnCount - 1)
                    ).offset(offset)
                }
            })
        }
    }

    /// distribute Sudoku with fixed item spacing
    ///
    /// - Parameters:
    ///   - fixedLineSpacing: the line spacing between each item
    ///   - fixedInteritemSpacing: the Interitem spacing between each item
    ///   - warpCount: the warp count in the super container
    ///   - edgeInset: the padding in the super container
    public func distributeSudokuViews(
        fixedLineSpacing: CGFloat, fixedInteritemSpacing: CGFloat, warpCount: Int,
        edgeInset: ConstraintEdgeInsets = .zero
    ) {

        guard self.array.count > 1, warpCount >= 1, let tempSuperView = commonSuperviewOfViews()
        else {
            return
        }

        let remainder = self.array.count % warpCount
        let quotient = self.array.count / warpCount

        let rowCount = (remainder == 0) ? quotient : (quotient + 1)
        let columnCount = warpCount

        var prev: ConstraintView?

        for (i, v) in self.array.enumerated() {

            let currentRow = i / warpCount
            let currentColumn = i % warpCount

            v.snp.makeConstraints({ (make) in
                guard let prev = prev else {  //first row & first col
                    make.top.equalTo(tempSuperView).offset(edgeInset.top)
                    make.left.equalTo(tempSuperView).offset(edgeInset.left)
                    return
                }
                make.width.height.equalTo(prev)
                if currentRow == rowCount - 1 {  //last row
                    if currentRow != 0 && i - columnCount >= 0 {  //just one row
                        make.top.equalTo(self.array[i - columnCount].snp.bottom).offset(
                            fixedLineSpacing)
                    }
                    make.bottom.equalTo(tempSuperView).offset(-edgeInset.bottom)
                }

                if currentRow != 0 && currentRow != rowCount - 1 {  //other row
                    make.top.equalTo(self.array[i - columnCount].snp.bottom).offset(
                        fixedLineSpacing)
                }
                if currentColumn == warpCount - 1 {  //last col
                    if currentColumn != 0 {  //just one line
                        make.left.equalTo(prev.snp.right).offset(fixedInteritemSpacing)
                    }
                    make.right.equalTo(tempSuperView).offset(-edgeInset.right)
                }

                if currentColumn != 0 && currentColumn != warpCount - 1 {  //other col
                    make.left.equalTo(prev.snp.right).offset(fixedInteritemSpacing)
                }
            })
            prev = v
        }
    }

    internal let array: [ConstraintView]

    internal init(array: [ConstraintView]) {
        self.array = array
    }

    /// distribute with the width that you give
    /// you should calculate the width of each item first
    ///
    /// - Parameters:
    ///   - verticalSpacing: the vertical spacing between each item
    ///   - horizontalSpacing: the horizontal spacing between each item
    ///   - itemHeight: the height of each item
    ///   - edgeInset: the edgeInset of all item, default is UIEdgeInsets.zero
    ///   - topConstrainView: the view before the first item
    public func distributeSudokuViews(
        verticalSpacing: CGFloat,
        horizontalSpacing: CGFloat,
        warpCount: Int,
        edgeInset: UIEdgeInsets = UIEdgeInsets.zero,
        itemHeight: CGFloat? = nil,
        topConstrainView: ConstraintView? = nil
    ) {

        guard self.array.count > 1, warpCount >= 1, let tempSuperview = commonSuperviewOfViews()
        else {
            return
        }

        let columnCount = warpCount
        let rowCount =
            self.array.count % warpCount == 0
            ? self.array.count / warpCount : self.array.count / warpCount + 1

        var prev: ConstraintView?

        for (i, v) in self.array.enumerated() {

            let currentRow = i / warpCount
            let currentColumn = i % warpCount

            v.snp.makeConstraints({ (make) in
                if prev != nil {
                    make.width.height.equalTo(prev!)
                }
                if currentRow == 0 {  //fisrt row
                    let tmpTarget =
                        topConstrainView != nil
                        ? topConstrainView!.snp.bottom : tempSuperview.snp.top
                    make.top.equalTo(tmpTarget).offset(edgeInset.top)
                    if itemHeight != nil {
                        make.height.equalTo(itemHeight!)
                    }
                }
                if currentRow == rowCount - 1 {  //last row
                    if currentRow != 0 && i - columnCount >= 0 {
                        make.top.equalTo(self.array[i - columnCount].snp.bottom).offset(
                            verticalSpacing)
                    }

                    if itemHeight != nil {
                        make.bottom.lessThanOrEqualTo(tempSuperview).offset(-edgeInset.bottom)
                    } else {
                        make.bottom.equalTo(tempSuperview).offset(-edgeInset.bottom)
                    }
                }

                if currentRow != 0 && currentRow != rowCount - 1 {  //other row
                    make.top.equalTo(self.array[i - columnCount].snp.bottom).offset(verticalSpacing)
                }

                if currentColumn == 0 {  //first col
                    make.left.equalTo(tempSuperview).offset(edgeInset.left)
                }
                if currentColumn == warpCount - 1 {  //last col
                    if currentColumn != 0 {
                        make.left.equalTo(prev!.snp.right).offset(horizontalSpacing)
                    }
                    make.right.equalTo(tempSuperview).offset(-edgeInset.right)
                }

                if currentColumn != 0 && currentColumn != warpCount - 1 {  //other col
                    make.left.equalTo(prev!.snp.right).offset(horizontalSpacing)
                }
            })
            prev = v
        }
    }

}

extension Array {
    public var snp: ConstraintArrayDSL {
        return ConstraintArrayDSL(array: self as! [ConstraintView])
    }
}

extension ConstraintArrayDSL {
    fileprivate func commonSuperviewOfViews() -> ConstraintView? {
        var commonSuperview: ConstraintView?
        var previousView: ConstraintView?

        for view in self.array {
            if previousView != nil {
                commonSuperview = view.closestCommonSuperview(commonSuperview)
            } else {
                commonSuperview = view
            }
            previousView = view
        }

        return commonSuperview
    }
}

extension ConstraintView {
    fileprivate func closestCommonSuperview(_ view: ConstraintView?) -> ConstraintView? {
        var closestCommonSuperview: ConstraintView?
        var secondViewSuperview: ConstraintView? = view
        while closestCommonSuperview == nil && secondViewSuperview != nil {
            var firstViewSuperview: ConstraintView? = self
            while closestCommonSuperview == nil && firstViewSuperview != nil {
                if secondViewSuperview == firstViewSuperview {
                    closestCommonSuperview = secondViewSuperview
                }
                firstViewSuperview = firstViewSuperview?.superview
            }
            secondViewSuperview = secondViewSuperview?.superview
        }
        return closestCommonSuperview
    }
}
