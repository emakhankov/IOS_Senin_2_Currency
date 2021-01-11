//
//  Model.swift
//  IOS_Senin_2_Currency
//
//  Created by Jenya on 07.01.2021.
//

import UIKit

class Currency
{
    var NumCode: String?
    var CharCode: String?
    
    var Nominal: String?
    var nominalDouble: Double?
    
    var Name: String?
    
    var Value: String?
    var valueDouble: Double?
}



class Model: NSObject, XMLParserDelegate {
    static let shared = Model();
    
    var currencies: [Currency] = [];
    //var currentDate: Date = Date()
    var currentDate: String = ""
    
    var pathForXML: String {
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.libraryDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)[0]+"/data.xml";
        
        if FileManager.default.fileExists(atPath: path)
        {
            return path;
        }
        return Bundle.main.path(forResource: "data", ofType: "xml")!
    }
    
    var urlForXML: URL {
        return URL(fileURLWithPath: pathForXML);
    }
    //Загрузка с сайта центробанка
    //http://www.cbr.ru/scripts/XML_daily.asp?date_req=02/03/2002
    func loadXMLFile(date: Date?) {
        
        var strUrl = "http://www.cbr.ru/scripts/XML_daily.asp?date_req=";
        
        if date != nil {
            let dateFormater = DateFormatter();
            dateFormater.dateFormat = "dd/MM/yyyy";
            strUrl = strUrl + dateFormater.string(from: date!);
        }
        
        
        let url = URL(string: strUrl);
        
        let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
            
            if error == nil {
                let urlForSave = self.urlForXML;
                
                do {
                    try data?.write(to: urlForSave);
                    print("Файл загружен");
                    self.parseXML();
                }
                catch {
                    print("Error when save data:\(error.localizedDescription)");
                }
            }
            else
            {
                print("error when loadXMLFile" + error!.localizedDescription);
            }
        }
        task.resume();
        
    }
    
    //Распарсить XML и сохранить его в массив Currencies
    //также отправить уведомления приложению что у нас есть новые данные
    func parseXML() {
        
        currencies = []
        
        let parser = XMLParser(contentsOf: urlForXML)
        parser?.delegate = self;
        parser?.parse();
        
        print("Данные обновлены");
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "dataRefreshed"), object: self)
    }
    
    
    var currentCurrency: Currency?
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
    
        if elementName == "ValCurs" {
            
            if let currentDateString = attributeDict["Date"] {
                currentDate = currentDateString
                //let df = DateFormatter();
                //df.dateFormat = "dd.MM.yyyy";
                //currentDate = df.date(from: currentDateString)!
            }
        }
        
        if elementName == "Valute" {
            currentCurrency = Currency();
        }
        
    }
    
    var currentCharacters: String = "";
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        currentCharacters = string;
    }
    
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        
        if elementName=="NumCode" {
            currentCurrency?.NumCode = currentCharacters;
        }
        if elementName=="CharCode" {
            currentCurrency?.CharCode = currentCharacters;
        }
        if elementName=="Nominal" {
            currentCurrency?.Nominal = currentCharacters;
            currentCurrency?.nominalDouble = Double(currentCharacters.replacingOccurrences(of: ",", with: "."));
        }
        if elementName=="Name" {
            currentCurrency?.Name = currentCharacters;
        }
        if elementName=="Value" {
            currentCurrency?.Value = currentCharacters;
            currentCurrency?.valueDouble = Double(currentCharacters.replacingOccurrences(of: ",", with: "."));
        }

        
        if elementName == "Valute" {
            currencies.append(currentCurrency!);
        }
        
        
    }
    

    
}
