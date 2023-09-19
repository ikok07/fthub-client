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
    
    @Environment(\.managedObjectContext) private var context
    @FetchRequest(sortDescriptors: []) var user: FetchedResults<User>
    
    @State private var saveButtonActive: Bool = false
    
    @State private var imageUrl: URL?
    @State private var localProfileImage: UIImage?
    @State private var name: String = "test name"
    @State private var email: String = "youremail@email.com"
    @State private var gender: Gender = .Male
    @State private var age: Int = 22
    @State private var units: Unit = .metric
    
    @State private var height: Int = 180
    @State private var weight: Int = 72
    @State private var workoutsPerWeek: Int = 3
    @State private var goal: FitnessGoal = .Balance
    
    @State private var initConfiguration: [String] = []
    
    var body: some View {
        NavigationStack {
            ScrollView {
                SettingsProfileImagePickerView(imageUrl: $imageUrl, saveButtonActive: $saveButtonActive, uiImage: $localProfileImage)
                
                SettingsProfileMainDataView(name: $name, email: email, gender: $gender, age: $age, units: $units)
                    .padding()
                    .padding(.bottom)
                
                SettingsFitnessDataView(height: $height, weight: $weight, workoutsPerWeek: $workoutsPerWeek, goal: $goal)
                    .padding()
                
            }
            .navigationTitle("Profile data")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {
                    saveDetails()
                } label: {
                    Text("Save")
                        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                }
                .foregroundStyle(saveButtonActive ? .accent : .textGray)
                .fontWeight(.bold)
                .disabled(!saveButtonActive)
            }
        }
        .onAppear {
            self.imageUrl = URL(string: "https://storage.fthub.eu\(user[0].photo ?? "No photo url")")
            self.name = user[0].name ?? "No name"
            self.email = user[0].email ?? "No email"
            self.gender = Gender(rawValue: user[0].userDetails?.gender ?? "Male") ?? .Male
            self.age = Int(user[0].userDetails?.age ?? 18)
            self.units = Unit(rawValue: user[0].userDetails?.units ?? "metric") ?? .metric
            self.height = Int(user[0].userDetails?.height ?? 0)
            self.weight = Int(user[0].userDetails?.weight ?? 0)
            self.workoutsPerWeek = Int(user[0].userDetails?.workoutsPerWeek ?? 2)
            self.goal = FitnessGoal(rawValue: user[0].userDetails?.goal ?? "Balance") ?? .Balance
            self.initConfiguration = [name, gender.rawValue, String(age), units.rawValue, String(height), String(weight), String(workoutsPerWeek), goal.rawValue]
        }
        .onChange(of: [name, gender.rawValue, String(age), units.rawValue, String(height), String(weight), String(workoutsPerWeek), goal.rawValue], { oldValue, newValue in
            if newValue != initConfiguration {
                saveButtonActive = true
            } else {
                saveButtonActive = false
            }
        })
        .scrollIndicators(.hidden)
    }
    
    
    func saveDetails() {
        Task {
            await SettingsProfileDataController.saveUserDetails(gender: self.gender, age: self.age, height: self.height, weight: self.weight, workoutsPerWeek: self.workoutsPerWeek, units: self.units, goal: self.goal) { response in
                if response != nil {
                    
                    user[0].userDetails?.gender = self.gender.rawValue
                    user[0].userDetails?.age = Int16(self.age)
                    user[0].userDetails?.units = self.units.rawValue
                    user[0].userDetails?.height = Int16(self.height)
                    user[0].userDetails?.weight = Int16(self.weight)
                    user[0].userDetails?.workoutsPerWeek = Int16(self.workoutsPerWeek)
                    user[0].userDetails?.goal = self.goal.rawValue
                    
                    if localProfileImage != nil || self.name != self.initConfiguration[0] {
                        await SettingsProfileDataController.sendFormData(name: self.name, image: localProfileImage) { response in
                            user[0].name = response.data.user.name
                            user[0].photo = response.data.user.photo
                        }
                    }
                    
                    self.initConfiguration = [name, gender.rawValue, String(age), units.rawValue, String(height), String(weight), String(workoutsPerWeek), goal.rawValue]
                    Message.send(type: "success", message: "Successfully saved profile data")
                    
                    saveButtonActive = false
                }
            }
        }
    }
    
}

#Preview {
    SettingsProfileDataView()
}
