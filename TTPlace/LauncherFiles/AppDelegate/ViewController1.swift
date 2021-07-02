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

class ViewController: TTViewController {
    
}

class TTButton1: UIButton {
    
}

protocol TTAlertProtocal {
    associatedtype T
}





struct RenderingNode {
    var firstIndex = 0
    var length = 0
    
    
    // ----------------- 颜色 -----------------
    var color = ""
    var colorAlpha = 1.0
    var backgroundColor = ""
    var backgroundAlpha = 1.0
    
    
    // ----------------- 字体 -----------------
    // 尺寸
    var fontSize: CGFloat = 12
    
    // 字重
    var fontWeight = "regular" // medium // bold
    
    // 字体
    var fontFamily = "PingFangTC-Regular"
}

class AirtcleOption: NSObject {
    // 内容
    var content = ""
    var colors = [ColorNode]()
    var fonts = [FontNode]()
    var hightLight = [HightLightNode]()
    var images = [ImageNode]()
    
    // 跑马灯速度
    var speed = 0
    
    var hightLightClickEvent = PublishSubject<Int>()
    
    // 返回富文本
//    func fetchRichText() -> NSMutableAttributedString {
//        // 生成原文本的富文本
//        var richText = NSMutableAttributedString.init(string: content)
//
//        // 先执行渲染类的操作
//        // 渲染颜色
//        for node in colors {
//            richText.setColor(UIColor.init(hexString: node.color), range: .init(location: node.firstIndex, length: node.length))
//        }
//
//        // 渲染字体
//        for node in fonts {
//            richText.setFont(UIFont.init(name: node.family, size: node.size), range: .init(location: node.firstIndex, length: node.length))
//        }
//
//        // 渲染高亮
//        for node in fonts {
//            richText.setFont(UIFont.init(name: node.family, size: node.size), range: .init(location: node.firstIndex, length: node.length))
//        }
//
//        // 渲染高亮，只处理事件，不处理颜色等
//        for node in hightLight {
//            richText.setTextHighlight(.init(location: node.firstIndex, length: node.length), color: nil, backgroundColor: nil, userInfo: nil) { (view, attString, range, rect) in
//                // 处理每处的点击事件,传出去
//                self.hightLightClickEvent.onNext(1)
//            }
//        }
//
//
//        // 插入图片node就步进+1，计算偏移量
//        var nodeOffset = 0
//        for node in images {
//            // 下载并设置图片
//            let image = UIImage.init()
//            if #available(iOS 13.0, *) {
//                let attachment = NSTextAttachment.init(image: image)
//            } else {
//                // Fallback on earlier versions
//            }
////            attachment.bounds = .init(x: 0, y: 0, width: node.size.width, height: node.size.height)
////            richText.setAttachment(attachment, range: .init(location: nodeOffset + node.index, length: 1))
////            nodeOffset += 1
//        }
//    }
}



//"我/(图)今天干\(sdff)嘛"
//"m我今m天/干/嘛"
//"我m今天m干嘛"
///U378 = 1bit

struct ColorNode {
    var firstIndex = 0
    var length = 0
    var color = ""
    var colorAlpha = 1.0
    var backgroundColor = ""
    var backgroundAlpha = 1.0
}

struct FontNode {
 
}


struct HightLightNode {
    var firstIndex = 0
    var length = 0
    var hightLightUrl = ""
}

struct ImageNode {
    var index = 0
    var imageUrl = ""
    var clickUrl = ""
    var size: CGSize = .zero
}




