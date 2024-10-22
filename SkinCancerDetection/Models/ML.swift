//
//  ML.swift
//  SkinCancerDetection
//
//  Created by Hitesh Rupani on 22/10/24.
//

import Foundation

struct DetectionHistoryItem: Identifiable {
    let id = UUID()
    
    var result: String
    var date: Date
}
