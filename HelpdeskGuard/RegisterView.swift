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

                    // Rens e-post (tar bort mellomrom og gjør den lowercase)
                    let cleanEmail = email.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()

                    if cleanEmail.isEmpty || password.isEmpty || confirmPassword.isEmpty {
                        errorMessage = "Fyll ut alle feltene."
                        return
                    }

                    // Enkel e-post-sjekk (ikke perfekt, men bra nok for prosjektet)
                    if !cleanEmail.contains("@") || !cleanEmail.contains(".") {
                        errorMessage = "Skriv en gyldig e-postadresse."
                        return
                    }

                    // Minimum passordlengde
                    if password.count < 6 {
                        errorMessage = "Passordet må være minst 6 tegn."
                        return
                    }

                    if password != confirmPassword {
                        errorMessage = "Passordene er ikke like."
                        return
                    }

                    let ok = authStore.register(email: cleanEmail, password: password)
                    if ok {
                        // Valgfritt: logg inn direkte etter registrering
                        _ = authStore.login(email: cleanEmail, password: password)
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
