//
//  LocationPreView.swift
//  Baccvs iOS
//
//  Created by pm on 28/03/2023.


import SwiftUI

struct LocationPreView: View {
    @EnvironmentObject private var vm : LocationsViewModel
    let location : Location
    var body: some View {
        HStack(alignment: .bottom,spacing: 0){
            VStack(alignment: .leading,spacing: 16){
                imageSection
                titleSection
            }
            VStack(spacing: 8){
                learnMore
                NextButton
            }
        }.padding(20)
        .background(
            RoundedRectangle(cornerRadius: 10)
                .fill(.ultraThickMaterial)
                .offset(y:65)
        )
        .cornerRadius(10)
    }
}

struct LocationPreView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack{
            Color.blue.ignoresSafeArea()
            LocationPreView(location: LocationsDataService.locations.first!)
                .padding()
        }.environmentObject(LocationsViewModel())
    }
}






extension LocationPreView {
    private var  imageSection : some View {
        
        ZStack{
            if let imageName = location.imageNames.first{
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 100,height: 100)
                    .cornerRadius(10)
            }
        }.padding(6)
        .background(Color.white)
        .cornerRadius(10)
        
    }
    
    
    private var  titleSection : some View {
        VStack(alignment: .leading){
         
            Text(location.name)
                .font(.title2)
                .fontWeight(.bold)
            Text(location.cityName)
                .font(.subheadline)
        }.frame(maxWidth: .infinity,alignment: .leading)
    }
    
    private var  learnMore : some View {
        Button{
            
        }label: {
            Text("Learn More")
                .font(.headline)
                .frame(width: 125,height: 35)
        }.buttonStyle(.borderedProminent)

    }
    
    
    private var NextButton : some View {
        Button{
            vm.nextButtonPressed()
        }label: {
            Text("Next")
                .font(.headline)
                .frame(width: 125,height: 35)
        }.buttonStyle(.bordered)

    }
}
