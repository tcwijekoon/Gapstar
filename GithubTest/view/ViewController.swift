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
//        image.layer.borderWidth = 1
        image.layer.masksToBounds = false
//        image.layer.borderColor = UIColor.black.cgColor
        image.layer.cornerRadius = image.frame.height/2
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
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
    
//    let tableView: UITableView = {
//        let tbl = UITableView()
//        tbl.translatesAutoresizingMaskIntoConstraints = false
//        return tbl
//    }()
    
    var arrPinnedRepos = [PinnedRepo]()
    private var tableView: UITableView!
    var refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contView.addSubview(titleLbl)
        contView.addSubview(profileImage)
        contView.addSubview(lblFullName)
        contView.addSubview(lblName)
        contView.addSubview(lblEmail)
        contView.addSubview(lblFollowers)
        contView.addSubview(lblEmail)
        contView.addSubview(lblFollowings)
        view.addSubview(contView)
        
        profileImage.image = UIImage(named: "avatar")
        profileImage.frame.origin = CGPoint(x: 100, y: 100)
        
        contView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        contView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        contView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        contView.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
        
        let padding: CGFloat = 10
        titleLbl.leadingAnchor.constraint(equalTo: contView.leadingAnchor, constant: padding).isActive = true
        titleLbl.trailingAnchor.constraint(equalTo: contView.trailingAnchor, constant: -padding).isActive = true
        titleLbl.topAnchor.constraint(equalTo: contView.topAnchor, constant: 20).isActive = true

        profileImage.leadingAnchor.constraint(equalTo: contView.leadingAnchor, constant: padding).isActive = true
        profileImage.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 20).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 70).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 70).isActive = true

        lblFullName.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: padding).isActive = true
        lblFullName.trailingAnchor.constraint(equalTo: contView.trailingAnchor, constant: -padding).isActive = true
        lblFullName.topAnchor.constraint(equalTo: titleLbl.bottomAnchor, constant: 10).isActive = true

        lblName.leadingAnchor.constraint(equalTo: profileImage.trailingAnchor, constant: padding).isActive = true
        lblName.trailingAnchor.constraint(equalTo: contView.trailingAnchor, constant: -padding).isActive = true
        lblName.topAnchor.constraint(equalTo: lblFullName.bottomAnchor, constant: 10).isActive = true

        lblEmail.leadingAnchor.constraint(equalTo: contView.leadingAnchor, constant: padding).isActive = true
        lblEmail.trailingAnchor.constraint(equalTo: contView.trailingAnchor, constant: -padding).isActive = true
        lblEmail.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 10).isActive = true

        lblFollowers.leadingAnchor.constraint(equalTo: contView.leadingAnchor, constant: padding).isActive = true
        lblFollowers.topAnchor.constraint(equalTo: lblEmail.bottomAnchor, constant: 10).isActive = true

        lblFollowings.trailingAnchor.constraint(equalTo: contView.trailingAnchor, constant: -padding).isActive = true
        lblFollowings.topAnchor.constraint(equalTo: lblEmail.bottomAnchor, constant: 10).isActive = true
        
        
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
         tableView = UITableView(frame: CGRect(x: lblFollowings.frame.origin.x, y: 200, width: displayWidth, height: displayHeight - 200))
                
         tableView.register(TableCell.self, forCellReuseIdentifier: "cell")
         tableView.dataSource = self
         tableView.delegate = self
         tableView.backgroundColor = .lightGray
        
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: UIControl.Event.valueChanged)
        tableView.addSubview(refreshControl)
        
        contView.addSubview(tableView)
         
        presenter.attachView(view: self)
        presenter.getProfile()
        presenter.getPinnedRepos()
        
    }
    
    @IBAction func refresh(_ sender: Any) {
        presenter.getPinnedRepos()
    }
}

extension ViewController : ProfileView{
    func pinnedReposLoadSuccess(pinnedRepos: [PinnedRepo]) {
        arrPinnedRepos = pinnedRepos
        tableView.reloadData()
    }
    
    func profileLoadSuccess(userInfo : UserInfo) {
        lblFullName.text = userInfo.name
        lblName.text = userInfo.loginName
        lblEmail.text = userInfo.email
        lblFollowers.text = "\(userInfo.noFollowers!)  Followers"
        lblFollowings.text = "\(userInfo.noFollowings!) Followings"
        let fileUrl = URL(string: userInfo.avatar!)
        profileImage.load(url:fileUrl! )
    }
    
    func showToast(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = .black
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15
        
        self.present(alert, animated: false)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 5) {
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

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           print("Num: \(indexPath.row)")
           print("Value: \(arrPinnedRepos[indexPath.row])")
       }

       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return arrPinnedRepos.count
       }

       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! TableCell
        cell.lblusername.text = "\(arrPinnedRepos[indexPath.row].name!)"
        cell.lblTitle.text = "\(arrPinnedRepos[indexPath.row].nameWithOwner!)"
        cell.lblDesc.text = "\(arrPinnedRepos[indexPath.row].repoDescription!)"
        cell.lblProLang.text = "\(arrPinnedRepos[indexPath.row].primaryLanguage!)"
//        cell.lblusername.text = "\(arrPinnedRepos[indexPath.row].name!)"
           return cell
       }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170
    }
}
