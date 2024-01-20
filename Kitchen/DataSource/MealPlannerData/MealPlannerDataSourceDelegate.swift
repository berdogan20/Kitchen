//
//  MealPlannerDataSourceDelegate.swift
//  Kitchen
//
//  Created by Yamaç Ömür on 6.01.2024.
//

import Foundation

protocol MealPlannerDataSourceDelegate: AnyObject {
    func mealPlanLoaded(data: MealPlan)
}
