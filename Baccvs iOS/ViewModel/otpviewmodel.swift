//
//  otpviewmodel.swift
//  Baccvs iOS
//
//  Created by pm on 01/02/2023.
//
import SwiftUI

class OTPViewModel: ObservableObject {
    @Published var otptext:String=""
    @Published var otpfields:[String]=Array(repeating: "", count: 6)
}

