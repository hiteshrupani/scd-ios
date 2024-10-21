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
    
    var body: some View {
        ZStack {
//            Color(.label)
//                .ignoresSafeArea()
            
            VStack {
                Text("Upload image to \ndetect skin cancer..")
                    .font(.largeTitle)
                    .bold()
                    .foregroundStyle(Color(.label))
                    .padding()
                    .padding(.top)
                
                Spacer()
                
                // MARK: - Detect Button
                Button {
                    
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
                            .frame(width: UIScreen.main.bounds.width * 0.75)
                    }
                }
                .disabled(vm.image == nil)
                .padding()
            }
            
            // MARK: - Upload Image
            PhotosPicker(selection: $photosPickerItem, matching: .images) {
                ZStack {
                    Image(uiImage: (vm.image) ?? UIImage(named: "Placeholder")!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.width * 0.8)
                        .clipShape(RoundedRectangle(cornerRadius: 17))
                        .padding()
                    
                    if vm.image == nil {
                        VStack {
                            Spacer()
                            
                            HStack {
                                Spacer()
                                
                                Image(systemName: "plus.circle.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 75)
                                    .imageScale(.large)
                                    .foregroundStyle(Color(.label))
                                    .zIndex(2.0)
                            }
                        }
                    }
                }
                .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.width * 0.9)
            }
            
        }
        .accentColor(Color(.label))
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
    DashboardView()
}
