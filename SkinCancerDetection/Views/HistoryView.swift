//
//  HistoryView.swift
//  SkinCancerDetection
//
//  Created by Hitesh Rupani on 22/10/24.
//

import SwiftUI

struct HistoryView: View {
    
    @ObservedObject var vm: ViewModel
    
    var body: some View {
        VStack(alignment: .center) {
            Text ("History")
                .font(.largeTitle)
                .bold()
                .foregroundStyle(Color(.label))
                .padding()
                .padding(.top)
            
            HStack {
                Text("Result")
                Spacer()
                Text("Recorded Time")
                    .frame(width: UIScreen.main.bounds.width / 2.6, alignment: .trailing)
            }
            .font(.subheadline)
            .foregroundStyle(Color.gray)
            .padding(.horizontal)
            
            List {
                ForEach (vm.detectionHistory) {item in
                    HistoryItemView(item: item)
                }
            }
            .listStyle(.plain)
        }
    }
}

#Preview {
    HistoryView(vm: ViewModel())
}
