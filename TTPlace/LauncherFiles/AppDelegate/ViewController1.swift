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
//        // 宽度就是屏幕宽度减去左右边距
//        let width = collectionView!.bounds.size.width - collectionView!.contentInset.left
//            - collectionView!.contentInset.right
//        // 一行三个，一个大的两个小的，
//        let height = CGFloat((collectionView!.numberOfItems(inSection: 0) + 1) / 3)
//            * (width / 3 * 2)
        
        // 获取单元格个数
        let sectionCount = self.collectionView!.numberOfSections
    
        
        
        print("屏幕宽\(SCREEN_W)")
        return CGSize(width: SCREEN_W * CGFloat(sectionCount), height: SCREEN_H)
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
        
        
//        switch indexPath.section {
//        case 0:
//            attribute.frame = CGRect(x:0, y:0, width:SCREEN_W,
//                                     height:SCREEN_H)
//        case 1:
//            attribute.frame = CGRect
//        default:
//            break
//        }
        
        
        
        // 单元格边长
//        let largeCellSide = collectionViewContentSize.width / 3 * 2
        
        let section = indexPath.section
        let row = indexPath.row
        
        
        
        var itemSize: CGSize!
        var itemX: CGFloat = SCREEN_W * CGFloat(section)
        var itemY: CGFloat = 0
        let leftInterVal: CGFloat = 34
        
        let itemCount = self.collectionView!.numberOfItems(inSection: section)
        
        switch section {
        case 0:
            itemSize = CGSize.screenSize
        default:
            switch itemCount {
            case 1:
                itemSize = CGSize.screenSize
            case 2:
                itemSize = CGSize.init(width: 359, height: 202)
                itemX += leftInterVal + CGFloat(row) * itemSize.width
                
            case 3,4:
                itemSize = CGSize.init(width: 327, height: 184)
                itemX = leftInterVal + CGFloat(row) * itemSize.width
                itemY += CGFloat(row % 2) * itemSize.height
            default:
                break
            }
            break
        }
        
        
        print("尺寸是\(itemSize)")
        
        attribute.frame = CGRect.init(x: itemX, y: itemY, width: itemSize.width, height: itemSize.height)
            

//
//        // 当前行数,每行显示3个图片，1大2小
//        let line: Int = indexPath.item / 3
//
//        // 当前y坐标的值
//        let lineOriginY = CGFloat(line) * largeCellSide
//
//        //右侧单元格X坐标，这里按左右对齐，所以中间空隙大
//        // 大单元格在左
//        let rightLargeX = collectionViewContentSize.width - largeCellSide
//        // 大单元格在右
//        let rightSmallX = collectionViewContentSize.width - smallCellSide
        
        
        
//        // 每行2个图片，2行循环一次，一共6种位置
//        if (indexPath.item % 4 == 0) {
//            if indexPath.section == 0 {
//                attribute.frame = CGRect(x:0, y:0, width:SCREEN_W,
//                                                     height:SCREEN_H)
//            }else {
//
//            }
//
//            attribute.frame = CGRect(x:0, y:lineOriginY, width:largeCellSide,
//                                     height:largeCellSide)
//        } else if (indexPath.item % 6 == 1) {
//            attribute.frame = CGRect(x:rightSmallX, y:lineOriginY, width:smallCellSide,
//                                     height:smallCellSide)
//        } else if (indexPath.item % 6 == 2) {
//            attribute.frame = CGRect(x:rightSmallX,
//                                     y:lineOriginY + smallCellSide,
//                                     width:smallCellSide, height:smallCellSide)
//        } else if (indexPath.item % 6 == 3) {
//            attribute.frame = CGRect(x:0, y:lineOriginY, width:smallCellSide,
//                                     height:smallCellSide )
//        } else if (indexPath.item % 6 == 4) {
//            attribute.frame = CGRect(x:0,
//                                     y:lineOriginY + smallCellSide,
//                                     width:smallCellSide, height:smallCellSide)
//        } else if (indexPath.item % 6 == 5) {
//            attribute.frame = CGRect(x:rightLargeX, y:lineOriginY,
//                                     width:largeCellSide,
//                                     height:largeCellSide)
//        }
        
        
        
        
        
        
        
        
        
        
        
       
         
        return attribute
        
    }
    
    
    
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(configureView),
                                               name: Notification.Name("INJECTION_BUNDLE_NOTIFICATION"), object: nil)
        configureView()
    }
    
    

    
    // 问题是，我如何重新拿到之前布局的UI控件，做刷新
    @objc func configureView()  {
        view.removeAllSubviews()
        
        let layout = CustomLayout()
        layout.scrollDirection = .horizontal
        let coreCollectionView = TTCollectionView.init(classTypes: [TTCollectionViewCell.self,TTCollectionViewCell.self], flowLayout: layout)
        coreCollectionView.isPagingEnabled = true
        addSubview(coreCollectionView)
        coreCollectionView.dataSource = self
        coreCollectionView.delegate = self

        coreCollectionView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        coreCollectionView.backgroundColor = .black
//        let view1 = TestView()
//        view1.title = "View1"
//        let view2 = TestView()
//        view2.title = "View2"
//        view1.backgroundColor = .red
//        view2.backgroundColor = .green
//
//
//        addSubviews([view1,view2])
//
//        view1.snp.makeConstraints { (make) in
//            make.center.equalToSuperview()
//            make.size.equalTo(100)
//        }
//
//        view2.snp.makeConstraints { (make) in
//            make.center.equalToSuperview()
//            make.size.equalTo(50)
//        }
        
//        view1.rx.controlEvent(.touchUpInside).subscribe(onNext: {[weak self] (_) in guard let self = self else { return }
//            print("我是view1")
//        }).disposed(by: rx.disposeBag)
   }
}


extension ViewController1: UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout  {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return 2
            break
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withClass: TTCollectionViewCell.self, for: indexPath)
        cell.backgroundColor = .random
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

