//
//  TableCell.swift
//  GithubTest
//
//  Created by Thushara Wijekoon on 2021-03-08.
//

import UIKit

class TableCell: UITableViewCell {

    let profileImage: UIImageView = {
        let image = UIImageView()
//        image.layer.borderWidth = 1
        image.layer.masksToBounds = false
//        image.layer.borderColor = UIColor.black.cgColor
        image.layer.cornerRadius = image.frame.height/2
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let lblusername: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.text = "username"
        view.font = UIFont.boldSystemFont(ofSize: 18)
        view.textAlignment = .center
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let lblTitle: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.text = "Title"
        view.font = UIFont.boldSystemFont(ofSize: 16)
        view.textAlignment = .left
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let lblDesc: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.text = "Description"
        view.font = UIFont.boldSystemFont(ofSize: 16)
        view.textAlignment = .left
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let lblProLang: UILabel = {
        let view = UILabel()
        view.textColor = .black
        view.text = "Language"
        view.font = UIFont.boldSystemFont(ofSize: 16)
        view.textAlignment = .left
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(profileImage)
        contentView.addSubview(lblusername)
        contentView.addSubview(lblTitle)
        contentView.addSubview(lblDesc)
        contentView.addSubview(lblProLang)
        
        let padding: CGFloat = 10
        
        profileImage.image = UIImage(named: "avatar")
        profileImage.frame.origin = CGPoint(x: 100, y: 100)

        profileImage.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding).isActive = true
        profileImage.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 50).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 50).isActive = true

        lblusername.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: padding).isActive = true
        lblusername.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding).isActive = true
        lblusername.topAnchor.constraint(equalTo: profileImage.topAnchor, constant: 10).isActive = true

        lblTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding).isActive = true
        lblTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding).isActive = true
        lblTitle.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 10).isActive = true
        
        lblDesc.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding).isActive = true
        lblDesc.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding).isActive = true
        lblDesc.topAnchor.constraint(equalTo: lblTitle.bottomAnchor, constant: 10).isActive = true
        
        lblProLang.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: padding).isActive = true
        lblProLang.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding).isActive = true
        lblProLang.topAnchor.constraint(equalTo: lblDesc.bottomAnchor, constant: 10).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
