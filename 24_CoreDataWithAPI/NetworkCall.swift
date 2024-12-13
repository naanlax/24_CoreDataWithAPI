//
//  NetworkCall.swift
//  24_CoreDataWithAPI
//
//  Created by Nandhika T M on 12/12/24.
//

import UIKit
import CoreData

class NetworkCall
{
    var postData: [String: Any] = [:]
    
    private let oauthToken = "Zoho-oauthtoken 1000.c3fbc52c73958861f51be67a3c8cd70a.a3792e709a8daa8d96b9f6e6fd56385e"
    
    var serviceUrl: URL?
    
    var request: URLRequest?
    
    let manageObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func postDataAndPutData(
        methodPerformed : String,
        messagePassed : ItemList,
        completion: @escaping (ItemList) -> Void)
    {
        if methodPerformed == "POST"
        {
            let serviceUrl = URL(string: "https://www.zohoapis.com/books/v3/items?organization_id=863010973")!
            request = URLRequest(url: serviceUrl)
            request?.httpMethod = "POST"
        }
        else
        {
            let itemId = messagePassed.item_id
            let serviceUrl = URL(string: "https://www.zohoapis.com/books/v3/items/\(itemId ?? "")?organization_id=863010973")!
            request = URLRequest(url: serviceUrl)
            request?.httpMethod = "PUT"
        }
        
        postData["name"] = messagePassed.name
        postData["sku"] = messagePassed.sku
        postData["rate"] = messagePassed.rate
        postData["description"] = messagePassed.desc
        
        guard let jsonData = try? JSONSerialization.data(
            withJSONObject: postData,
            options: []) else
        {
            print("Error: Unable to serialize JSON");
            fatalError()
        }
        
        request?.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request?.addValue("\(oauthToken)", forHTTPHeaderField: "Authorization")
        request?.httpBody = jsonData
        
        if let request
        {
            let task = URLSession.shared.dataTask(with: request)
            {
                data, response, error in
                if let error = error
                {
                    print("Error: \(error.localizedDescription)")
                    return
                }
                
                if let httpResponse = response as? HTTPURLResponse
                {
                    print("HTTP Status Code: \(httpResponse.statusCode)")
                }
                
                if let data = data
                {
                    do
                    {
                        let responseObject = try JSONSerialization.jsonObject(
                            with: data,
                            options: .mutableContainers) as? [String : Any]
                        
                        if let jsonResponse = responseObject?["item"] as? [String: Any]
                        {
                            var item_id = jsonResponse["item_id"] as? String
                            messagePassed.item_id = item_id
                            
                            try! self.manageObjectContext.save()
                            completion(messagePassed)
                        }
                    }
                    catch
                    {
                        print("Error parsing response JSON: \(error)")
                    }
                }
            }
            task.resume()
        }
    }
    
    func deleteData(itemIDPassed : String, completion : @escaping (Int) -> Void)
    {
        let serviceUrl = URL(string: "https://www.zohoapis.com/books/v3/items/\(itemIDPassed)?organization_id=863010973")!
        
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "DELETE"
        request.addValue("\(oauthToken)", forHTTPHeaderField: "Authorization")
        
        let task = URLSession.shared.dataTask(with: request)
        {
            data, response, error in
            if let error = error
            {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse
            {
                print("HTTP Status Code: \(httpResponse.statusCode)")
                completion(httpResponse.statusCode)
            }
            
            if let data = data
            {
                do
                {
                    let responseObject = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String : Any]
                }
                catch
                {
                    print("Error parsing response JSON: \(error)")
                }
            }
        }
        task.resume()
    }
}

