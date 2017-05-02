//
//  Manager.swift
//  urban_clap_assignment
//
//   Created by Ashish Mittal  on 01/05/17.
//  Copyright © 2017 Ashish Mittal. All rights reserved.
//

import Foundation

protocol ManagerDelegate{
   
    func commitsFetched(allRes: [User])
    
}

class Manager: Operation, URLSessionDelegate{
    
    
    //MARK: Variables
    var delegate: ManagerDelegate?
    var city: String!
    
    var entityType: String!
    var entityID: String!
    
    //MARK: Main function
    // called when an operation is added to the queue
    override func main() {
        getLocation()
    }

    
    func getLocation(){
        //let urlString = "https://developers.zomato.com/api/v2.1/locations?query="
      //  let urlString1 = "https://api.github.com/repos/rails/rails/issues/comments?access_token=73af87e5d00d78c698a3e8a745ca8d557fb1dc04"
        let urlString1 =  "https://api.github.com/search/commits?q=repo:rails/rails+author:wycats"
        
        //let urlLocal: NSURL = NSURL(string: urlString + self.city)!
        
       // let urlLocal = URL(string: urlString + self.city)
        let urlLocal1 = URL(string: urlString1)

        //var params = ["login":"1951", "pass":"1234"]
        var request = URLRequest(url: urlLocal1!)

        request.httpMethod = "GET"
        request.addValue("application/vnd.github.cloak-preview", forHTTPHeaderField: "Accept")
        //var err: NSError?
        //request.HTTPBody = NSJSONSerialization.dataWithJSONObject(params, options: nil, error: &err)
       //commented
        //request.addValue("c750173e8cf7e5fdc2c331cf897ee8c3", forHTTPHeaderField: "user-key")
        
        var responseData: Data?
        var error1: Error?
        
        //let config = URLSessionConfiguration.default
       
        let session = URLSession.shared
        
        let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            // ...
            
            responseData = data
            error1 = error
            
            self.processLocation(responseData: responseData!)
        })
        task.resume()
        
//        //var myString = NSString(data: responseData, encoding: NSUTF8StringEncoding)
//        
//        var myString = String(responseData, encoding: String.Encoding.utf8)
        
        
        
    }
    
    func processLocation(responseData: Data){
        
//        do {
//            guard let resultDict = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any]
//                else {
//                print("error trying to convert data to JSON")
//                return
//            }
//           print(resultDict)
//        }
////            guard let items: NSArray = resultDict["items"] as? NSArray else{
////                print("error trying to convert data to JSON")
////                return
////            }
////            
////            if(items > 0){
////                if let dict = location_suggestions.object(at: 0) as? [String:Any]{
////            var user = User()
////            user.login =
//        
////                    if let id = dict["entity_id"] as? Int, let type = dict["entity_type"] as? String{
////                        self.entityID = "\(id)"
////                        self.entityType = type
////                    }
////                    
////                    if(self.entityID != nil && self.entityType != nil){
////                        self.getRestaurants()
////                    }
////                }
////            }
////            
////            
////            
////            
//    //    }
//    catch let error as NSError{
//            print(error)
//        }
//        
        do {
            guard let resultDict = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: Any] else {
                print("error trying to convert data to JSON")
                return
            
            }
            print(resultDict)
            
            if let resArray = resultDict["items"] as? Array<[String:Any]>{
                
                var allRes: [User] = []
                
                for arrObj in resArray{
                    let modelObj: User = User()

                    if let dict = arrObj as? [String: Any]{
                        
                        if let score = dict["score"] as! NSNumber?{
                            modelObj.score = score.stringValue
                        }
                        else
                        {
                            modelObj.score = "no score available"
                        }
                        if let commit = dict["commit"] as? [String: Any]
                        {
                            modelObj.message = commit["message"] as! String?
                            
                            if let author1 = commit["author"] as? [String: Any]
                            {
                                
                                modelObj.name = author1 ["name"] as! String?
                                
                            }
                            
                            
                        }
                        if let author = dict["author"] as? [String: Any]{
                            
                            modelObj.avatar_url = author["avatar_url"] as! String?
                            allRes.append(modelObj)
                        }
                    }
                }
                
                self.delegate?.commitsFetched(allRes: allRes)
            }
            
            
        }catch let error as NSError{
            print(error)
        }
        
        
        
        
    }
    
  
 
}
