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
                .font(.title3)
            
            Spacer()
            
            VStack (alignment: .trailing) {
                Text(item.date.formatted(date: .omitted, time: .shortened))
                
                Text(item.date.formatted(date: .abbreviated, time: .omitted))
            }
            .fontWeight(.regular)
            .font(.subheadline)
                
        }
    }
}

#Preview {
    HistoryItemView(item: DetectionHistoryItem(result: "Benign", date: Date()))
}
