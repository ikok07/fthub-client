//
//  SettingsProfileImagePicker.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 7.09.23.
//

import SwiftUI
import PhotosUI

struct SettingsProfileImagePickerView: View {
    
    @State private var profileImageItem: PhotosPickerItem?
    @State private var profileImage: Image?
    
    @Binding var imageUrl: URL?
    @Binding var saveButtonActive: Bool
    @Binding var uiImage: UIImage? {
        didSet {
            print("NEW IMAGE ADDED")
            imageUrl = nil
            saveButtonActive = true
        }
    }
    
    var body: some View {
        PhotosPicker(selection: $profileImageItem, matching: .images) {
            ProfileImageView(imageUrl: imageUrl, localImage: profileImage, width: 100)
                .overlay {
                    Image(systemName: "camera.fill")
                        .foregroundStyle(.white)
                        .font(.body)
                        .padding(EdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10))
                        .background(K.Gradients.mainGradient)
                        .clipShape(Circle())
                        .overlay {
                            Circle()
                                .strokeBorder(Color(UIColor.systemBackground) , lineWidth: 3)
                        }
                        .offset(x: 30, y: 40)
                }
        }
        .onChange(of: profileImageItem) { oldValue, newValue in
            Task {
                if let data = try? await profileImageItem?.loadTransferable(type: Data.self) {
                    if let uiImage = UIImage(data: data) {
                        self.uiImage = uiImage
                        withAnimation {
                            profileImage = Image(uiImage: uiImage)
                        }
                        return
                    }
                }
                print("Failed changing profile picture")
            }
        }
    }
}

#Preview {
    SettingsProfileImagePickerView(imageUrl: .constant(URL(string: "")), saveButtonActive: .constant(false), uiImage: .constant(nil))
}
