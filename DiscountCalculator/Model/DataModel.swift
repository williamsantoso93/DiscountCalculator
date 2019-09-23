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

struct priceType {
    var discountPrice: String = "Discount"
    var taxPrice: String = "Tax"
    var deliveryFee: String = "Delivery Fee"
}


class People {
    var name: String = "No Name"
    var price: Double = 0
    var status: String = "Not Paid"
}

class AdditionalFee {
//    var priceDiscount: Double = 0
//    var pricePajak: Double = 0
//    var priceOngkir: Double = 0
    var type: String = "Discount"
//    var type = priceType()
    var price: Double = 0
}

//class PeopleSummary {
//    var peoples: [People] = []
//    var additionalPrices: [AdditionalPrice] = []
//}

class Receipt {
    var title: String = "No Title"
    var date: Date = Date()
    var paidBy: String = "Me"
    var peoples: [People] = []
    var additionalPrices: [AdditionalFee] = []
//    var peopleSummaries: [PeopleSummary] = []
    var totalPrice: Double = 0
}
