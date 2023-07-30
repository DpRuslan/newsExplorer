//
//  MainViewModel.swift
//

import Foundation

class MainViewModel: ObservableObject {
    @Published var items: [ArticleWrapper] = []
    @Published var showAlert = false
    @Published var error: String?
    @Published var isLoading: Bool = false
    
    func request(endpoint: String) {
        isLoading = true
        let apiManager = APIManager(baseURL: .baseURL, apiKey: .apiKey)
        apiManager.request(endpoint: endpoint, method: .GET) { [weak self] result in
            switch result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let response = try decoder.decode(Response.self, from: data)
                    DispatchQueue.main.async { // Update the view on the main thread
                        self?.items = response.articles.map { ArticleWrapper(article: $0) }
                        self?.isLoading = false
                        print("fetched")
                        print("Number of items: \(self?.items.count ?? 0)")
                    }
                     
                } catch {
                    print(CustomError.decodingError.localizedDescription)
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.error = error.localizedDescription
                    self?.showAlert = true
                    self?.isLoading = false
                }
               
                print(error.localizedDescription)
            }
        }
    }
}
