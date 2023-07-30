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
            }
        }
    }
    
    func checksForPeriod(searchText: String) {
        if searchText.contains(":") {
            let components = searchText.components(separatedBy: ":")
            let start = components[0].trimmingCharacters(in: .whitespaces)
            let end = components[1].trimmingCharacters(in: .whitespaces)
            if isValidDate(dateString: start) && isValidDate(dateString: end) {
                request(endpoint: "\(.startPeriod+start)\(.endPeriod+end)")
            } else {
                showAlert("Invalid date format. Please use YYYY-MM-dd format for start and end dates.")
            }
        } else {
            if isValidDate(dateString: searchText) {
                request(endpoint: .startPeriod+searchText)
            } else {
                showAlert("Invalid date format. Please use YYYY-MM-dd format for start and end dates.")
            }
        }
    }
    
    private func showAlert(_ message: String) {
        DispatchQueue.main.async {
            self.error = message
            self.showAlert = true
            self.isLoading = false
        }
    }
    
    private func isValidDate(dateString: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        return dateFormatter.date(from: dateString) != nil
    }
}
