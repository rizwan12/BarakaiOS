//
//  PortfolioViewModel.swift
//  Baraka
//
//  Created by Rizwan Saleem on 04/08/2025.
//
import RxSwift
import RxCocoa

class PortfolioViewModel {
    private var remoteDataSource: FetchPortfolioRemoteDataSource
    private let disposeBag = DisposeBag()
    
    init(remoteDataSource: FetchPortfolioRemoteDataSource = FetchPortfolioRemoteDataSourceImpl()) {
        self.remoteDataSource = remoteDataSource
    }
    
    // ViewModel -> Views
    let portfolio: BehaviorRelay<PortfolioModel?> = .init(value: nil)
    let isLoading: BehaviorRelay<Bool> = .init(value: false)
    let isError: PublishRelay<String> = .init()
    
    func loadPortfolio() {
        isLoading.accept(true)
        
        remoteDataSource.fetchRepositories()
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] portfolio in
                self?.portfolio.accept(portfolio)
                self?.isLoading.accept(false)
            },
            onError: { [weak self] error in
                self?.isLoading.accept(false)
                self?.isError.accept(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
}
