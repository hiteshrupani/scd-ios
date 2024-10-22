//
//  ContentView.swift
//  SkinCancerDetection
//
//  Created by Hitesh Rupani on 13/10/24.
//

import SwiftUI
import PhotosUI

struct DashboardView: View {
    
    @StateObject private var vm = ViewModel()
    @State private var photosPickerItem: PhotosPickerItem?
    
    @State private var width100 = UIScreen.main.bounds.width
    @State private var width80 = UIScreen.main.bounds.width * 0.8
    
    var body: some View {
        ZStack {
            
            VStack {
                // MARK: - Header
                Text("Upload image to \ndetect skin cancer..")
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(Color(.label))
                    .padding()
                    .padding(.top)
                
                Spacer()
                
                // MARK: - Detect Button
                Button {
                    vm.detect(vm.image!) { result in
                        DispatchQueue.main.async {
                            vm.result = result
                        }
                    }
                    
                } label: {
                    VStack {
                        Text("\(Image(systemName: "magnifyingglass")) Start Detection")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                    }
                    .foregroundStyle(Color(.systemBackground))
                    .padding()
                    .background {
                        Capsule()
                            .frame(width: UIScreen.main.bounds.width * 0.8)
                    }
                }
                .disabled(vm.image == nil)
                .padding()
            }
            
            // MARK: - Upload Image
            PhotosPicker(selection: $photosPickerItem, matching: .images) {
                ZStack {
                    // Check if the image exists
                    if let image = vm.image {
                        VStack {
                            Image(uiImage: image)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: width80, height: width80)
                                .clipShape(RoundedRectangle(cornerRadius: 17))
                                .padding( )
                            
                            if let result = vm.result {
                                VStack {
                                    Text ("Result")
                                        .font(.title2)
                                        .fontWeight(.light)
                                        .foregroundStyle(Color(.label))
                                    
                                    Text (result.capitalized)
                                        .font(.largeTitle)
                                        .fontWeight(.bold)
                                        .foregroundStyle(Color(.label))
                                }
                            }
                        }
                        .frame(width: width80, height: width100)
                        
                    } else {
                        // Placeholder
                        ZStack {
                            Color(.systemGray3)
                                .aspectRatio(1, contentMode: .fill)
                            
                            Image(systemName: "plus")
                                .resizable()
                                .foregroundStyle(.white)
                                .aspectRatio(contentMode: .fit)
                                .frame(width: UIScreen.main.bounds.width * 0.3)
                                .padding()
                        }
                        .frame(width: width80, height: width80)
                        .clipShape(RoundedRectangle(cornerRadius: 17))
                    }
                }
                
            }
        }
        .accentColor(Color(.label))
        .onChange(of: photosPickerItem) { _, _ in
            Task {
                if let photosPickerItem,
                   let data = try? await photosPickerItem.loadTransferable(type: Data.self) {
                    if let image = UIImage(data: data) {
                        vm.image = image
                        vm.result = nil
                    }
                }
                photosPickerItem = nil
            }
        }
    }
}

#Preview {
    DashboardView()
}
