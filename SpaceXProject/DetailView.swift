//
//  DetailView.swift
//  SpaceXProject
//
//  Created by Jan Kubín on 28.07.2023.
//

import SwiftUI

struct DetailView: View {
    
    let launch: Response
    
    var body: some View {
        VStack{
            Image(launch.links.large)
                .resizable()
                .scaledToFit()
                .frame(height: 100)
            Text(launch.name)
                .font(.title)
                .padding([.bottom, .top])
            Text("Flight number: \(launch.flightNumber)")
                .font(.headline)
                .padding(.bottom)
            Text("Date: \(launch.dateLocal)")
                .font(.headline)
                .padding(.bottom)
            Text(launch.details ?? "")
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        // For the preview, you can create a sample launch to pass as a parameter
        let sampleLaunch = Response(name: "Sample Name", details: "Sample Details", dateLocal: "Some date", flightNumber: 123, links: Patch(small: "sample_url", large: "sample_url"))
        DetailView(launch: sampleLaunch)
    }
}

