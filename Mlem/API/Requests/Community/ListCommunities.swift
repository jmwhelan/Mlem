//
//  ListCommunities.swift
//  Mlem
//
//  Created by Jonathan de Jong on 12.06.2023.
//

import Foundation

// lemmy_api_common::community::ListCommunities
struct ListCommunitiesRequest: APIGetRequest {

    typealias Response = ListCommunityResponse

    let instanceURL: URL
    let path = "community/list"
    let queryItems: [URLQueryItem]

    init(
        account: SavedAccount,

        sort: PostSortType?,
        page: Int?,
        limit: Int?,

        type: FeedType = .all
    ) {
        self.instanceURL = account.instanceLink
        self.queryItems = [
            .init(name: "sort", value: sort?.rawValue),
            .init(name: "limit", value: limit?.description),
            .init(name: "page", value: page?.description),
            .init(name: "type_", value: type.rawValue),

            .init(name: "auth", value: account.accessToken),
        ]
    }

    init(
        instanceURL: URL,

        sort: PostSortType?,
        page: Int?,
        limit: Int?,

        type: FeedType = .all
    ) {
        self.instanceURL = instanceURL

        self.queryItems = [
            .init(name: "sort", value: sort?.rawValue),

            .init(name: "limit", value: limit.map(String.init)),
            .init(name: "page", value: page.map(String.init)),
            .init(name: "type_", value: type.rawValue),
        ]
    }
}

// lemmy_api_common::community::ListCommunitiesResponse
struct ListCommunityResponse: Decodable {
    var communities: [APICommunityView]
}
