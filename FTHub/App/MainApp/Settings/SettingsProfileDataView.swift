//
//  SettingsProfileDataView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 6.09.23.
//

import SwiftUI
import SwiftData
import PhotosUI

struct SettingsProfileDataView: View {
    
    let imageUrl: URL?
    
    @Query private var user: [User]
    
    @State private var saveButtonActive: Bool = false
    
    
    @State private var name: String = "test name"
    @State private var email: String = "kokmarok@gmail.com"
    @State private var gender: Gender = .Male
    @State private var age: Int = 22
    
    @State private var height: Int = 180
    @State private var weight: Int = 72
    @State private var workoutsPerWeek: Int = 3
    @State private var goal: FitnessGoal = .Balance
    
    @State private var initConfiguration: [String] = []
    
    var body: some View {
        NavigationStack {
            ScrollView {
                
                SettingsProfileImagePickerView(imageUrl: imageUrl)
                
                SettingsProfileMainDataView(name: $name, email: $email, gender: $gender, age: $age)
                
                SettingsFitnessDataView(height: $height, weight: $weight, workoutsPerWeek: $workoutsPerWeek, goal: $goal)
                
            }
            .padding()
            .navigationTitle("Profile data")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {} label: {
                    Text("Save")
                        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                }
                .foregroundStyle(saveButtonActive ? .accent : .textGray)
                .fontWeight(.bold)
                .disabled(!saveButtonActive)
            }
        }
        .onAppear {
            if let user = user.first {
                self.name = user.name
                self.email = user.email
                self.gender = user.details?.gender ?? .Male
                self.age = user.details?.age ?? 18
                self.height = user.details?.height ?? 0
                self.weight = user.details?.weight ?? 0
                self.workoutsPerWeek = user.details?.workoutsPerWeek ?? 2
                self.goal = user.details?.goal ?? .Balance
                self.initConfiguration = [name, email, gender.rawValue, String(age), String(height), String(weight), String(workoutsPerWeek), goal.rawValue]
            }
        }
        .onChange(of: [name, email, gender.rawValue, String(age), String(height), String(weight), String(workoutsPerWeek), goal.rawValue], { oldValue, newValue in
            if newValue != initConfiguration {
                saveButtonActive = true
            } else {
                saveButtonActive = false
            }
        })
        .scrollIndicators(.hidden)
    }
}

#Preview {
    SettingsProfileDataView(imageUrl: URL(string: ""))
}
