//
//  ResizeImage.swift
//  Podcast Radio
//
//  Created by Manish Kumar on 2018-01-25.
//  Copyright © 2018 Manish Kumar. All rights reserved.
//

import UIKit

extension UIImage {
    func resizeImage(size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, true, self.scale)
        self.draw(in: CGRect(origin: .zero, size: size))
        let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return resizedImage
    }
}
