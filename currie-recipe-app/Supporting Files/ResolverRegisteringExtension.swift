//
//  ResolverRegisteringExtension.swift
//  currie-recipe-app
//
//  Created by Currie on 3/10/20.
//  Copyright © 2020 Currie. All rights reserved.
//

import Foundation
import Resolver

extension Resolver: ResolverRegistering{
    public static func registerAllServices() {
        register{ RecipeService() as RecipeServiceProtocol }.scope(shared)
        register{ RecipeTypeService() as RecipeTypeServiceProtocol }.scope(shared)
    }
}
