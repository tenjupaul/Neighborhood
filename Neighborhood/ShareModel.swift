//
//  ShareModel.swift
//  Neighborhood
//
//  Created by Kim Vy Vo on 9/26/18.
//  Copyright © 2018 Tiange Wang. All rights reserved.
//

import Foundation

class ShareModel {
    static func getAllShares(completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        let url = URL(string: "http://localhost:8000/shares")
        let session = URLSession.shared
        let share = session.dataTask(with: url!, completionHandler: completionHandler)
        share.resume()
    }
    static func addNewShare(newShare: [String:Any], completionHandler: @escaping(_ data: Data?, _ response: URLResponse?, _ error: Error?) -> Void) {
        if let urlToReq = URL(string: "http://localhost:8000/shares") {
            var request = URLRequest(url: urlToReq)
            request.httpMethod = "POST"
            if (newShare["lender"] as! String).count == 0 {
                let bodyData = ["item": newShare["item"]!,
                                "isAvailable": newShare["isAvailable"]!,
                                "isLending": newShare["isLending"]!,
                                "description": newShare["description"]!,
                                "borrower": newShare["borrower"]!
                ]
                print("from ShareModel:", bodyData)
                do {
                    request.httpBody = try JSONSerialization.data(withJSONObject: bodyData)
                } catch {
                    print("error in ShareModel, addNewShare().")
                }
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.setValue("application/json", forHTTPHeaderField: "Accept")
                let session = URLSession.shared
                let share = session.dataTask(with: request as URLRequest, completionHandler: completionHandler)
                share.resume()
            } else if (newShare["borrower"] as! String).count == 0{
                let bodyData = ["item": newShare["item"]!,
                                "isAvailable": newShare["isAvailable"]!,
                                "isLending": newShare["isLending"]!,
                                "description": newShare["description"]!,
                                "lender": newShare["lender"]!
                ]
                print("from ShareModel:", bodyData)
                do {
                    request.httpBody = try JSONSerialization.data(withJSONObject: bodyData)
                } catch {
                    print("error in ShareModel, addNewShare().")
                }
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.setValue("application/json", forHTTPHeaderField: "Accept")
                let session = URLSession.shared
                let share = session.dataTask(with: request as URLRequest, completionHandler: completionHandler)
                share.resume()
            }
        }
    }
}