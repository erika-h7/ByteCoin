//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

//protocol CoinManagerDelegate {
//    func didUpdateCurrency(_ coinManager: CoinManager, coin: CoinModel)
//    func didFailWithError(error: error)
//}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "278743D8-7B0A-4142-BE6D-D05FF60DD3E0"
    
    //    var url = "https://rest.coinapi.io/v1/exchangerate/BTC?apikey=\(apiKey)"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    // Delegate
//    var delegate: CoinManagerDelegate?
    
    
    func getCoinPrice(for currency: String) {
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        
        //1. Converte url into string
        if let url = URL(string: urlString) {
            //2. Create a URLSession object with default configuration.
            let session = URLSession(configuration: .default)
            
            //3. Give the session a task for the URLSession
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    return
                }
                //                //Format the data we got back as a string to be able to print it.
                //                let dataAsString = String(data: data!, encoding: .utf8)
                //                print(dataAsString)
                
                if let safeData = data {
                    let bitcoinPrice = self.parseJSON(safeData)
                }
                
            }
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> Double? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: data)
            let lastPrice = decodedData.rate
            print(lastPrice)
            return lastPrice
        } catch {
            //            delegate?.didFailWithError(self, error: error)
            print(error)
            return nil
        }
    }
}
