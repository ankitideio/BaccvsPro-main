//
//  Colors&Fonts.swift
//  Baccvs iOS

//  Created by pm on 31/01/2023.


import Foundation
import SwiftUI

     let  TextFieldHeight   = 56.0

extension Color{
    static let    blackBackground          =   Color("blackBackground")
    static let    primaryColor             =   Color("primaryColor")
    static let    secondaryColor           =   Color("SecondaryColor")
    static let    lineColor                =   Color("lineColor")
    static let    pentagonColor            =   Color("pentagonColor")
    static let    bg1                      =   Color("bg1")
    static let    bg2                      =   Color("bg2")
    static let    btnColor1                =   Color("btnColor1")
    static let    btnColor2                =   Color("btnColor2")
    static let    lightTextColor           =   Color("lightTextColor")
    static let    textfieldColor           =   Color("textfieldColor")
    static let    textfiledPlacedHolder    =   Color("textfiledPlacedHolder")
    static let    backgroundColor          =   Color("backgroundColor")
    static let    btnTextColor             =   Color("btnTextColor")
    static let    btnColorbg               =   Color("btnColorbg")
    static let    pbFillColor              =   Color("pbFillColor")
    static let    pbEmptyColor             =   Color("pbEmptyColor")
    static let    sidebarbg                =   Color("sidebarbg")
    static let    searchbg                 =   Color("searchbg")
    static let    btnBackground            =   Color("btnBackground")
    static let    secondarytextColor       =   Color("secondarytextColor")
    static let    segmentbackground        =   Color("segmentbackground")
    static let    secondarytab             =   Color("secondarytab")
    static let    tabBarbg                 =   Color("tabBarbg")
    static let    ChatTextFieldColor       =   Color("ChatTextFieldColor")
    static let    btnEventColor            =   Color("btnEventColor")
    static let    descrptionText           =   Color("descrptionText")
    static let    lightColor               =   Color("lightColor")
    static let    detailbg                 =   Color("detailbg")
    static let    blurbtn                  =   Color("blurbtn")
    static let    tabBarColor              =   Color("tabBarColor")
    static let    bgcolor                  =   Color("bgcolor")
    static let    activestroke             =   Color("activestroke")

    
    
}
extension Font{
    static var  Bold14: Font              {Font.custom("Poppins-Bold", size:14)}
    static var  Bold8: Font               {Font.custom("Poppins-Bold", size: 8)}
    static var  Bold16: Font              {Font.custom("Poppins-Bold", size: 16)}
    static var  Bold18: Font              {Font.custom("Poppins-Bold", size: 18)}
    static var  Medium32: Font            {Font.custom("Poppins-Bold", size: 32)}
    static var  SemiBold16: Font          {Font.custom("Poppins-SemiBold", size: 16)}
    static var  SemiBold14: Font          {Font.custom("Poppins-SemiBold", size: 14)}
    static var  SemiBold17: Font          {Font.custom("Poppins-SemiBold", size: 17)}
    static var  SemiBold20: Font          {Font.custom("Poppins-SemiBold", size: 20)}
    static var  Medium16: Font            {Font.custom("Poppins-Medium", size: 16)}
    static var  Medium18: Font            {Font.custom("Poppins-Medium", size: 18)}
    static var  Medium14: Font            {Font.custom("Poppins-Medium", size: 14)}
    static var  Medium10: Font            {Font.custom("Poppins-Medium", size: 10)}
    static var  Medium20: Font            {Font.custom("Poppins-Medium", size: 20)}
    static var  Medium24: Font            {Font.custom("Poppins-Medium", size: 24)}
    static var  Regular14: Font           {Font.custom("Poppins-Regular", size: 14)}
    static var  Regular16: Font           {Font.custom("Poppins-Regular", size: 16)}
    static var  Regular24: Font           {Font.custom("Poppins-Regular", size: 24)}
    static var  Regular13: Font           {Font.custom("Poppins-Regular", size: 13)}
    static var  Regular12: Font           {Font.custom("Poppins-Regular", size: 12)}
    static var  Regular10: Font           {Font.custom("Poppins-Regular", size: 10)}
    static var  Regular11: Font           {Font.custom("Poppins-Regular", size: 11)}
    static var  Regular18: Font           {Font.custom("Poppins-Regular", size: 18)}
    static var  Regular8: Font            {Font.custom("Poppins-Regular", size: 8)}
    static var  Regular6: Font            {Font.custom("Poppins-Regular", size: 6)}
   
    static var  SemiBold48: Font            {Font.custom("Rufina-Bold", size: 48)}

         
}
extension LinearGradient{
    static let primaryGradient = LinearGradient(gradient: Gradient(colors: [.bg1, .bg2 ]), startPoint: .top, endPoint: .bottom)
    static let secondaryGradient = LinearGradient(gradient: Gradient(colors: [.btnColor1, .btnColor2]), startPoint: .top, endPoint: .bottom)
    static let recBaseGradient = LinearGradient(gradient: Gradient(colors: [.blurbtn.opacity(0.8), .blurbtn.opacity(0.8), .blurbtn]), startPoint: .bottomLeading, endPoint: .topTrailing)
//    static let recSecGradient = LinearGradient(gradient: Gradient(colors: [ .white.opacity(0.0), .recOrangeColor]), startPoint: .center, endPoint: .topTrailing)
}

