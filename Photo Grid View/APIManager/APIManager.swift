//
//  APIManager.swift
//  Photo Grid View
//
//  Created by Surya Pratap Singh on 18/08/21.
//

import UIKit
import Alamofire

class APIManager {
    
    func getPlanetary(completion: @escaping(_ response:[Any]?, _ message:String?) -> Void) {
        AF.request("https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&count=42", method: .get).responseJSON { response in
            switch response.result {
            case .success(let value):
                if let array = value as? [Any]{
                    print(array)
                    if !array.isEmpty {
                        completion(array, "")
                    } else {
                        completion(nil, "Data not found")
                    }
                } else {
                    completion(nil, "Data not found")
                }
            case .failure(let error):
                print(error)
                completion(nil, "\(error)")
            }
        }
    }
}
