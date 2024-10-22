//
//  HistoryItemView.swift
//  SkinCancerDetection
//
//  Created by Hitesh Rupani on 22/10/24.
//

import SwiftUI

struct HistoryItemView: View {
    
    var item: DetectionHistoryItem
    
    var body: some View {
        HStack {
            Text(item.result.capitalized)
                .bold()
            
            Spacer()
            
            Text(item.date.formatted(.dateTime))
                .fontWeight(.light)
                
        }
    }
}

#Preview {
    HistoryItemView(item: DetectionHistoryItem(result: "Benign", date: Date()))
}
