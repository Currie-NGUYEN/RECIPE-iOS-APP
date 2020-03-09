//
//  AddRecipeViewModel.swift
//  currie-recipe-app
//
//  Created by Currie on 3/9/20.
//  Copyright © 2020 Currie. All rights reserved.
//

import Foundation

protocol  AddRecipeViewModelDelegate{
    func didAddRecipe()
}

class AddRecipeViewModel {
    
    //MARK: properties
    let recipeService = RecipeService()
    var addRecipeViewModelDelegate:AddRecipeViewModelDelegate?
    
    //MARK: handler
    func addRecipe(recipe: RecipeViewModel) {
        recipeService.save(recipe: recipe)
        addRecipeViewModelDelegate?.didAddRecipe()
    }
}
