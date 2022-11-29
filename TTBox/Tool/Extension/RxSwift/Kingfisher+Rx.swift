//
//  Kingfisher+Rx.swift
//  SwiftHub
//
//  Created by Khoren Markosyan on 6/30/18.
//  Copyright © 2018 Khoren Markosyan. All rights reserved.
//

import Kingfisher
import RxCocoa
import RxSwift
import UIKit

//MARK: - 对UIImageView扩展，直接binder ImageUrl
extension Reactive where Base: UIImageView {

    public var imageURL: Binder<URL?> {
        return self.imageURL(withPlaceholder: nil)
    }

    public func imageURL(
        withPlaceholder placeholderImage: UIImage?, options: KingfisherOptionsInfo? = []
    ) -> Binder<URL?> {
        return Binder(
            self.base,
            binding: { (imageView, url) in
                imageView.kf.setImage(
                    with: url,
                    placeholder: placeholderImage,
                    options: options,
                    progressBlock: nil,
                    completionHandler: { (result) in })
            })
    }
}

extension ImageCache: ReactiveCompatible {}
