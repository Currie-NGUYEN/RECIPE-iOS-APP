//
//  RecipeServiceProtocol.swift
//  currie-recipe-app
//
//  Created by Currie on 3/10/20.
//  Copyright © 2020 Currie. All rights reserved.
//

import Foundation

protocol RecipeServiceProtocol {
    func read(filterType: String?) -> [RecipeViewModel]
    func save(recipe: RecipeViewModel)
    func delete(recipeDelete: RecipeViewModel)
    func updateListRecipes(recipesVM: [RecipeViewModel])
    func update(recipeUpdate: RecipeViewModel)
}