class ViewController1: ViewController,UITextFieldDelegate {
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(configureView),
                                               name: Notification.Name("INJECTION_BUNDLE_NOTIFICATION"), object: nil)
        configureView()
    }
    
    

    
    // 问题是，我如何重新拿到之前布局的UI控件，做刷新
    @objc func configureView()  {
//        view.removeAllSubviews()
//        view.backgroundColor = .gray
        
        
//        let button = UIButton.init()
//        button.backgroundColor = .red
//        button.setImage(UIImage.name("test"), for: .normal)
//        button.cornerRadius = 8
//        addSubview(button)
//        button.snp.makeConstraints { (make) in
//            make.size.equalTo(100)
//            make.center.equalToSuperview()
//        }
//
//        button.rx.controlEvent(.touchUpInside).subscribe(onNext: {[weak self] (_) in guard let self = self else { return }
////            print("111")
//
////       self.shakeAnimate(view: button, fromY: 0, toY: 0)
//
//            self.marqueeView.addNormalContent(contents: ["123","skjdlkajdslkfj","0982308410283409"])
//        }).disposed(by: rx.disposeBag)
   }
    
    let marqueeView = TTMarqueeView()
    override func makeUI() {
        super.makeUI()
        marqueeView.backgroundColor = rgba(143, 64, 246, 0.8)
        
        addSubviews([marqueeView])
        marqueeView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview()
            make.top.equalTo(200)
            make.height.equalTo(30)
        }
        
        
        
//        let htmlString = "<p>「中国正能量2021」“五个一百”再出发，他们喊你来参加！</p ><p>< img src=\"https://img2.baidu.com/it/u=3566088443,3713209594&fm=26&fmt=auto&gp=0.jpg\" width=\"300\" ></p ><p>央视网消息：中央网信办主办的中国正能量2021“五个一百”网络精品征集评选展播活动正式启动，通过展播百名网络正能量榜样、百篇网络正能量文字、百幅网络正能量图片、百部网络正能量动漫音视频作品和百项网络正能量专题活动，共同传播可爱中国、青春中国、可亲中国、魅力中国、奋进中国。评选结果将于今年年底对外发布。</p><p><img src=\"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fcdn.duitang.com%2Fuploads%2Fblog%2F201306%2F25%2F20130625150506_fiJ2r.jpeg&refer=http%3A%2F%2Fcdn.duitang.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1627464504&t=8f71837979024adb9be6123375918742\" width=\"300\" ></p>"
        let htmlString = "<TEXTFORMAT LEADING=\"2\"><P ALIGN=\"LEFT\"><FONT FACE=\"Microsoft Yahei,微软雅黑\" SIZE=\"24\" COLOR=\"#333333\" LETTERSPACING=\"0\" KERNING=\"0\">我可以设置一个超链接,牛逼吗 <FONT COLOR=\"#0000ff\"><A HREF=\"我是超链接\" TARGET=\"_blank\"><FONT COLOR=\"#6698ff\"><U>快戳我看看</U></FONT></A></FONT></FONT></P></TEXTFORMAT>"
        
        
        
//           "😁"
//        rangeOfComposedCharacterSequenceAtIndex
        
        let str = "rangeOfComposedCharacte😁rSequenceAtIndex"
        let emoji = "😁"
        let range = str.rangeOfComposedCharacterSequence(at:emoji.startIndex)
        
        print("打印内容是\(str[range])")
//        Range<String,Int>
        
        let tempView1 = UILabel.regular(size: 12, textColor: .black, text: "U+1F409", alignment: .center)
        self.view.addSubview(tempView1)
        tempView1.snp.makeConstraints { (make) in
//                make.center.equalToSuperview()
            make.left.right.equalToSuperview()
            make.top.equalTo(200)
        }
        tempView1.numberOfLines = 0
        
        
        
        var sourceText = "123456"
        let option = AirtcleOption()
//        let colorsOption = [
//            ColorNode.init(firstIndex: 0, length: 2, color: "#CC00FF"),
//            ColorNode.init(firstIndex: 2, length: 1, color: "#DC143C")
//        ]
        
