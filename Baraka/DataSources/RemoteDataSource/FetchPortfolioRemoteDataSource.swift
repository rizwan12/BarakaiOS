//
//  FetchRepositoryRemoteDataSource.swift
//  Baraka
//
//  Created by Rizwan Saleem on 03/08/2025.
//
import RxSwift

protocol FetchPortfolioRemoteDataSource {
    func fetchRepositories() -> Observable<PortfolioModel>
}

class FetchPortfolioRemoteDataSourceImpl: FetchPortfolioRemoteDataSource {
    
    func fetchRepositories() -> Observable<PortfolioModel> {
        return Observable.create { observer in
            guard let url = URL(string: "https://dummyjson.com/c/60b7-70a6-4ee3-bae8") else {
                observer.onError(NetworkError.invalidURL)
                return Disposables.create()
            }
            
            let fetchPortfolioTask = URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    observer.onError(error)
                    return
                }
                
                guard let data = data else {
                    observer.onError(NetworkError.noData)
                    return
                }
                
                do {
                    let portfolioResponse = try JSONDecoder().decode(PortfolioResponse.self, from: data)
                    observer.onNext(portfolioResponse.portfolio)
                    observer.onCompleted()
                } catch {
                    observer.onError(NetworkError.decodingError)
                }
            }
            
            fetchPortfolioTask.resume()
            return Disposables.create {
                fetchPortfolioTask.cancel()
            }
        }
    }
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL"
        case .noData:
            return "No data received"
        case .decodingError:
            return "Failed to decode data"
        }
    }
}
