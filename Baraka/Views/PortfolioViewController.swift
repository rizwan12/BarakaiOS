//
//  ViewController.swift
//  Baraka
//
//  Created by Rizwan Saleem on 01/08/2025.
//

import UIKit
import RxSwift

class PortfolioViewController: UIViewController {
    
    private let viewModel = PortfolioViewModel()
    private let disposeBag = DisposeBag()
    
    private lazy var collectionView: UICollectionView = {
        let compositionalLayout = createCompositionalLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: compositionalLayout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(BalanceCell.self, forCellWithReuseIdentifier: BalanceCell.identifier)
        cv.register(PositionCell.self, forCellWithReuseIdentifier: PositionCell.identifier)
        cv.register(SectionHeaderViewCell.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeaderViewCell.identifier)
        cv.backgroundColor = UIColor.systemGray6
        return cv
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        return refresh
    }()
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, Item>!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Portfolio"
        setupUI()
        setupDataSource()
        bindViewModel()
        viewModel.loadPortfolio()
    }
    
    func setupUI() {
        view.backgroundColor = .white
        
        view.addSubview(collectionView)
        collectionView.refreshControl = refreshControl
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, Item>(collectionView: collectionView) { collectionView, indexPath, item in
            switch item {
            case .balance(let portfolio):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BalanceCell.identifier, for: indexPath) as! BalanceCell
                cell.configure(with: portfolio.balance)
                return cell
            case .position(let position):
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PositionCell.identifier, for: indexPath) as! PositionCell
                cell.configure(with: position)
                return cell
            }
        }
        
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            guard kind == UICollectionView.elementKindSectionHeader else { return nil }
            
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: SectionHeaderViewCell.identifier, for: indexPath) as! SectionHeaderViewCell
            
            let section = Section.allCases[indexPath.section]
            header.configure(with: section.title)
            return header
        }
    }
    
    private func bindViewModel() {
        viewModel.portfolio
            .compactMap { $0 }
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] portfolio in
                self?.updateSnapshot(with: portfolio)
            })
            .disposed(by: disposeBag)
        
        // Bind loading state
        viewModel.isLoading
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] isLoading in
                if !isLoading {
                    self?.refreshControl.endRefreshing()
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func updateSnapshot(with portfolio: PortfolioModel) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        
        snapshot.appendSections([.balance])
        snapshot.appendItems([.balance(portfolio)], toSection: .balance)
        
        if !portfolio.positions.isEmpty {
            snapshot.appendSections([.positions])
            let positionItems = portfolio.positions.map { Item.position($0) }
            snapshot.appendItems(positionItems, toSection: .positions)
        }
        
        dataSource.apply(snapshot, animatingDifferences: true)
    }
}

extension PortfolioViewController {
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { sectionIndex, environment in
            let section = Section.allCases[sectionIndex]
            
            switch section {
            case .balance:
                return self.createBalanceSection()
            case .positions:
                return self.createPositionsSection()
            }
        }
    }
    
    private func createBalanceSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(120))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(120))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
        
        return section
    }
    
    private func createPositionsSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(80))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(80))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 16, trailing: 16)
        section.interGroupSpacing = 8
        
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .estimated(44))
        let header = NSCollectionLayoutBoundarySupplementaryItem(layoutSize: headerSize, elementKind: UICollectionView.elementKindSectionHeader, alignment: .top)
        section.boundarySupplementaryItems = [header]
        
        return section
    }
    
    @objc private func refreshData() {
        viewModel.loadPortfolio()
    }
}

enum Section: CaseIterable {
    case balance
    case positions
    
    var title: String {
        switch self {
        case .balance:
            return "Balance"
        case .positions:
            return "Positions"
        }
    }
}

enum Item: Hashable {
    case balance(PortfolioModel)
    case position(Position)
}
