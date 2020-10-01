//
//  ContentView.swift
//  BucketList
//
//  Created by Benjamin Keys on 9/25/20.
//

import LocalAuthentication
import SwiftUI
import MapKit

struct ContentView: View {
    @Environment(\.openURL) var openURL

    @State private var locations = [CodableMKPointAnnotation]()
    @State private var isUnlocked = false
    
    @State private var authentificationfailure = false
    @State private var failureMessage = ""
        
    var body: some View {
        if isUnlocked {
            MainView(locations: $locations)
        } else {
            Button("Unlock Places") {
                self.authenticate()
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .clipShape(Capsule())
            
            .alert(isPresented: $authentificationfailure) {
                Alert(title: Text("Uh oh!"), message: Text(failureMessage), primaryButton: .default(Text("Settings"), action: {
                    UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!)
                }), secondaryButton: .default(Text("Cancel")))
            }
        }
    }
    
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need to unlock you data."
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticationError in
                DispatchQueue.main.async {
                    if success {
                        self.isUnlocked = true
                    } else {
//                        print(authenticationError?.localizedDescription ?? "Failed to authenticate")
                    }
                }
            }
        } else {
            if error?.localizedDescription == "User has denied the use of biometry for this app." {
                switch context.biometryType {
                case .faceID:
                    failureMessage = "BucketList requires access to FaceID."
                case .touchID:
                    failureMessage = "BucketList requires access to TouchID."
                case .none:
                    fatalError("Deviced doesn't contain biometrics.")
                @unknown default:
                    fatalError("Unknown biometrics error")
                }
                authentificationfailure = true
            } else if error?.localizedDescription == "No identities are enrolled." {
                print("Please enroll identities")
            } else {
                print(error ?? "Unknow Error")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
