//
//  ViewController.swift
//  PickerViewJson
//
//  Created by Carlos on 1/21/18.
//  Copyright © 2018 Carlos-iv. All rights reserved.
//

import UIKit

struct Country: Decodable {
    let name: String
}

class ViewController: UIViewController,UIPickerViewDelegate, UIPickerViewDataSource  {
    @IBOutlet weak var countrylbl: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var countries = [Country]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let url = URL(string: "https://restcountries.eu/rest/v2/all")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error == nil {
                do{
                    self.countries = try JSONDecoder().decode([Country].self, from: data!)
                }catch {
                    print("Parse Error")
                }
                
                DispatchQueue.main.async {
                    self.pickerView.reloadComponent(0)
                }
                
            }
            }.resume()
        
    }

   // PickerView methods
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return countries.count
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return countries[row].name
    }
    
    // delegate method
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCountry = countries[row].name
        countrylbl.text = selectedCountry
    }


}

