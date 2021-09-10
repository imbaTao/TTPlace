//
//  ViewController1.swift
//  TTPlace
//
//  Created by Mr.hong on 2020/10/26.
//  Copyright © 2020 Mr.hong. All rights reserved.
//

//import UIKit
import Foundation
import RxSwift
import Alamofire
import SwiftyJSON
import Kingfisher
import RxCocoa
import HandyJSON
import SwiftyJSON



extension CGSize {
    static var screenSize: CGSize {
        return UIScreen.main.bounds.size
    }
}


class CustomLayout: UICollectionViewFlowLayout {
    // 内容区域总大小，不是可见区域
    override var collectionViewContentSize: CGSize {
        // 获取单元格个数
        let sectionCount = self.collectionView!.numberOfSections
        return CGSize(width: SCREEN_W * CGFloat(sectionCount), height: SCREEN_H - 1)
    }
    
    // 所有单元格位置属性
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        // 创建属性数组
        var attributesArray = [UICollectionViewLayoutAttributes]()
        
        // 获取单元格个数
        let sectionCount = self.collectionView!.numberOfSections
        
        // 组数
        for section in 0..<sectionCount {
            // 获取单元格个数
            let itemCount = self.collectionView!.numberOfItems(inSection: section)
            
            // 循环创建单元格的属性
            for i in 0..<itemCount {
                let indexPath = IndexPath(item: i, section: section)
                let layoutAttributes = self.layoutAttributesForItem(at: indexPath)
                attributesArray.append(layoutAttributes!)
            }
        }
        
        return attributesArray
    }
    
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        // 获取当前的布局属性
        let attribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
        
        let section = indexPath.section
        let row = indexPath.row
        
        var itemSize: CGSize!
        var itemX: CGFloat = SCREEN_W * CGFloat(section)
        var itemY: CGFloat = 0
    
        
        // 间距
        var itemSegmentInterval: CGFloat = 2
        let itemCount = self.collectionView!.numberOfItems(inSection: section)
        
        switch section {
        case 0:
            itemSize = CGSize.screenSize
        default:
            switch itemCount {
            case 1:
                itemSize = CGSize.screenSize
            case 2:
                itemSize = sdLandSize(359, 202)
                let leftInterVal: CGFloat = (SCREEN_W - itemSize.width * 2) / 2
                
                // X轴 = 起始x + 左侧间距 +
                itemX += leftInterVal + CGFloat(row % 2) * itemSize.width + CGFloat(row % 2) * 2
                itemY = (SCREEN_H - itemSize.height) / 2.0
            case 3,4:
                itemSize = sdLandSize(327, 184)
                let leftInterVal: CGFloat = (SCREEN_W - itemSize.width * 2) / 2
                let topInterVal: CGFloat = (SCREEN_H - itemSize.height * 2 - itemSegmentInterval) / 2
                itemX += leftInterVal + CGFloat(row % 2) * itemSize.width + CGFloat(row % 2) * 2
                
                
                // 先取整，再转float
                let lineNumber = CGFloat(Int(Double(row) / 2.0))
                itemY += topInterVal +  lineNumber * itemSize.height  + itemSegmentInterval * lineNumber
            default:
                break
            }
            break
        }
        
        attribute.frame = CGRect.init(x: itemX, y: itemY, width: itemSize.width, height: itemSize.height)
        return attribute
    }
}

// 根据宽高设置尺寸
func sdLandSize(_ width: CGFloat,_ height: CGFloat) -> CGSize {
    let muti = SCREEN_H / 375.0
    let heightValue = muti * height
    let widthValue = heightValue * width / height
    return CGSize.init(width: widthValue, height: heightValue)
}


class ViewController: TTViewController {
    
}

class ViewController1: UIViewController {
    
//    lazy var coreCollectionView: TTCollectionView = {
////        let layout = MeetWindowFlowLayout()
//
//
//        return coreCollectionView
//    }()
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        hiddenNavigationBar()
     
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(configureView),
                                               name: Notification.Name("INJECTION_BUNDLE_NOTIFICATION"), object: nil)
        configureView()
        
        
