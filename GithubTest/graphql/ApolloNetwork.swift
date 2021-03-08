//
//  ApolloNetwork.swift
//  GithubTest
//
//  Created by Thushara Wijekoon on 2021-03-06.
//

import Foundation
import Apollo

class ApolloNetwork {
    
    static private let token = "a84c888134b0623b1ecde49007d2d4a9e9318242"
    
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
