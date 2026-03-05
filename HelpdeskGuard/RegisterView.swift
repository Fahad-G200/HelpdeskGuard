//
//  RegisterView.swift
//  HelpdeskGuard
//
//  Created by Fahad Adnan Ashraf on 05/03/2026.
//

import SwiftUI

struct RegisterView: View {
    @EnvironmentObject var authStore: AuthStore

    @State private var email: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var errorMessage: String = ""

    var body: some View {
        NavigationStack {
            VStack(spacing: 16) {
                Text("Registrer bruker")
                    .font(.largeTitle)
                    .bold()

                TextField("E-post", text: $email)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .keyboardType(.emailAddress)
                    .textFieldStyle(.roundedBorder)

                SecureField("Passord", text: $password)
                    .textFieldStyle(.roundedBorder)

                SecureField("Gjenta passord", text: $confirmPassword)
                    .textFieldStyle(.roundedBorder)

                if !errorMessage.isEmpty {
                    Text(errorMessage)
                        .foregroundStyle(.red)
                        .font(.callout)
                }

                Button("Opprett konto") {
                    errorMessage = ""

                    if email.isEmpty || password.isEmpty || confirmPassword.isEmpty {
                        errorMessage = "Fyll ut alle feltene."
                        return
                    }

                    if password != confirmPassword {
                        errorMessage = "Passordene er ikke like."
                        return
                    }

                    let ok = authStore.register(email: email, password: password)
                    if ok {
                        // Valgfritt: logg inn direkte etter registrering
                        _ = authStore.login(email: email, password: password)
                    } else {
                        errorMessage = "E-posten er allerede registrert."
                    }
                }
                .buttonStyle(.borderedProminent)

                Spacer()
            }
            .padding()
            .navigationTitle("Registrer")
        }
    }
}

#Preview {
    RegisterView()
        .environmentObject(AuthStore())
}
