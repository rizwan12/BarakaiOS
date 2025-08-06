//
//  BalanceCell.swift
//  Baraka
//
//  Created by Rizwan Saleem on 03/08/2025.
//
import UIKit

class BalanceCell: UICollectionViewCell {
    static let identifier = "BalanceCell"
    
    private let containerView = UIView()
    private let netValueLabel = UILabel()
    private let netValueAmountLabel = UILabel()
    private let pnlStackView = UIStackView()
    private let pnlLabel = UILabel()
    private let pnlAmountLabel = UILabel()
    private let pnlPercentageLabel = UILabel()
    private let pnlPercentageAmountLabel = UILabel()
    
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
        
        // Net Value Label
        netValueLabel.text = "Net Value"
        netValueLabel.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        netValueLabel.textColor = UIColor.systemGray
        containerView.addSubview(netValueLabel)
        
        // Net Value Amount
        netValueAmountLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        netValueAmountLabel.textColor = UIColor.black
        containerView.addSubview(netValueAmountLabel)
        
        // PnL Stack View
        pnlStackView.axis = .horizontal
        pnlStackView.distribution = .fillEqually
        pnlStackView.spacing = 20
        containerView.addSubview(pnlStackView)
        
        // PnL
        let pnlContainerView = UIView()
        pnlLabel.text = "PnL"
        pnlLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        pnlLabel.textColor = UIColor.systemGray
        pnlContainerView.addSubview(pnlLabel)
        
        pnlAmountLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        pnlContainerView.addSubview(pnlAmountLabel)
        
        // PnL Percentage
        let pnlPercentageContainerView = UIView()
        pnlPercentageLabel.text = "PnL Percentage"
        pnlPercentageLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        pnlPercentageLabel.textColor = UIColor.systemGray
        pnlPercentageContainerView.addSubview(pnlPercentageLabel)
        
        pnlPercentageAmountLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        pnlPercentageContainerView.addSubview(pnlPercentageAmountLabel)
        
        pnlStackView.addArrangedSubview(pnlContainerView)
        pnlStackView.addArrangedSubview(pnlPercentageContainerView)
        
        // PnL container constraints
        pnlLabel.translatesAutoresizingMaskIntoConstraints = false
        pnlAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        pnlPercentageLabel.translatesAutoresizingMaskIntoConstraints = false
        pnlPercentageAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            pnlLabel.topAnchor.constraint(equalTo: pnlContainerView.topAnchor),
            pnlLabel.leadingAnchor.constraint(equalTo: pnlContainerView.leadingAnchor),
            pnlLabel.trailingAnchor.constraint(equalTo: pnlContainerView.trailingAnchor),
            
            pnlAmountLabel.topAnchor.constraint(equalTo: pnlLabel.bottomAnchor, constant: 4),
            pnlAmountLabel.leadingAnchor.constraint(equalTo: pnlContainerView.leadingAnchor),
            pnlAmountLabel.trailingAnchor.constraint(equalTo: pnlContainerView.trailingAnchor),
            pnlAmountLabel.bottomAnchor.constraint(equalTo: pnlContainerView.bottomAnchor),
            
            pnlPercentageLabel.topAnchor.constraint(equalTo: pnlPercentageContainerView.topAnchor),
            pnlPercentageLabel.leadingAnchor.constraint(equalTo: pnlPercentageContainerView.leadingAnchor),
            pnlPercentageLabel.trailingAnchor.constraint(equalTo: pnlPercentageContainerView.trailingAnchor),
            
            pnlPercentageAmountLabel.topAnchor.constraint(equalTo: pnlPercentageLabel.bottomAnchor, constant: 4),
            pnlPercentageAmountLabel.leadingAnchor.constraint(equalTo: pnlPercentageContainerView.leadingAnchor),
            pnlPercentageAmountLabel.trailingAnchor.constraint(equalTo: pnlPercentageContainerView.trailingAnchor),
            pnlPercentageAmountLabel.bottomAnchor.constraint(equalTo: pnlPercentageContainerView.bottomAnchor)
        ])
    }
    
    private func setupConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        netValueLabel.translatesAutoresizingMaskIntoConstraints = false
        netValueAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        pnlStackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8),
            
            netValueLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            netValueLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            netValueLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            netValueAmountLabel.topAnchor.constraint(equalTo: netValueLabel.bottomAnchor, constant: 8),
            netValueAmountLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            netValueAmountLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            pnlStackView.topAnchor.constraint(equalTo: netValueAmountLabel.bottomAnchor, constant: 24),
            pnlStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            pnlStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            pnlStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
        ])
    }
    
    func configure(with balance: Balance) {
        netValueAmountLabel.text = String(format: "%.2f", balance.netValue)
        var sign = balance.pnl >= 0 ? "+" : ""
        pnlAmountLabel.text = "\(sign)\(String(format: "%.2f", balance.pnl))"
        
        sign = balance.pnlPercentage >= 0 ? "+" : ""
        pnlPercentageAmountLabel.text = "\(sign)\(String(format: "%.2f", balance.pnlPercentage))%"
        
        let profitColor = UIColor.systemGreen
        let lossColor = UIColor.systemRed
        
        pnlAmountLabel.textColor = balance.pnl > 0 ? profitColor : lossColor
        pnlPercentageAmountLabel.textColor = balance.pnl > 0 ? profitColor : lossColor
    }
}
