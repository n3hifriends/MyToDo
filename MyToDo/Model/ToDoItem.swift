//
//  ToDoItem.swift
//  MyToDo
//
//  Created by Nitin Kalokhe on 17/06/23.
//

import Foundation

struct ToDoItem {
    let title: String?
    let itemDescription: String?
    let timestamp: Double?
    let location: Location?
    
    private let titleKey = "titleKey"
    private let itemDescriptionKey = "itemDescriptionKey"
    private let timestampKey = "timestampKey"
    private let locationKey = "locationKey"
    
    var plistDict : [String:Any] {
        var dict = [String:Any]()
        
        dict[titleKey] = title
        
        if let itemDescription = itemDescription {
            dict[itemDescriptionKey] = itemDescription
        }
        
        if let timestamp = timestamp {
            dict[timestampKey] = timestamp
        }
        
        if let location = location {
            let locationDict = location.plistDict
            dict[locationKey] = locationDict
        }
        
        return dict
    }
    
    init(title: String?, itemDescription: String? = nil, timestamp: Double? = nil, location: Location? = nil) {
        self.title = title
        self.itemDescription = itemDescription
        self.timestamp = timestamp
        self.location = location
    }
    
    init?(dict:[String:Any]) {
        guard let title = dict[titleKey] as? String else {
            return nil
        }
        self.title = title
        self.itemDescription = dict[itemDescriptionKey] as? String
        self.timestamp = dict[timestampKey] as? Double
        if let locationRef = dict[locationKey] as? [String:Any]{
            self.location = Location(dict: locationRef)
        }else{
            self.location = nil
        }
    }
}

extension ToDoItem:Equatable {
    static func ==(lhs: ToDoItem, rhs: ToDoItem) -> Bool {
        return lhs.title == rhs.title && lhs.location?.name == rhs.location?.name
    }
}
