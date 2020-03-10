//
//  GetAllRecipeTypesViewModel.swift
//  currie-recipe-app
//
//  Created by Currie on 3/10/20.
//  Copyright © 2020 Currie. All rights reserved.
//

import Foundation
import Resolver

class GetAllRecipeTypesViewModel {
    @Injected var recipeTypeService: RecipeTypeServiceProtocol
    
    func getAllType() -> [RecipeTypeViewModel] {
        return recipeTypeService.getAllRecipeType()
    }
}
