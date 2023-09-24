//
//  SettingsProfileDataView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 6.09.23.
//

import SwiftUI
import CoreData
import PhotosUI

struct SettingsProfileDataView: View {
    @State private var saveButtonActive: Bool = false
    
    @State private var imageUrl: URL?
    @State private var localProfileImage: UIImage?
    @State private var name: String = "test name"
    @State private var email: String = "youremail@email.com"
    @State private var gender: Gender = .Male
    @State private var age: Int = 22
    @State private var units: Unit = .metric
    
    @State private var height: String = "180"
    @State private var weight: String = "72"
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
     
                SettingsFitnessDataView(height: $height, weight: $weight, workoutsPerWeek: $workoutsPerWeek, goal: $goal, units: $units)
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
        .onAppear(perform: loadData)
        .onChange(of: [name, gender.rawValue, String(age), units.rawValue, String(height), String(weight), String(workoutsPerWeek), goal.rawValue], { oldValue, newValue in
            if newValue != initConfiguration {
                saveButtonActive = true
            } else {
                saveButtonActive = false
            }
        })
        .scrollIndicators(.hidden)
    }
    
    func loadData() {
        DB.shared.performBackgroundTask { backgroundContext in
            let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
            let fetchResult: Result<[User], Error> = DB.shared.makeFetchRequest(request: fetchRequest)
            
            switch fetchResult {
            case .success(let users):
                DB.shared.context.perform {
                    var metricUnits: Bool { return self.units == .metric }
                    self.imageUrl = URL(string: "https://storage.fthub.eu\(users[0].photo ?? "No photo url")")
                    self.name = users[0].name ?? "No name"
                    self.email = users[0].email ?? "No email"
                    self.gender = Gender(rawValue: users[0].userDetails?.gender ?? "Male") ?? .Male
                    self.age = Int(users[0].userDetails?.age ?? 18)
                    self.units = Unit(rawValue: users[0].userDetails?.units ?? "metric") ?? .metric
                    
                    let imperialHeight = Double(users[0].userDetails?.height ?? 0) * K.Units.cmToInch
                    let imperialWeight = Double(users[0].userDetails?.weight ?? 0) * K.Units.kgToLbs
                    
                    #warning("Fix height: api json response")
                    self.height = String(format: "%.\(metricUnits ? 0 : 1)f", metricUnits ? Double(users[0].userDetails?.height ?? 0) : Double(imperialHeight * 10).rounded() / 10)
                    self.weight = String(format: "%.0f", metricUnits ? Double(users[0].userDetails?.weight ?? 0).rounded() : Double(imperialWeight).rounded())
                    
                    
                    self.workoutsPerWeek = Int(users[0].userDetails?.workoutsPerWeek ?? 2)
                    self.goal = FitnessGoal(rawValue: users[0].userDetails?.goal ?? "Balance") ?? .Balance
                    self.initConfiguration = [name, gender.rawValue, String(age), units.rawValue, String(height), String(weight), String(workoutsPerWeek), goal.rawValue]
                }
            case .failure(let error):
                print("Error loading user details from background thread: \(error.localizedDescription)")
            }
        }
        
    }
    
    func saveDetails() {
        DB.shared.performBackgroundTask { backgroundContext in
            let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
            let fetchResult: Result<[User], Error> = DB.shared.makeFetchRequest(request: fetchRequest)
            
            switch fetchResult {
            case .success(let users):
                Task {
                    var metricUnits: Bool { return self.units == .metric }
                    let metricHeight: String = metricUnits ? String(Double(self.height)!) : String(format: "%.2f", (Double(self.height)! / K.Units.cmToInch))
                    let metricWeight: String = metricUnits ? String(Int(self.weight)!) : String(format: "%.0f", (Double(self.weight)! / K.Units.kgToLbs))
                    
                    await SettingsProfileDataController.saveUserDetails(gender: self.gender, age: self.age, height: Double(metricHeight) ?? 0, weight: Int(metricWeight) ?? 0, workoutsPerWeek: self.workoutsPerWeek, units: self.units, goal: self.goal) { response in
                        if response != nil {
                            users[0].userDetails?.gender = self.gender.rawValue
                            users[0].userDetails?.age = Int16(self.age)
                            users[0].userDetails?.units = self.units.rawValue
                               
                            users[0].userDetails?.height = Double(metricHeight) ?? 0
                            users[0].userDetails?.weight = Double(metricWeight) ?? 0
                            
                            let imperialHeight = Double(metricHeight) ?? 0 * K.Units.cmToInch
                            let imperialWeight = Double(metricWeight) ?? 0 * K.Units.kgToLbs
                            self.height = String(format: "%.\(metricUnits ? 0 : 1)f", metricUnits ? Double(metricHeight) ?? 0 : Double(imperialHeight * 10).rounded() / 10)
                            self.weight = String(format: "%.0f", metricUnits ? Double(metricWeight) ?? 0 : Double(imperialWeight.rounded()))
                            
                            users[0].userDetails?.workoutsPerWeek = Int16(self.workoutsPerWeek)
                            users[0].userDetails?.goal = self.goal.rawValue
                            if localProfileImage != nil || self.name != self.initConfiguration[0] {
                                await SettingsProfileDataController.sendFormData(name: self.name, image: localProfileImage) { response in
                                    users[0].name = response.data.user.name
                                    users[0].photo = response.data.user.photo
                                }
                            }
                            DB.shared.saveContext()
                            
                            self.initConfiguration = [name, gender.rawValue, String(age), units.rawValue, String(height), String(weight), String(workoutsPerWeek), goal.rawValue]
                            Message.send(type: "success", message: "Successfully saved profile data")
                            saveButtonActive = false
                        }
                    }
                }
            case .failure(let error):
                print("Error loading user details from background thread: \(error.localizedDescription)")
            }
        }
        
        
    }
    
}

#Preview {
    SettingsProfileDataView()
}
