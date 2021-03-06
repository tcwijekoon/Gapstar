//
//  ViewController.swift
//  GithubTest
//
//  Created by Thushara Wijekoon on 2021-03-06.
//

import Foundation
import UIKit

class ViewController: UIViewController {

    let presenter = ProfilePresenter()
    
    private let contView :UIView = {
      let view = UIView()
      view.backgroundColor = .white
    view.translatesAutoresizingMaskIntoConstraints = false
      return view
    }()
    
    let profileImage: UIImageView = {
        let image = UIImageView()
        image.layer.borderWidth = 1
        image.layer.masksToBounds = false
        image.layer.borderColor = UIColor.black.cgColor
        image.layer.cornerRadius = image.frame.height/2
        image.clipsToBounds = true
        return image
    }()
    
    let titleLbl: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.text = "Profile"
        view.font = UIFont.boldSystemFont(ofSize: 19)
        view.textAlignment = .center
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let lblName: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.font = UIFont.boldSystemFont(ofSize: 17)
        view.textAlignment = .left
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        contView.addSubview(titleLbl)
        contView.addSubview(lblName)
        contView.addSubview(profileImage)
        view.addSubview(contView)
        
        contView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        contView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        contView.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
        
        let padding: CGFloat = 10
        NSLayoutConstraint.activate([
            titleLbl.leadingAnchor.constraint(equalTo: contView.leadingAnchor, constant: padding),
            titleLbl.trailingAnchor.constraint(equalTo: contView.trailingAnchor, constant: -padding),
            titleLbl.topAnchor.constraint(equalTo: contView.topAnchor, constant: 20),
        ])
        
        NSLayoutConstraint.activate([
            lblName.leadingAnchor.constraint(equalTo: contView.leadingAnchor, constant: padding),
            lblName.trailingAnchor.constraint(equalTo: contView.trailingAnchor, constant: -padding),
            lblName.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 20),
        ])
        
//        profileImage.leadingAnchor.constraint(equalTo: contView.leadingAnchor, constant: padding).isActive = true
//        profileImage.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 20).isActive = true
//        profileImage.heightAnchor.constraint(equalToConstant: 30).isActive = true
//        profileImage.widthAnchor.constraint(equalToConstant: 30).isActive = true
        presenter.attachView(view: self)
        presenter.getProfile()
        
    }
}


extension ViewController : ProfileView{
    func profileLoadSuccess(fullname: String, name: String, email: String, followers: Int, followings: Int, avatarUrl: String) {
        titleLbl.text = fullname
    }
    
    func showToast(message: String, duration: Double) {
        
    }
    
    func startLoading() {
        
    }
    
    func finishLoading() {
        
    }
    
    
    func profileLoadFailed() {
        
    }
    
    
}
