//
//  MKPointAnnotation-ObservableObject.swift
//  BucketList
//
//  Created by Benjamin Keys on 9/27/20.
//

import MapKit

extension MKPointAnnotation: ObservableObject {
    public var titleWrapped: String {
        get {
            return self.title ?? "Unknown Value"
        }
        set {
            title = newValue
        }
    }
    
    public var subtitleWrapped: String {
        get {
            return self.subtitle ?? "Unknown Value"
        }
        set {
            title = subtitle
        }
    }
}
