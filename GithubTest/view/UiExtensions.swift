//
//  UiExtensions.swift
//  GithubTest
//
//  Created by Thushara Wijekoon on 2021-03-08.
//

import  UIKit

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
