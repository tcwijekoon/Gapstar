//
//  ProfilePresenter.swift
//  GithubTest
//
//  Created by Thushara Wijekoon on 2021-03-06.
//

import UIKit

protocol ProfileView: NSObjectProtocol {
    func showToast(message: String, duration: Double)
    func startLoading()
    func finishLoading()
    func profileLoadSuccess(fullname : String, name : String, email : String, followers :Int, followings :Int)
    func profileLoadFailed()
}

class ProfilePresenter {
    weak private var profileView: ProfileView?
    
    func attachView(view: ProfileView) {
        profileView = view
    }
    
    func detachView() {
        profileView = nil
    }
    
    func getPeople() {
        profileView?.startLoading()
        ApolloNetwork.apollo.fetch(query: UserInfoQuery(), cachePolicy: .fetchIgnoringCacheData) { result in
            switch result {
            case .success(let result):
                self.profileView?.finishLoading()
                let viewer = result.data?.viewer
//                self.profileView?.showToast(message: viewer!.name!, duration: 20.0)
                self.profileView?.profileLoadSuccess(fullname: viewer!.name!, name: viewer!.login, email: viewer!.email, followers: viewer!.followers.totalCount, followings: viewer!.following.totalCount)
            case .failure(let error):
                print("Error: \(error)")
                self.profileView?.finishLoading()
                self.profileView?.profileLoadFailed()
            }
        }
    }
}
