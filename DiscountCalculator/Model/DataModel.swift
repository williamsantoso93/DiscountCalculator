//
//  DataModel.swift
//  DiscountCalculator
//
//  Created by William Santoso on 11/09/19.
//  Copyright © 2019 William Santoso. All rights reserved.
//

import Foundation

class DebtData {
    var name : String?
    var price : String?
    var priceDiscount : Double = 0
    var pricePajak : Double = 0
    var priceAfterDiscount : Double = 0
    var priceAfterDiscountPajakOngkir : Double = 0
}

enum priceType: String {
    case discountPrice = "Discount"
    case taxPrice = "Tax"
    case deliveryFee = "Delivery Fee"
}

class Item: Codable {
    var itemName: String = "No name item"
    var qty: Double = 0
    var price: Double = 0
}

enum Status: String {
    case paid = "Paid"
    case notPaid = "Not Paid"
}

class People: Codable {
    var name: String = "No Name"
    var items: [Item] = []
    var personTotalPrice: Double = 0
    var priceAfterDiscount: Double = 0
    //    var status: Status = .notPaid
    var status: String = "Not Paid"
}

class AdditionalFee: Codable {
    var type: String = "Discount"
    var price: Double = 0
}

class Receipt: Codable {
    var title: String = "No Title"
    var date: Date = Date()
    var paidBy: String = "Me"
    var peoples: [People] = []
    var additionalPrices: [AdditionalFee] = []
    var totalPrice: Double = 0
}
