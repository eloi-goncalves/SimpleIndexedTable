//
//  Countrys.swift
//  CountrysTable
//
//  Created by Eloi Andre Goncalves on 11/03/17.
//  Copyright © 2017 Eloi Andre Goncalves. All rights reserved.
//

import UIKit

class Countries: UITableViewController {

    //Array of countries ->> countries.json
    var countries = [Country]()

    //Titles sections of table.
    var countriesTitles = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadingCountriesJSON()
        
    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return countriesTitles.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        let countryKey = countriesTitles[section]
        var numberOfCountryByLetter = 0
        
        for country in countries {
            if country.firstLetter == countryKey{
                numberOfCountryByLetter += 1
            }
        }
        return numberOfCountryByLetter
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let countryCell : CountryCell = tableView.dequeueReusableCell(withIdentifier: "countriesCell", for: indexPath) as! CountryCell
        
        var selectedCountries = [Country]()

        
        let countryKey = countriesTitles[indexPath.section]
        
        
        for country in countries {
            if country.firstLetter == countryKey {
                selectedCountries.append(country)
            }
        }

        countryCell.desc.text = selectedCountries[indexPath.row].name
        countryCell.flag.text = flag(country: selectedCountries[indexPath.row].code)
        
       
        return countryCell
    }

    
     override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return countriesTitles
      }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return countriesTitles[section]
    }


    //Loading Json
    func loadingCountriesJSON () {
        
        var parseJSON = Array<NSDictionary>()
        
        let path = Bundle.main.path(forResource: "countries", ofType: "json")
        
        let jsonData = NSData(contentsOfFile: path!)
        
        var firstLetter = String()
        var myKey = String()
        var myValue = String()
        
        do {
            
            parseJSON = try JSONSerialization.jsonObject(with: jsonData! as Data, options: .allowFragments) as! Array<NSDictionary>

            
            for json in parseJSON {
                
                for (key,value) in json as! [String:String]{
                    
                    if key == "name" {
                        myKey = value
                    } else if key  == "code" {
                        myValue = value
                    }
                    
                    //get first letter
                    let indexString = myKey.index(myKey.startIndex, offsetBy: 1)
                    firstLetter = myKey.substring(to: indexString)
                }
            
                //create de country model
                let country = Country(name: myKey, code: myValue, firstLetter: firstLetter)
                
                //append in dictionary
                countries.append(country)
                
                if !countriesTitles.contains(firstLetter) {
                    countriesTitles.append(firstLetter)
                }
                
            }
            
            //sort list of countries titles.
            countriesTitles = countriesTitles.sorted(by: { $0 < $1 })
            
        } catch {
            print("Error in Parse Json")
        }
        
    }
    

    
    func flag(country : String) -> String{
        
        let base : UInt32 = 127397
        return country.uppercased().unicodeScalars.flatMap{ String.init(UnicodeScalar(base + $0.value)!) }.joined()
    }
    

}

class CountryCell : UITableViewCell {

    @IBOutlet weak var flag: UILabel!
    @IBOutlet weak var desc: UILabel!
}
