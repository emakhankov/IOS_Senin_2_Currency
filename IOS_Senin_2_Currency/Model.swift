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
    func loadXMLFile(data: Data) {
    }
    
    //Распарсить XML и сохранить его в массив Currencies
    //также отправить уведомления приложению что у нас есть новые данные
    func parseXML() {
        
        let parser = XMLParser(contentsOf: urlForXML)
        parser?.delegate = self;
        parser?.parse();
    }
    
    
    var currentCurrency: Currency?
    
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
    
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
            currentCurrency = Currency();
        }
    }
    
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        
        currencies.append(currentCurrency!);
        
    }
    
    var currentCharacters: String = "";
    func parser(_ parser: XMLParser, foundCharacters string: String) {
        currentCharacters = string;
    }
    
}
