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
    var customActivityIndicator: CustomActivityIndicator = CustomActivityIndicator()
    
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
        view.font = UIFont.boldSystemFont(ofSize: 18)
        view.textAlignment = .center
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let lblFullName: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.text = "Full Name"
        view.font = UIFont.boldSystemFont(ofSize: 16)
        view.textAlignment = .left
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let lblName: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.text = "Name"
        view.font = UIFont.boldSystemFont(ofSize: 16)
        view.textAlignment = .left
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let lblEmail: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.text = "Name"
        view.font = UIFont.boldSystemFont(ofSize: 16)
        view.textAlignment = .left
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let lblFollowers: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.text = "Followers"
        view.font = UIFont.boldSystemFont(ofSize: 15)
        view.textAlignment = .left
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let lblFollowings: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.text = "Followings"
        view.font = UIFont.boldSystemFont(ofSize: 15)
        view.textAlignment = .right
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        contView.addSubview(titleLbl)
        contView.addSubview(lblFullName)
        contView.addSubview(lblName)
        contView.addSubview(lblEmail)
        contView.addSubview(lblFollowers)
        contView.addSubview(lblEmail)
        contView.addSubview(lblFollowings)
        view.addSubview(contView)
        
//        titleLbl.backgroundColor = .green
        
        contView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        contView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        contView.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
        
        let padding: CGFloat = 10
        titleLbl.leadingAnchor.constraint(equalTo: contView.leadingAnchor, constant: padding).isActive = true
        titleLbl.trailingAnchor.constraint(equalTo: contView.trailingAnchor, constant: -padding).isActive = true
        titleLbl.topAnchor.constraint(equalTo: contView.topAnchor, constant: 20).isActive = true
    
        lblFullName.leadingAnchor.constraint(equalTo: contView.leadingAnchor, constant: padding).isActive = true
        lblFullName.trailingAnchor.constraint(equalTo: contView.trailingAnchor, constant: -padding).isActive = true
        lblFullName.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 10).isActive = true
        
        lblName.leadingAnchor.constraint(equalTo: contView.leadingAnchor, constant: padding).isActive = true
        lblName.trailingAnchor.constraint(equalTo: contView.trailingAnchor, constant: -padding).isActive = true
        lblName.topAnchor.constraint(equalTo: lblFullName.bottomAnchor, constant: 10).isActive = true
        
        lblEmail.leadingAnchor.constraint(equalTo: contView.leadingAnchor, constant: padding).isActive = true
        lblEmail.trailingAnchor.constraint(equalTo: contView.trailingAnchor, constant: -padding).isActive = true
        lblEmail.topAnchor.constraint(equalTo: lblName.bottomAnchor, constant: 10).isActive = true
        
        lblFollowers.leadingAnchor.constraint(equalTo: contView.leadingAnchor, constant: padding).isActive = true
        lblFollowers.topAnchor.constraint(equalTo: lblEmail.bottomAnchor, constant: 10).isActive = true
        
        lblFollowings.trailingAnchor.constraint(equalTo: contView.trailingAnchor, constant: -padding).isActive = true
        lblFollowings.topAnchor.constraint(equalTo: lblEmail.bottomAnchor, constant: 10).isActive = true
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
        lblFullName.text = fullname
        lblName.text = name
        lblEmail.text = email
        lblFollowers.text = "\(followers)  Followers"
        lblFollowings.text = "\(followings) Followings"
    }
    
    func showToast(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = .black
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15
        
        self.present(alert, animated: false)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 20) {
            alert.dismiss(animated: true)
        }
    }
    
    func startLoading() {
        customActivityIndicator.start(view: (view))
    }
    
    func finishLoading() {
        self.customActivityIndicator.stop()
    }
    
    
    func profileLoadFailed() {
        showToast(message: "Profile loading failed. Please check github token, It may be not valid.")
    }
    
    
}
