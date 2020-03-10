//
//  DetailRecipeViewModel.swift
//  currie-recipe-app
//
//  Created by Currie on 3/9/20.
//  Copyright © 2020 Currie. All rights reserved.
//

import Foundation
import Resolver

class DetailRecipeViewModel {
    
    //MARK: properties
    @Injected var recipeService: RecipeServiceProtocol
    let filterRecipeVM = FilterRecipeViewModel()
    
    //MARK: handler
    func getDetailRecipe(name: String) -> RecipeViewModel? {
        let recipesVM = filterRecipeVM.filterRecipe(typeName: nil)
        for recipe in recipesVM {
            if recipe.name == name {
                return recipe
            }
        }
        return nil
    }
}
