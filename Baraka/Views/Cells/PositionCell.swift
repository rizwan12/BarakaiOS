//
//  PositionCell.swift
//  Baraka
//
//  Created by Rizwan Saleem on 03/08/2025.
//

import UIKit

class PositionCell: UICollectionViewCell {
    static let identifier = "PositionCell"
    
    private let containerView = UIView()
    private let tickerLabel = UILabel()
    private let nameLabel = UILabel()
    private let exchangeLabel = UILabel()
    private let marketValueLabel = UILabel()
    private let pnlLabel = UILabel()
    private let pnlPercentageLabel = UILabel()
    
    private let detailsStackView = UIStackView()
    private let quantityTitleLabel = UILabel()
    private let quantityValueLabel = UILabel()
    private let avgPriceTitleLabel = UILabel()
    private let avgPriceValueLabel = UILabel()
    private let lastPriceTitleLabel = UILabel()
    private let lastPriceValueLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupViews() {
        // Container view
        containerView.backgroundColor = UIColor.white
        containerView.layer.cornerRadius = 12
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: 2)
        containerView.layer.shadowRadius = 8
        containerView.layer.shadowOpacity = 0.1
        contentView.addSubview(containerView)
        
        // Ticker
        tickerLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        tickerLabel.textColor = UIColor.black
        containerView.addSubview(tickerLabel)
        
        // Market Value
        marketValueLabel.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        marketValueLabel.textColor = UIColor.black
        marketValueLabel.textAlignment = .right
        containerView.addSubview(marketValueLabel)
        
        // Name
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        nameLabel.textColor = UIColor.black
        nameLabel.numberOfLines = 2
        containerView.addSubview(nameLabel)
        
        // PnL
        pnlLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        pnlLabel.textAlignment = .right
        containerView.addSubview(pnlLabel)
        
        // Exchange
        exchangeLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        exchangeLabel.textColor = UIColor.systemGray
        containerView.addSubview(exchangeLabel)
        
        // PnL Percentage
        pnlPercentageLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        pnlPercentageLabel.textAlignment = .right
        containerView.addSubview(pnlPercentageLabel)
        
        // Details Stack View
        detailsStackView.axis = .horizontal
        detailsStackView.distribution = .fillEqually
        detailsStackView.spacing = 16
        containerView.addSubview(detailsStackView)
        
        // Quantity
        let quantityContainer = createDetailContainer(
            titleLabel: quantityTitleLabel,
            valueLabel: quantityValueLabel,
            title: "Quantity"
        )
        
        // Average Price
        let avgPriceContainer = createDetailContainer(
            titleLabel: avgPriceTitleLabel,
            valueLabel: avgPriceValueLabel,
            title: "Avg Price"
        )
        
        // Last Price
        let lastPriceContainer = createDetailContainer(
            titleLabel: lastPriceTitleLabel,
            valueLabel: lastPriceValueLabel,
            title: "Last Price"
        )
        
        detailsStackView.addArrangedSubview(quantityContainer)
        detailsStackView.addArrangedSubview(avgPriceContainer)
        detailsStackView.addArrangedSubview(lastPriceContainer)
    }
    
    private func setupConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        tickerLabel.translatesAutoresizingMaskIntoConstraints = false
        marketValueLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        pnlLabel.translatesAutoresizingMaskIntoConstraints = false
        exchangeLabel.translatesAutoresizingMaskIntoConstraints = false
        pnlPercentageLabel.translatesAutoresizingMaskIntoConstraints = false
        detailsStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            // First row
            tickerLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            tickerLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            
            marketValueLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            marketValueLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            marketValueLabel.leadingAnchor.constraint(greaterThanOrEqualTo: tickerLabel.trailingAnchor, constant: 16),
            
            // Second row
            nameLabel.topAnchor.constraint(equalTo: tickerLabel.bottomAnchor, constant: 4),
            nameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            nameLabel.widthAnchor.constraint(lessThanOrEqualTo: containerView.widthAnchor, multiplier: 0.6),
            
            pnlLabel.topAnchor.constraint(equalTo: marketValueLabel.bottomAnchor, constant: 4),
            pnlLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            pnlLabel.leadingAnchor.constraint(greaterThanOrEqualTo: nameLabel.trailingAnchor, constant: 16),
            
            // Third row
            exchangeLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 4),
            exchangeLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            
            pnlPercentageLabel.topAnchor.constraint(equalTo: pnlLabel.bottomAnchor, constant: 4),
            pnlPercentageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            pnlPercentageLabel.leadingAnchor.constraint(greaterThanOrEqualTo: exchangeLabel.trailingAnchor, constant: 16),
            
            // Details stack view
            detailsStackView.topAnchor.constraint(equalTo: exchangeLabel.bottomAnchor, constant: 20),
            detailsStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            detailsStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            detailsStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
        ])
    }
    
    func configure(with position: Position) {
        var sign = "";
        tickerLabel.text = position.instrument.ticker
        nameLabel.text = position.instrument.name
        exchangeLabel.text = "\(position.instrument.exchange) • \(position.instrument.currency)"
        marketValueLabel.text = String(format: "%.2f", position.marketValue)
        
        sign = position.pnl >= 0 ? "+" : ""
        pnlLabel.text = "\(sign)\(String(format: "%.2f", position.pnl))"
        
        sign = position.pnlPercentage >= 0 ? "+" : ""
        pnlPercentageLabel.text = "\(sign)\(String(format: "%.2f", position.pnlPercentage))"
        
        quantityValueLabel.text = String(format: "%.2f", position.quantity)
        avgPriceValueLabel.text = String(format: "%.2f", position.averagePrice)
        lastPriceValueLabel.text = String(format: "%.2f", position.instrument.lastTradedPrice)
        
        let profitColor = UIColor.systemGreen
        let lossColor = UIColor.systemRed
        
        pnlLabel.textColor = position.pnl > 0 ? profitColor : lossColor
        pnlPercentageLabel.textColor = position.pnl > 0 ? profitColor : lossColor
    }
}

extension PositionCell {
    private func createDetailContainer(titleLabel: UILabel, valueLabel: UILabel, title: String) -> UIView {
        let container = UIView()
        
        titleLabel.text = title
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        titleLabel.textColor = UIColor.systemGray
        titleLabel.textAlignment = .center
        container.addSubview(titleLabel)
        
        valueLabel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        valueLabel.textColor = UIColor.black
        valueLabel.textAlignment = .center
        container.addSubview(valueLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        valueLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: container.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            
            valueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            valueLabel.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            valueLabel.trailingAnchor.constraint(equalTo: container.trailingAnchor),
            valueLabel.bottomAnchor.constraint(equalTo: container.bottomAnchor)
        ])
        
        return container
    }
}
