//
//  TTDataExtension.swift
//  TTPlace
//
//  Created by Mr.hong on 2021/2/19.
//  Copyright © 2021 Mr.hong. All rights reserved.
//

import Foundation

extension Data {
    // data转Dic
    func toDictionary() -> [String : Any] {
        do {
            let jsonData = try JSON.init(data: self)
            if let dataDic = jsonData.dictionaryObject {
                return dataDic
            }
        } catch {}
        return [String : Any]()
    }
    
    
    func toOptionalDictionary() -> [String : Any]? {
        do {
            let jsonData = try JSON.init(data: self)
            if let dataDic = jsonData.dictionaryObject {
                return dataDic
            }
        } catch {
          
        }
        return nil
    }
    
    func toModel<T: HandyJSON>(_ name: T.Type) -> T? {
        // 将data直接转为
        return T.deserialize(from: self.toDictionary())
    }
    
//    func toModels<T: HandyJSON>(_ name: T.Type) -> T? {
//        // 将data直接转为
//        return T.models(<#T##data: [[String : Any]]##[[String : Any]]#>)
//    }
}
