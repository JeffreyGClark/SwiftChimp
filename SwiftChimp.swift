//
//  SwiftChimp.swift
//
//  Created by Jeffrey Clark (Twitter: @jeffrey_g_clark on 4/7/15.)
//

import Foundation

class SwiftChimp: NSObject {
    
    /*
    * A simple class to add mailchimp subscribers.
    *
    * To use, just call:
    * let helper = SwiftChimp()
    * helper.subscribe(validatedEmailAddress)
    */
    
    private let mailChimpAPIKey = ""
    private let mailChimpListID = ""
    private let url: NSURL = NSURL(string: "https://" + ""/* <-- insert datacenterID e.g. us10 (last digits in your API Key) */ + ".api.mailchimp.com/2.0/lists/subscribe")!
    
    var subscriberDict: [String:AnyObject] = ["apikey" : ""]
    var emailDict: [String:String] = ["email": ""]
    
    func subscribe(email: String) {
        initializeSubscriberDict(email)
        var serializedJSON = NSJSONSerialization.dataWithJSONObject(subscriberDict, options: NSJSONWritingOptions(0), error: NSErrorPointer())
        postToMailChimp(serializedJSON)
    }
    
    func initializeSubscriberDict(email: String) {
        subscriberDict["apikey"] = mailChimpAPIKey
        subscriberDict["id"] = mailChimpListID
        emailDict["email"] = email
        subscriberDict["email"] = emailDict
    }
    
    func postToMailChimp(json: NSData?) {
        let request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "Post"
        request.HTTPBody = json
        
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            data, response, error in self
            
            if error != nil { println("error=\(error)"); return }
            println("response= \(response!)")
            let responseString = NSString(data: data, encoding: NSUTF8StringEncoding)
            println("responseString = \(responseString!)")
        }
        
        task.resume()
    }
}
