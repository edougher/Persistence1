//
//  ViewController.swift
//  Persistence
//
//  Created by Aaron Dougher on 3/13/18.
//  Copyright © 2018 Erin Dougher. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var lineFields:[UITextField]!

    func dataFileURL() -> NSURL {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        var url:NSURL?
        url = URL(fileURLWithPath: "") as NSURL
        do{
            try url = urls.first!.appendingPathComponent("data.plist") as NSURL
        } catch {
            print ("Error is \(error)")
        }
        return url!
    }

    override func viewDidLoad() {
        super.viewDidLoad()
       let fileURL = self.dataFileURL()
        if (FileManager.default.fileExists(atPath: fileURL.path!)){
            if let array = NSArray(contentsOf:  fileURL as URL) as? [String] {
                for i in 0..<array.count {
                    lineFields[i].text = array[i]
                }
            }
        }
        
        let app = UIApplication.shared
        NotificationCenter.default.addObserver(self, selector: #selector(self.applicationWillResignActive(notification:)), name: Notification.Name.UIApplicationWillResignActive, object: app)
        
    }
    
    @objc func applicationWillResignActive(notification:NSNotification) {
        let fileURL = self.dataFileURL()
        let array = (self.lineFields as NSArray).value(forKey: "text") as! NSArray
        array.write(to: fileURL as URL, atomically: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

