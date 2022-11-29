//
//  TTTbbarItemTuberView.swift
//  TTBox
//
//  Created by Mr.hong on 2021/2/1.
//

import Foundation

// 设置突起部分视图
class TTTbbarItemTuberView: UIView {

    // 绘制的尺寸
    var drawSourceRect = CGRect.zero

    // 绘制的突起高度
    //    var tuberHeight: CGFloat = 10

    // 绘制的填充颜色
    var drawFillColor = UIColor.white

    // 绘制的border粗细
    var drawBorderWidth: CGFloat = tabbarConfiguration.segementLineHeight

    // 绘制border的颜色
    var drawBorderColor: UIColor = tabbarConfiguration.segementLineColor

    init(drawSourceRect: CGRect, drawFillColor: UIColor, drawBorderWidth: CGFloat) {
        super.init(frame: drawSourceRect)

        debugPrint(frame)
        self.drawSourceRect = frame
        //        self.tuberHeight = tuberHeight
        self.drawFillColor = drawFillColor
        self.drawBorderWidth = drawBorderWidth
        self.backgroundColor = .clear
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        //                debugPrint(rect)
        //                self.backgroundColor = .white
        //                self.layer.backgroundColor = UIColor.clear.cgColor
        self.drawSmoothPath()
    }

    func drawSmoothPath() {
        // 高度
        let offset: CGFloat = drawSourceRect.height

        let pointCount: Int = 2
        let pointArr: NSMutableArray = NSMutableArray.init()

        for i in 0...pointCount {
            let px: CGFloat = CGFloat(i) * CGFloat(self.bounds.width / 2)
            var py: CGFloat = 0
            switch i {
            case 0:
                py = drawSourceRect.size.height
            case 1:
                py = tabbarConfiguration.segementLineHeight
            case 2:
                py = drawSourceRect.size.height
            case 3:
                py = offset + 10
            default: py = offset

            }

            let point: CGPoint = CGPoint.init(x: px, y: py)
            pointArr.add(point)
        }

        let bezierPath = UIBezierPath()
        bezierPath.lineWidth = tabbarConfiguration.segementLineHeight

        var prevPoint: CGPoint!
        for i in 0..<pointArr.count {
            let currPoint: CGPoint = pointArr.object(at: i) as! CGPoint
            // 绘制平滑曲线
            if i == 0 {
                bezierPath.move(to: currPoint)
            } else {
                let conPoint1: CGPoint = CGPoint.init(
                    x: CGFloat(prevPoint.x + currPoint.x) / 2.0, y: prevPoint.y)
                let conPoint2: CGPoint = CGPoint.init(
                    x: CGFloat(prevPoint.x + currPoint.x) / 2.0, y: currPoint.y)
                bezierPath.addCurve(
                    to: currPoint, controlPoint1: conPoint1, controlPoint2: conPoint2)
            }
            prevPoint = currPoint
        }

        self.drawBorderColor.setStroke()
        bezierPath.stroke()

        // 绘制直线
        let linepath = UIBezierPath()
        linepath.move(to: pointArr.lastObject as! CGPoint)
        linepath.addLine(to: pointArr.firstObject as! CGPoint)
        linepath.lineWidth = tabbarConfiguration.segementLineHeight
        UIColor.clear.setStroke()
        linepath.stroke()

        self.drawFillColor.setFill()
        bezierPath.fill()
    }
}
