//
//  AuthStore.swift
//  HelpdeskGuard
//
//  Holder styr på innloggingsstatus i appen.
//  Passord lagres ALDRI lokalt – autentisering skjer via APIService mot MySQL.
//

import Foundation
import Combine

final class AuthStore: ObservableObject {

    @Published var isLoggedIn: Bool = false
    @Published var currentEmail: String? = nil

    init() {
        // Gjenopprett sesjon hvis gyldig token og e-post finnes fra forrige økt
        if let epost = APIService.shared.lagretEpost,
           APIService.shared.token != nil {
            self.currentEmail = epost
            self.isLoggedIn = true
        }
    }

    /// Kalles etter vellykket innlogging via APIService
    func loggInn(epost: String) {
        currentEmail = epost
        isLoggedIn = true
    }

    /// Logger ut og sletter token
    func loggUt() {
        APIService.shared.loggUt()
        currentEmail = nil
        isLoggedIn = false
    }
}
