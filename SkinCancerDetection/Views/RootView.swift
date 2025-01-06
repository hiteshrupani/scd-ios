//
//  ContentView.swift
//  SkinCancerDetection
//
//  Created by Hitesh Rupani on 13/10/24.
//

import SwiftUI
import PhotosUI

struct RootView: View {
    
    @StateObject var vm = ViewModel()
    
    var body: some View {
        TabView {
            DashboardView(vm: vm)
                .tabItem {
                    Image(systemName: "viewfinder")
                    Text("Detect")
                }
            
            HistoryView(vm: vm)
                .tabItem {
                    Image(systemName: "clock")
                    Text("History")
                }
        }
        .accentColor(Color(.label))
        
    }
}

#Preview {
    RootView()
}
