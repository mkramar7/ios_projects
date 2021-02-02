//
//  AstronautView.swift
//  Moonshot
//
//  Created by Marko Kramar on 05/09/2020.
//  Copyright © 2020 Marko Kramar. All rights reserved.
//

import Foundation
import SwiftUI

struct AstronautView: View {
    let astronaut: Astronaut
    let missions: [Mission]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(decorative: self.astronaut.id)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geometry.size.width)
                    
                    Text(self.astronaut.description)
                        .padding()
                        .layoutPriority(1)
                    
                    Text("Missions assigned to: ")
                        .font(.title)
                    
                    List(self.missions) { mission in
                        VStack(alignment: .leading) {
                            Text("Apollo \(mission.id)")
                                .font(.headline)
                            
                            Text(mission.description)
                                .font(.caption)
                        }
                    }
                }
            }
        }
        .navigationBarTitle(Text(astronaut.name), displayMode: .inline)
    }
    
    init(astronaut: Astronaut) {
        self.astronaut = astronaut
        
        var missionsForAstronaut = [Mission]()
        let allMissions: [Mission] = Bundle.main.decode("missions.json")
        for mission in allMissions {
            for crewRole in mission.crew {
                if crewRole.name == astronaut.id {
                    missionsForAstronaut.append(mission)
                }
            }
        }
        
        self.missions = missionsForAstronaut
    }
}

struct AstronautView_Previews: PreviewProvider {
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        AstronautView(astronaut: astronauts[0])
    }
}
