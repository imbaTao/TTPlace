//
//  121232.swift
//  Yuhun
//
//  Created by Mr.hong on 2021/1/22.
//

import Foundation

// MARK: - 封装结果直接转模型
/// 路径分割符
fileprivate let pathSplitSymbol: Character = ">"
extension PrimitiveSequence where Trait == SingleTrait, Element == TTNetModel {
    
    internal func mapModel<T: HandyJSON>(_ type: T.Type, modelKey: String? = nil) -> Single<(T)> {
        return flatMap { (netModel) -> Single<T> in
            
            // 如果传入了key,就从data层往下开始解析
            if let modelKey = modelKey {
                let keyArray = modelKey.split(separator: pathSplitSymbol)
                var lastDic = [String : Any]()
                
                // 遍历到底层
                for item in keyArray {
                    
                    while let dic = netModel.data[String(item)] {
                        lastDic = dic as! [String : Any]
                        
                        // 能解析出来就跳出循环
                        break
                    }
                }

                // 如果转模型成功
                if let model = type.model(lastDic) {
                    return Single.just(model)
                }
            }else {
                // 如果转模型成功
                if let model = type.model(netModel.data) {
                    return Single.just(model)
                }
            }
            return Single.just(T())
        }
    }
    
    
    internal func mapModels<T: HandyJSON>(_ type: T.Type, modelKey: String) -> Single<[T]> {
        return flatMap { (netModel) -> Single<[T]> in
            
            // 如果传入了key,就从data层往下开始解析
//            if let modelKey = modelKey {
                let keyArray = modelKey.split(separator: pathSplitSymbol)
                var lastDic = [Any]()
                
                // 遍历到底层
                for item in keyArray {
                    
                    while let dic = netModel.data[String(item)] {
                        lastDic = dic as! [Any]
                        
                        // 能解析出来就跳出循环,不能解析就是json字典结构有问题，检查key
                        break
                    }
                }
                
                
                if let lastDic = lastDic as? [[String : Any]] {
                    
                    // 如果转模型成功
                    if let models = type.models(lastDic) {
                        return Single.just(models)
                    }
                }
            
                // 否则返回一个空数组
                return Single.just([])
            }
        }
}
