//
//  EditViewController.swift
//  currie-recipe-app
//
//  Created by Currie on 3/2/20.
//  Copyright © 2020 Currie. All rights reserved.
//

import UIKit

class EditViewController: UIViewController, XMLParserDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var imageRecipe: UITextField!
    @IBOutlet weak var pickerType: UIPickerView!
    @IBOutlet weak var ingredients: UITextView!
    @IBOutlet weak var steps: UITextView!
    
    let defaults = UserDefaults.standard
    let jsonEncoder = JSONEncoder()
    let jsonDecoder = JSONDecoder()
    
    var recipes:[Recipe] = []
    var recipeTypes: [RecipeType] = []
    var nameType = String()
    var elementName = String()
    var recipeType: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let name = self.title
        
        if let path = Bundle.main.url(forResource: "recipetypes", withExtension: "xml") {
            if let parser = XMLParser(contentsOf: path) {
                parser.delegate = self
                parser.parse()
            }
        }
        
        pickerType.dataSource = self
        pickerType.delegate = self
        
        recipes = read()
        for recipe in recipes {
            if recipe.name == name! {
                self.imageRecipe.text = recipe.imageLink
                self.name.text = recipe.name
                recipeType = recipe.type
                let tmpType = RecipeType(name: recipe.type)
                let defaultType = recipeTypes.lastIndex { $0.name == tmpType.name }
                self.pickerType.selectRow(defaultType!, inComponent: 0, animated: true)
                self.ingredients.text = recipe.ingredients
                self.steps.text = recipe.steps
            }
        }
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func done(_ sender: UIButton) {
        var i = 0
        for recipe in recipes {
            if recipe.name == self.title {
                recipes[i].imageLink = self.imageRecipe.text!
                recipes[i].type = recipeType
                print(recipeType)
                recipes[i].ingredients = self.ingredients.text
                recipes[i].steps = self.steps.text
                break
            }
            i += 1
        }
        save()
        navigationController?.popViewController(animated: true)
    }
    
    func save() {
        print(recipes[0].type)
        do{
            let value = try jsonEncoder.encode(self.recipes)
            defaults.set(value, forKey: "recipes")
        } catch let e{
            print(e)
        }
    }
    
    func read() -> [Recipe] {
        let data = defaults.object(forKey: "recipes")
        do{
            let value = try jsonDecoder.decode([Recipe].self, from: data as! Data)
            return value
        } catch let e{
            print(e)
        }
        return []
    }
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
            
            if( elementName == "type"){

                nameType = String()
            }
            
            self.elementName = elementName
        }
        
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        if( elementName == "type"){
            let recipeType = RecipeType(name: nameType)
            self.recipeTypes.append(recipeType)
        }
    }
    
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        let data = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)

        if (!data.isEmpty) {
            if self.elementName == "name" {
                nameType += data
            }
        }
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return recipeTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return recipeTypes[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        self.recipeType = recipeTypes[row].name
        print(recipeType)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
