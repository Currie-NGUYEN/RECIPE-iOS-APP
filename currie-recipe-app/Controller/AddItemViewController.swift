//
//  AddItemViewController.swift
//  currie-recipe-app
//
//  Created by Currie on 3/2/20.
//  Copyright © 2020 Currie. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController, XMLParserDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var imageLink: UITextField!
    @IBOutlet weak var nameRecipe: UITextField!
    @IBOutlet weak var ingredients: UITextField!
    @IBOutlet weak var steps: UITextView!
    
    var recipeTypes: [RecipeType] = []
    var name = String()
    var elementName = String()
    var type: String = ""
    var recipes: [Recipe] = []
    
    let defaults = UserDefaults.standard
    let jsonEncoder = JSONEncoder()
    let jsonDecoder = JSONDecoder()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        recipes = read()
        
        if let path = Bundle.main.url(forResource: "recipetypes", withExtension: "xml") {
            if let parser = XMLParser(contentsOf: path) {
                parser.delegate = self
                parser.parse()
            }
        }
        
        picker.dataSource = self
        picker.delegate = self
        
       
        // Do any additional setup after loading the view.
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
//        print(recipeTypes[row].name)
        self.type = recipeTypes[row].name
    }
    
    @IBAction func addItem(_ sender: UIButton) {
        let recipe = Recipe(name: nameRecipe.text!, imageLink: imageLink.text!, ingredients: ingredients.text!, steps: steps.text!, type: self.type)
        self.save(data: recipe)
        navigationController?.popViewController(animated: true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func save(data:Recipe) {
        
        recipes.append(data)
        print(recipes)
        do{
            let value = try jsonEncoder.encode(self.recipes)
            defaults.set(value, forKey: "recipes")
        } catch let e{
            print(e)
        }
    }
    
    func read() -> [Recipe] {
        let data = defaults.object(forKey: "recipes")
        if(data != nil){
            do{
                let value = try jsonDecoder.decode([Recipe].self, from: data as! Data)
                return value
            } catch let e{
                print(e)
            }
        }
        return []
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


