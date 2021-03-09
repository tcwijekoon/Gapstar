//
//  ProfilePresenter.swift
//  GithubTest
//
//  Created by Thushara Wijekoon on 2021-03-06.
//

import UIKit

protocol ProfileView: NSObjectProtocol {
    func showToast(message: String)
    func startLoading()
    func finishLoading()
    func profileLoadSuccess(userInfo : UserInfo)
    func pinnedReposLoadSuccess(pinnedRepos : [PinnedRepo])
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
    
    func getProfile() {
        profileView?.startLoading()
        ApolloNetwork.apollo.fetch(query: UserInfoQuery(), cachePolicy: .fetchIgnoringCacheData) { result in
            switch result {
            case .success(let result):
                self.profileView?.finishLoading()
                let viewer = result.data?.viewer
//                self.profileView?.showToast(message: viewer!.name!, duration: 20.0)
                let obj = UserInfo()
                obj.name = viewer!.name!
                obj.loginName = viewer!.login
                obj.email = viewer!.email
                obj.noFollowings = viewer!.following.totalCount
                obj.noFollowers = viewer!.followers.totalCount
                obj.avatar = viewer!.avatarUrl
                self.profileView?.profileLoadSuccess(userInfo: obj)
            case .failure(let error):
                print("Error: \(error)")
                self.profileView?.finishLoading()
                self.profileView?.profileLoadFailed()
            }
        }
    }
    
    func getPinnedRepos() {
        profileView?.startLoading()
        ApolloNetwork.apollo.fetch(query: PinnedReposQuery(), cachePolicy: .fetchIgnoringCacheData) { result in
            switch result {
            case .success(let result):
                self.profileView?.finishLoading()
                var repos = [PinnedRepo]()
                result.data?.user?.pinnedItems.edges?.forEach { edge in
                    guard let repository = edge?.node?.asRepository else { return }
                    let rep = PinnedRepo()
                    rep.name = repository.name
                    rep.stargazerCount = repository.stargazerCount
                    rep.nameWithOwner = repository.nameWithOwner
                    rep.primaryLanguage = repository.primaryLanguage?.name
                    rep.repoDescription = repository.description
                    repos.append(rep)
                }
                self.profileView?.pinnedReposLoadSuccess(pinnedRepos: repos)
            case .failure(let error):
                print("Error: \(error)")
                self.profileView?.finishLoading()
                self.profileView?.profileLoadFailed()
            }
        }
    }
}
