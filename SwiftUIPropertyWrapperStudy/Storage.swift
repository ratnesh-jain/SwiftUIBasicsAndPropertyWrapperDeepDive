//
//  Storage.swift
//  SwiftUIPropertyWrapperStudy
//
//  Created by Ratnesh Jain on 03/08/24.
//

import Foundation
import SwiftUI

@propertyWrapper
struct Storage<T>: DynamicProperty {
    let internalStorage: InternalStorage
    
    init(wrappedValue: T, key: String) {
        self.internalStorage = .init(key: key, defaultValue: wrappedValue)
    }
    
    var wrappedValue: T {
        get {
            internalStorage.value()
        }
        nonmutating set {
            internalStorage.setValue(newValue)
        }
    }
    
    var projectedValue: Binding<T> {
        Binding {
            self.wrappedValue
        } set: { newValue in
            self.wrappedValue = newValue
        }
    }
    
    @Observable
    class InternalStorage {
        
        let key: String
        let defaultValue: T
        private var changed: Bool = false
        
        init(key: String, defaultValue: T) {
            self.key = key
            self.defaultValue = defaultValue
        }
        
        func value() -> T {
            _ = changed
            return UserDefaults.standard.value(forKey: key) as? T ?? defaultValue
        }
        
        func setValue(_ newValue: T) {
            UserDefaults.standard.setValue(newValue, forKey: key)
            self.changed.toggle()
        }
    }
}
