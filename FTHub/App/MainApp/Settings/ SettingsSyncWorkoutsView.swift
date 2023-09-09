//
//   SettingsSyncWorkoutsView.swift
//  FTHub
//
//  Created by Kaloyan Petkov on 9.09.23.
//

import SwiftUI

struct _SettingsSyncWorkoutsView: View {
    
    @AppStorage("buttonLoading") private var buttonLoading: Bool = false
    
    @State private var notSyncedWorkouts: Int = 0
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Image("sync")
                    .resizable()
                    .scaledToFit()
                
                VStack(spacing: 10) {
                    Text("Sync with Cloud")
                        .font(.title)
                        .fontWeight(.bold)
                    Text("In order to make sure your workouts are always in sync with our server, we recommend periodic checking for unsynced workouts.")
                        .foregroundStyle(.textGray)
                        .multilineTextAlignment(.center)
                        .font(.subheadline)
                        .fontWeight(.bold)
                }
                
                Spacer()
                
                VStack {
                    
                    HStack(alignment: .center, spacing: 3) {
                        Text("Workouts not synced:")
                            .foregroundStyle(notSyncedWorkouts > 0 ? .customRed2.opacity(0.7) : .accent)
                            .font(.subheadline)
                            .fontWeight(.bold)
                        Text("\(notSyncedWorkouts)")
                            .foregroundStyle(notSyncedWorkouts > 0 ? .customRed2.opacity(0.7) : .accent)
                            .font(.subheadline)
                            .fontWeight(.bold)
                    }
                    
                    Button(action: synchronize, label: {
                        if buttonLoading {
                            ProgressView()
                                .progressViewStyle(.circular)
                                .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                        } else {
                            Text("Sync")
                                .padding(EdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0))
                        }
                    })
                    .buttonStyle(CTAButtonStyle(gradient: buttonLoading ? K.Gradients.grayGradient : K.Gradients.mainGradient))
                    .animation(.easeInOut(duration: 0.3), value: buttonLoading)
                }
            }
            .navigationTitle("Sync Workouts")
            .navigationBarTitleDisplayMode(.inline)
            .padding(.horizontal)
        }
    }
    
    func synchronize() {
        buttonLoading = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            buttonLoading = false
        }
    }
}

#Preview {
    _SettingsSyncWorkoutsView()
}
