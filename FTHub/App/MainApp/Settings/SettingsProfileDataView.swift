//
//  SettingsProfileDataView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 6.09.23.
//

import SwiftUI
import SwiftData

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
    
    var body: some View {
        NavigationStack {
            ScrollView {
                
                ProfileImageView(imageUrl: imageUrl, width: 100)
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
                
                SettingsGroupView(name: "Main Data") {
                    VStack(alignment: .leading, spacing: 0) {
                        SettingsInputRowView(name: "Name") {
                            TextField("", text: $name)
                            .frame(width: 200)
                            .multilineTextAlignment(.trailing)
                        }
                        SettingsInputRowView(name: "Email") {
                            TextField("", text: $email)
                            .frame(width: 200)
                            .padding(EdgeInsets(top: 5, leading: 5, bottom: 5, trailing: 5))
                            .multilineTextAlignment(.trailing)
                            .clipShape(RoundedRectangle(cornerRadius: 7))
                        }
                        SettingsInputRowView(name: "Gender") {
                            Picker("", selection: $gender) {
                                Text("Male")
                                    .tag(Gender.Male)
                                Text("Female")
                                    .tag(Gender.Female)
                            }
                            .tint(.text)
                        }
                        SettingsInputRowView(name: "Age") {
                            Picker("", selection: $age) {
                                ForEach(16...70, id: \.self) { i in
                                    Text("\(i)")
                                        .font(.body)
                                        .fontWeight(.medium)
                                }
                            }
                            .tint(.text)
                        }
                    }
                }
                
                SettingsGroupView(name: "Fitness Data") {
                    SettingsInputRowView(name: "Height") {
                        Picker("", selection: $height) {
                            ForEach(120...220, id: \.self) { i in
                                if let user = user.first {
                                    Text(user.details?.units == .metric ? "\(i) cm" : "\(String(format: "%.2f", Double(i) * 0.3937)) inch")
                                        .font(.body)
                                        .fontWeight(.medium)
                                }
                            }
                        }
                        .tint(.text)
                    }
                    SettingsInputRowView(name: "Weight") {
                        Picker("", selection: $weight) {
                            ForEach(40...180, id: \.self) { i in
                                if let user = user.first {
                                    Text(user.details?.units == .metric ? "\(i) kg" : "\(String(format: "%.2f", Double(i) * 2.2046226218488)) lbs")
                                        .font(.body)
                                        .fontWeight(.medium)
                                }
                            }
                        }
                        .tint(.text)
                    }
                    SettingsInputRowView(name: "Workouts") {
                        Picker("", selection: $workoutsPerWeek) {
                            ForEach(2...7, id: \.self) { i in
                                Text("\(i) times/week")
                                    .font(.body)
                                    .fontWeight(.medium)
                                    .tag(i)
                            }
                        }
                        .tint(.text)
                    }
                    SettingsInputRowView(name: "Goal") {
                        Picker("", selection: $goal) {
                            Text("\(FitnessGoal.WeightLoss.rawValue)".camelCaseToWords())
                                .tag(FitnessGoal.WeightLoss)
                            Text("\(FitnessGoal.Balance.rawValue)")
                                .tag(FitnessGoal.Balance)
                            Text("\(FitnessGoal.MuscleBuilding.rawValue)".camelCaseToWords())
                                .tag(FitnessGoal.MuscleBuilding)
                        }
                        .tint(.text)
                    }
                }
                
            }
            .padding()
            .navigationTitle("Profile data")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button {} label: {
                    Text("Save")
                        .padding(EdgeInsets(top: 5, leading: 10, bottom: 5, trailing: 10))
                }
                .buttonStyle(CTAButtonStyle(gradient: saveButtonActive ? K.Gradients.mainGradient : K.Gradients.grayGradient, opacity: 0.5))
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
            }
        }
    }
}

#Preview {
    SettingsProfileDataView(imageUrl: URL(string: "https://images.pexels.com/photos/1656684/pexels-photo-1656684.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1"))
}
