//
//  ContentView.swift
//  SkinCancerDetection
//
//  Created by Hitesh Rupani on 13/10/24.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    
    @StateObject private var vm = ViewModel()
    @State private var photosPickerItem: PhotosPickerItem?
    
    var body: some View {
        VStack {
            // MARK: - Image
            Image(uiImage: (vm.image) ?? UIImage(named: "Placeholder")!)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.width * 0.8)
                .clipShape(RoundedRectangle(cornerRadius: 17))
                .padding()
            
            HStack {
                // MARK: - Upload Image Button
                PhotosPicker(selection: $photosPickerItem, matching: .images) {
                    VStack {
                        Image(systemName: "photo.badge.plus")
                            .imageScale(.large)
                            .padding(.bottom)
                        Text("Upload Image")
                            .font(.subheadline)
                            
                    }
                    .foregroundStyle(Color.white)
                    .frame(width: UIScreen.main.bounds.width * 0.375, height: UIScreen.main.bounds.width * 0.35)
                    .background {
                        RoundedRectangle(cornerRadius: 17)
                    }
                }
                
                Spacer()
                
                // MARK: - Detect Button
                Button {
                    
                } label: {
                    VStack {
                        Image(systemName: "magnifyingglass")
                            .imageScale(.large)
                            .padding(.bottom)
                        Text("Detect")
                            .font(.subheadline)
                            
                    }
                    .foregroundStyle(Color.white)
                    .frame(width: UIScreen.main.bounds.width * 0.375, height: UIScreen.main.bounds.width * 0.35)
                    .background {
                        RoundedRectangle(cornerRadius: 17)
                    }
                }
                .disabled(vm.image == nil)
                
            }
            .frame(width: UIScreen.main.bounds.width * 0.8)
        }
        .padding()
        .onChange(of: photosPickerItem) { _, _ in
            Task {
                if let photosPickerItem,
                   let data = try? await photosPickerItem.loadTransferable(type: Data.self) {
                    if let image = UIImage(data: data) {
                        vm.image = image
                    }
                }
                photosPickerItem = nil
            }
        }
    }
}

#Preview {
    ContentView()
}
