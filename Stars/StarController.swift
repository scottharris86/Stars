//
//  StarController.swift
//  Stars
//
//  Created by scott harris on 1/28/20.
//  Copyright © 2020 scott harris. All rights reserved.
//

import Foundation

// Model Controller - The object that controls the app's interaction with the model object. Model controllers are almost always classes

class StarController {
    
    var stars: [Star] = []
    
    
    init() {
        loadFromPersistentStore()
    }
    
    func createStar(with name: String, distance: Double) {
        let star = Star(name: name, distance: distance)
        stars.append(star)
        
        saveToPersistentStore()
        
    }
    
    // Persistence
    var persistentFileURL: URL? {
        let fileManager = FileManager.default
        // Find the documents directory of the app
        guard let documentsDir = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first else { return nil }
        
        let starsURL = documentsDir.appendingPathComponent("stars.plist")
        
        return starsURL
        
    }
    
    // Model Saving Function
    func saveToPersistentStore() {
        guard let fileURL = persistentFileURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let starsData = try encoder.encode(stars)
            
            try starsData.write(to: fileURL)
            
        } catch {
            print(error)
        }
        
    }
    
    // Model Loading Function
    func loadFromPersistentStore() {
        guard let fileURL = persistentFileURL else { return }
        
        do {
            let starsData = try Data(contentsOf: fileURL)
            let decoder = PropertyListDecoder()
            
            let starsArray = try decoder.decode([Star].self, from: starsData)
            
            stars = starsArray
            
        } catch {
           print(error)
        }
    }
    
}
