//
//  Extension.swift
//

import Foundation

extension String {
    static let baseURL = "https://newsapi.org/v2"
    static let apiKey = "9717220280c2444e81a65c7deda9854a"
    static let bitcoinEndpoint = "/everything?q=bitcoin"
    static let wordEndpoint = "/everything?q="
    static let startPeriod =  bitcoinEndpoint+"&from="
    static let endPeriod = "&to="
    static let bitcoinPublishedAtEndpoint = "/everything?q=bitcoin&sortBy=publishedAt"
    static let bitcoinPopularityEndpoint = "/everything?q=bitcoin&sortBy=popularity"
    static let bitcoinRelevancyEndpoint = "/everything?q=bitcoin&sortBy=relevancy"
}