//        let fontOption = [
//            FontNode.init(firstIndex: 0, length: 2, size: 12)
//        ]
//
//
//        let hightLightOption = [
//            HightLightNode.init(firstIndex: 0, length: 2, hightLightUrl: "http//:www.baidu.com")
//        ]
//
//        let images = [
//            ImageNode.init(index: 0, imageUrl: "https://gimg2.baidu.com/image_search/src=http%3A%2F%2F2c.zol-img.com.cn%2Fproduct%2F124_500x2000%2F748%2FceZOdKgDAFsq2.jpg&refer=http%3A%2F%2F2c.zol-img.com.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1627524204&t=8ac09bc417b7f96c0d12f09bf4a20e36", clickUrl: "http//:www.baidu.com", size: .init(width: 30, height: 30)),
//            ImageNode.init(index: 1, imageUrl: "https://gimg2.baidu.com/image_search/src=http%3A%2F%2F2c.zol-img.com.cn%2Fproduct%2F124_500x2000%2F748%2FceZOdKgDAFsq2.jpg&refer=http%3A%2F%2F2c.zol-img.com.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1627524204&t=8ac09bc417b7f96c0d12f09bf4a20e36", clickUrl: "http//:www.baidu.com", size: .init(width: 30, height: 30)),
//            ImageNode.init(index: 2, imageUrl: "https://gimg2.baidu.com/image_search/src=http%3A%2F%2F2c.zol-img.com.cn%2Fproduct%2F124_500x2000%2F748%2FceZOdKgDAFsq2.jpg&refer=http%3A%2F%2F2c.zol-img.com.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1627524204&t=8ac09bc417b7f96c0d12f09bf4a20e36", clickUrl: "http//:www.baidu.com", size: .init(width: 30, height: 30))
//        ]
        
//        var hightLight = [HightLightNode]()
//        var images = [ImageNode]()
//        tempView1.text = attributedString
        
        
        
    
//        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding] options:@{NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType} documentAttributes:nil error:&error];
        
    }
}



 // 富文本转String
 func attriToStr(withAttri attri: NSAttributedString?) -> String? {
    let tempDic = [
        .documentType: NSAttributedString.DocumentType.html,
        NSAttributedString.DocumentAttributeKey.characterEncoding: NSNumber(value: String.Encoding.utf8.rawValue)
    ] as [NSAttributedString.DocumentAttributeKey : Any]
    
    var htmlData: Data? = nil
    do {
        htmlData = try attri?.data(
            from: NSRange(location: 0, length: attri?.length ?? 0),
            documentAttributes: tempDic)
    } catch {
    }
    
    if let htmlData = htmlData {
        return String(
            data: htmlData,
            encoding: .utf8)
    }
    return nil
 }

// str
func strToAttri(withAttri htmlString: String) -> NSAttributedString? {
    var attributedString: NSMutableAttributedString? = nil
    do {
        if let data = htmlString.data(using: .unicode) {
            attributedString = try NSMutableAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
            return attributedString
        }
    } catch {
    }
    
    return nil
}





//private func get3DTransformation(angle: Double) -> CATransform3D {
//
//var transform = CATransform3DIdentity
//transform.m34 = -1.0 / 500.0
//transform = CATransform3DRotate(transform, CGFloat(angle * Double.pi / 180.0), 0, 1, 0.0)
//
//return transform
//}
//
//private func flipAnimation(view: UIView, completion: @escaping (() -> Void) = {}) {
//
//let angle = 180.0
//view.layer.transform = get3DTransformation(angle: angle)
//
////            .TransitionNone
//UIView.animate(withDuration: 2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: .transitionCrossDissolve, animations: { () -> Void in
//    view.layer.transform = CATransform3DIdentity
//    }) { (finished) -> Void in
//        completion()
//}
//}
extension UIView {
    var inset: CGFloat {
        return 12
    }
    
}

extension UIColor {
    // 性别颜色， 男1，女2
    class func genderColor(_ gender: Int = 1) -> UIColor {
        if gender == 1 {
            return rgba(124, 200, 255, 1)
        }else {
            return rgba(255, 127, 182, 1)
        }
    }
    
    // 主要文本颜色
    static var mainStyleColor: UIColor {
        return #colorLiteral(red: 0.5607843137, green: 0.2509803922, blue: 0.9647058824, alpha: 1)
    }
    
    // 主要文本颜色
    static var mainTextColor: UIColor {
        return rgba(51, 51, 51, 1)
    }
    
    // 主要文本颜色2
    static var mainTextColor2: UIColor {
        return rgba(102, 102, 102, 1)
    }
    
    
}