//        var dateNow = Date.init()
//        var  dateFormatter = DateFormatter.init()
//        dateFormatter.dateFormat = "YYYY-MM-dd HH:mm:ss"
//
//        let timeZone = NSTimeZone.system
//        dateFormatter.timeZone = timeZone
//
//        // 计算本地时区与GMT时区的时间差
//        let interval = timeZone.secondsFromGMT()
//
//        // 在GMT时间基础上追加时间差值，得到本地时间
//        dateNow = dateNow.addingTimeInterval(TimeInterval(interval))
//
//        print("121")
//
//        let dateNowString = dateFormatter.string(from: dateNow)
//
//        print("11")
        
        
        
        
    }
    
    
    

    
    // 问题是，我如何重新拿到之前布局的UI控件，做刷新
    @objc func configureView()  {
        view.removeAllSubviews()
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.navigationBar.isTranslucent = true
        
        let coreView = CoreView()
        addSubview(coreView)
        coreView.backgroundColor = .cyan
        coreView.snp.makeConstraints { (make) in
//            make.edges.equalToSuperview()
            make.left.top.bottom.equalToSuperview()
            make.size.equalTo(CGSize.init(width: SCREEN_W, height: SCREEN_H))
            
        }
        
        
        let layout = CustomLayout()
        layout.scrollDirection = .horizontal
        let coreCollectionView = TTCollectionView.init(classTypes: [TTCollectionViewCell.self,TTCollectionViewCell.self], flowLayout: layout)
        coreCollectionView.isPagingEnabled = true
        addSubview(coreCollectionView)
        coreCollectionView.dataSource = self
        coreCollectionView.delegate = self
        
        if let gestureRecognizers = coreCollectionView.gestureRecognizers {
            for gesture in gestureRecognizers  {
                gesture.delegate = coreView
            }
        }
       
        
        if #available(iOS 13.0, *) {
            coreCollectionView.automaticallyAdjustsScrollIndicatorInsets = false
        } else {
            // Fallback on earlier versions
        }
        
        if #available(iOS 11.0, *) {
            coreCollectionView.contentInsetAdjustmentBehavior = .never
        } else {
            // Fallback on earlier versions
        }

        coreCollectionView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.top.bottom.equalToSuperview()
            make.width.equalTo(SCREEN_W)
        }
        
        let testTouchView = TestView2()
        addSubview(testTouchView)
        testTouchView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
//        testTouchView.backgroundColor = rgba(255, 182, 193, 0.6)
        testTouchView.backgroundColor = rgba(255, 182, 193, 0.8)
        testTouchView.rx.tapGesture { (tapGesture, delegate) in
            tapGesture.delegate = testTouchView
        }.skip(1).subscribe(onNext: {[weak self] (_) in guard let self = self else { return }
            testTouchView.isHidden = !testTouchView.isHidden
        }).disposed(by: rx.disposeBag)
        
       
   }
}



class CoreView: UIScrollView, UIGestureRecognizerDelegate {
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        print("进来了 -- coreView")
        
        return true
    }
}


class TestView2: View,UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        print("进来了 -- View")
//        if gestureRecognizer.isKind(of: UITapGestureRecognizer.self) {
//            print("执行了点击")
//
//            return true
//        }
////
////
//        print("没有响应")
//        print("没有响应")
//        print("没有响应")
        return true
    }
    
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}



extension ViewController1: UIGestureRecognizerDelegate {
}




extension ViewController1: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout  {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 4
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 2
        case 2:
            return 3
        case 3:
            return 4
        default:
            return 2
            break
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: TTCollectionViewCell.self, for: indexPath)
        cell.backgroundColor = .random
        cell.addSubview(cell.mainLabel)
        cell.mainLabel.text = "\(indexPath.section) + \(indexPath.row)"
        cell.mainLabel.snp.remakeConstraints { (make) in
            make.center.equalToSuperview()
        }
        return cell
    }
    
//     尺寸
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//
//
//        let row = indexPath.row
//        let width = SCREEN_W > SCREEN_H ? SCREEN_W : SCREEN_H
//        let height = SCREEN_H < SCREEN_W ? SCREEN_H : SCREEN_W
//
//        //  画中画Viewmodel
//        if let _ = items.value[row] as? MeetingPIPCellViewModel {
//
//            return .init(width: width, height: height)
//        }else {
//            return .init(width: width / 2, height: 202)
//        }
//
//        return .init(width: 200, height: 200)
//    }
}

class TestView: View {
    
    override func draw(_ layer: CALayer, in ctx: CGContext) {
        
    }
    
    var title = ""
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
//        print(event?.type.rawValue)
        print(title + "hitTest")
        print(Date().timeIntervalSince1970)
        self.layer.delegate = self
        return super.hitTest(point, with: event)
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
//        print(event?.type.rawValue)
        print(Date().timeIntervalSince1970)
        print(title + "hitPoint")
        return super.point(inside: point, with: event)
    }
    
    override func display(_ layer: CALayer) {
        super.display(layer)
        //
    }
}


class TestButton: UIButton {
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        print(event?.type.rawValue)
        print(titleLabel!.text! + "hitTest")
        return super.hitTest(point, with: event)
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        print(titleLabel!.text! + "hitPoint")
        return super.point(inside: point, with: event)
    }
}

