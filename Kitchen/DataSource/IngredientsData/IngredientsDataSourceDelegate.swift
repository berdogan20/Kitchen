//
//  IngredientsDataSourceDelegate.swift
//  Kitchen
//
//  Created by beyza erdoğan on 5.01.2024.
//

import Foundation

protocol IngredientsDataSourceDelegate: AnyObject {
    func ingredientsLoaded(data: Ingredients)
}
