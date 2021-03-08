//
//  ApolloNetwork.swift
//  GithubTest
//
//  Created by Thushara Wijekoon on 2021-03-06.
//

import Foundation
import Apollo

class ApolloNetwork {
    
    static private let token = "87e09e02081d3b268f89e42a2c5ff7cd810f28ef"
    
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
