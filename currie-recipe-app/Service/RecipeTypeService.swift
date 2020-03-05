//
//  RecipeTypeService.swift
//  currie-recipe-app
//
//  Created by Currie on 3/5/20.
//  Copyright © 2020 Currie. All rights reserved.
//

import Foundation

class RecipeTypeService: NSObject, XMLParserDelegate {
    
    //MARK: properties
    var name = String()
    var elementName = String()
    var recipeTypes: [RecipeType] = []
    
    //MARK: init
    override init() {
        super.init()
        if let path = Bundle.main.url(forResource: "recipetypes", withExtension: "xml") {
            if let parser = XMLParser(contentsOf: path) {
                parser.delegate = self
                parser.parse()
            }
        }
    }
    
    //MARK: handler
    func getAllRecipeType() -> [RecipeType] {
        return recipeTypes
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        
        if( elementName == "type"){

            name = String()
        }
        
        self.elementName = elementName
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if( elementName == "type"){
            let recipeType = RecipeType(name: name)
            self.recipeTypes.append(recipeType)
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

        if (!data.isEmpty) {
            if self.elementName == "name" {
                name += data
            }
        }
    }
}
