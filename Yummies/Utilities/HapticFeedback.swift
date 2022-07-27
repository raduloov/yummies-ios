//
//  HapticFeedback.swift
//  Yummies
//
//  Created by Yavor Radulov on 28.07.22.
//

import UIKit

class HapticFeedback: ObservableObject {
    
    func trigger(intensity: UIImpactFeedbackGenerator.FeedbackStyle) {
        
        let hapticFeedback = UIImpactFeedbackGenerator(style: intensity)
        
        hapticFeedback.impactOccurred()
    }
}
