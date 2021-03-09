//
//  ApolloNetwork.swift
//  GithubTest
//
//  Created by Thushara Wijekoon on 2021-03-06.
//

import Foundation
import Apollo

class ApolloNetwork {
    
    static private let token = "3be6e2e03c5bf94f75b255e98f9d91eb3b583efe"
    
    static var apollo: ApolloClient = {
        let network = RequestChainNetworkTransport(
            interceptorProvider: LegacyInterceptorProvider(),
            endpointURL: URL(string: "https://api.github.com/graphql")!,
            additionalHeaders: [
                "Authorization": "Bearer \(token)"
            ]
        )
        return .init(networkTransport: network)
    }()
    
}
