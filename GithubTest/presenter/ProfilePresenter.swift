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
                var obj = UserInfo()
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
    
    func getPinnedRepos(getSavedData : Bool) {
        if !Calendar.current.isDate(Date(), equalTo: getSyncDateTime(), toGranularity: .day) ||  !getSavedData {
            profileView?.startLoading()
            ApolloNetwork.apollo.fetch(query: PinnedReposQuery(), cachePolicy: .fetchIgnoringCacheData) { result in
                switch result {
                case .success(let result):
                    self.profileView?.finishLoading()
                    self.saveSyncDateTime()
                    var repos = [PinnedRepo]()
                    result.data?.user?.pinnedItems.edges?.forEach { edge in
                        guard let repository = edge?.node?.asRepository else { return }
                        var rep = PinnedRepo()
                        rep.name = repository.name
                        rep.stargazerCount = repository.stargazerCount
                        rep.nameWithOwner = repository.nameWithOwner
                        rep.primaryLanguage = repository.primaryLanguage?.name
                        rep.repoDescription = repository.description
                        repos.append(rep)
                    }
                    var sr = SavedPinnedRepos()
                    sr.repos = repos
                    self.savePinnedRepos(obj: sr)
                    self.profileView?.pinnedReposLoadSuccess(pinnedRepos: repos)
                case .failure(let error):
                    print("Error: \(error)")
                    self.profileView?.finishLoading()
                    self.profileView?.profileLoadFailed()
                }
            }
        }else{
            let sd = getSavedPinnedRepos()
            self.profileView?.pinnedReposLoadSuccess(pinnedRepos: sd.repos)
        }
    }
    
    //save data for cache
    func savePinnedRepos(obj : SavedPinnedRepos){
        do{
            let jsonEncoder = JSONEncoder()
            let jsonData = try jsonEncoder.encode(obj)
            let json = String(data: jsonData, encoding: String.Encoding.utf8)
            UserDefaults.standard.set(json, forKey: "PinnedRepos")
            UserDefaults.standard.synchronize()
        }catch{
            fatalError("Unable To Convert in Json")
        }
    }
    
    func getSavedPinnedRepos() -> SavedPinnedRepos {
        do{
            let value = UserDefaults.standard.object(forKey: "PinnedRepos")
            if value != nil {
                let jsonDecoder = JSONDecoder()
                let str = value as! String
                let data = Data(str.utf8)
                let obj = try jsonDecoder.decode(SavedPinnedRepos.self, from:data )
                return obj
            } else {
                return SavedPinnedRepos()
            }
        }catch{
            return SavedPinnedRepos()
        }
    }
    
    func saveSyncDateTime(){
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = df.string(from: date)
        UserDefaults.standard.set(dateString, forKey: "SyncDateTime")
        UserDefaults.standard.synchronize()
    }
    
    func getSyncDateTime() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let value = UserDefaults.standard.object(forKey: "SyncDateTime")
        if value != nil {
            let last_date = dateFormatter.date(from: value as! String)
            return last_date!
        } else {
            return Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        }
    }
}


