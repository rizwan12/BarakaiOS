//
//  PortfolioModel.swift
//  Baraka
//
//  Created by Rizwan Saleem on 04/08/2025.
//

import Foundation

struct PortfolioResponse: Codable {
  let portfolio: PortfolioModel
}

struct PortfolioModel: Codable, Equatable, Hashable {
    let balance: Balance
    let positions: [Position]
}

struct Balance: Codable, Equatable, Hashable {
    let netValue: Double
    let pnl: Double
    let pnlPercentage: Double
}

struct Position: Codable, Equatable, Hashable {
    let instrument: Instrument
    let quantity: Double
    let averagePrice: Double
    let cost: Double
    let marketValue: Double
    let pnl: Double
    let pnlPercentage: Double
}

struct Instrument: Codable, Equatable, Hashable {
    let ticker: String
    let name: String
    let exchange: String
    let currency: String
    let lastTradedPrice: Double
}
