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


class People {
    var name: String?
    var price: Double = 0
}

class AdditonalPrice {
    var priceDiscount: Double = 0
    var pricePajak: Double = 0
    var priceOngkir: Double = 0
}

class Receipt {
    var title: String?
    var date: String?
    var peopleData: [People?] = []
    var additionalPrice: [AdditonalPrice?] = []
    var priceTotal: Double = 0
}
