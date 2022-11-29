//
//  ModelExtension.swift
//  TTPlace
//
//  Created by Mr.hong on 2021/1/22.
//  Copyright © 2021 Mr.hong. All rights reserved.
//

import Foundation
import HandyJSON

extension HandyJSON {
    static func model(_ data: [String: Any]) -> Self? {
        return Self.deserialize(from: data)
    }

    static func model(_ string: String) -> Self? {
        return Self.deserialize(from: string)
    }

    static func models(_ data: [[String: Any]]) -> [Self]? {
        return [Self].deserialize(from: data) as? [Self]
    }
}
