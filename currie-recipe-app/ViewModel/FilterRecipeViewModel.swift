//
//  FilterRecipeViewModel.swift
//  currie-recipe-app
//
//  Created by Currie on 3/9/20.
//  Copyright © 2020 Currie. All rights reserved.
//

import Foundation

class FilterRecipeViewModel {
    
    //MARK: properties
    let recipeService = RecipeService()
    
    //MARK: Handler
    func filterRecipe(typeName: String?) -> [RecipeViewModel] {
        if typeName == "All"{
            return recipeService.read(filterType: nil)
        } else {
            return recipeService.read(filterType: typeName)
        }
    }
}
