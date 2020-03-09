//
//  DeleteRecipeViewModel.swift
//  currie-recipe-app
//
//  Created by Currie on 3/9/20.
//  Copyright © 2020 Currie. All rights reserved.
//

import Foundation

protocol DeleteRecipeViewModelDelegate {
    func didDeleteRecipe()
}

class DeleteRecipeViewModel {
    
    //MARK: properties
    let recipeService = RecipeService()
    var deleteRecipeViewModelDelegate:DeleteRecipeViewModelDelegate?
    
    //MARK: handler
    func deleteRecipe(recipe: RecipeViewModel) {
        self.recipeService.delete(recipeDelete: recipe)
        deleteRecipeViewModelDelegate?.didDeleteRecipe()
    }
    
}
