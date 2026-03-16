//
//  LoginView.swift
//  HelpdeskGuard
//
//  Created by Fahad Adnan Ashraf on 16/03/2026.
//

import SwiftUI

struct LoginView: View {

    @EnvironmentObject var authStore: AuthStore

    @State private var email = ""
    @State private var password = ""
    @State private var errorMessage = ""

    var body: some View {

        NavigationStack {

            VStack(spacing: 20) {

                Spacer()

                Image(systemName: "lock.shield")
                    .font(.system(size: 60))
                    .foregroundStyle(.blue)

                Text("HelpdeskGuard")
                    .font(.largeTitle)
                    .fontWeight(.bold)

                VStack(spacing: 15) {

                    TextField("E-post", text: $email)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                        .textFieldStyle(.roundedBorder)

                    SecureField("Passord", text: $password)
                        .textFieldStyle(.roundedBorder)

                }
                .padding(.horizontal)

                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundColor(.red)
                }

                Button {

                    let success = authStore.login(email: email, password: password)

                    if !success {
                        errorMessage = "Feil e-post eller passord"
                    }

                } label: {

                    Label("Logg inn", systemImage: "arrow.right.circle.fill")
                        .frame(maxWidth: .infinity)

                }
                .buttonStyle(.borderedProminent)
                .padding(.horizontal)

                NavigationLink {

                    RegisterView()

                } label: {

                    Text("Har du ikke konto? Opprett bruker")

                }

                Spacer()

            }
            .navigationTitle("Logg inn")

        }

    }

}

#Preview {

    LoginView()
        .environmentObject(AuthStore())

}
