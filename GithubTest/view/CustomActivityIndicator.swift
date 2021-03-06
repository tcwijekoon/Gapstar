//
//  CustomActivityIndicator.swift
//  GithubTest
//
//  Created by Thushara Wijekoon on 2021-03-07.
//

import UIKit

class CustomActivityIndicator: NSObject {
    
    var activityIndicator : UIActivityIndicatorView!
    let loadingView: UIView!
    var screenSize: CGRect!
    static var count : Int = 0
    
    override init() {
        activityIndicator = UIActivityIndicatorView()
        loadingView = UIView()
        screenSize = UIScreen.main.bounds
    }
    
    func start(view: UIView) {
        if CustomActivityIndicator.count == 0 {
            loadingView.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
            loadingView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            loadingView.clipsToBounds = true
            
            activityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
            activityIndicator.isHidden = false
            activityIndicator.hidesWhenStopped = true
            activityIndicator.style = UIActivityIndicatorView.Style.whiteLarge
            activityIndicator.center = CGPoint(x:loadingView.frame.size.width / 2,y:loadingView.frame.size.height / 2);
            
            loadingView.addSubview(activityIndicator)
            view.addSubview(loadingView)
            activityIndicator.startAnimating()
            loadingView.isHidden = false
            
            print("startee" ,CustomActivityIndicator.count)
        }
        UIApplication.shared.beginIgnoringInteractionEvents()
        CustomActivityIndicator.count += 1
    }
    
    func stop() {
        CustomActivityIndicator.count -= 1
        if CustomActivityIndicator.count < 0 {
            CustomActivityIndicator.count = 0
        }
        
        print("stop", CustomActivityIndicator.count)
        if CustomActivityIndicator.count <= 0 && activityIndicator.isAnimating {
            activityIndicator.stopAnimating()
            loadingView.isHidden = true
            activityIndicator.hidesWhenStopped = true
        }
        UIApplication.shared.endIgnoringInteractionEvents()
    }
    
}
