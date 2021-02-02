//
//  MissionView.swift
//  Moonshot
//
//  Created by Marko Kramar on 05/09/2020.
//  Copyright © 2020 Marko Kramar. All rights reserved.
//

import Foundation
import SwiftUI

struct MissionView: View {
    struct CrewMember {
        let role: String
        let astronaut: Astronaut
    }
    
    let mission: Mission
    let astronauts: [CrewMember]
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    Image(decorative: self.mission.image)
                        .resizable()
                        //.scaledToFit()
                        //.frame(maxWidth: geometry.size.width * 0.7)
                        .scaleEffect(CGSize(width: 1 - geometry.frame(in: .local).minY, height: 1 - geometry.frame(in: .local).minY))
                        .padding(.top)
                        .animation(.easeInOut)
                    
                    HStack(alignment: .center) {
                        Text("Launch date: \(self.mission.formattedLaunchDate)")
                            .font(.headline)
                    }
                    
                    Text(self.mission.description)
                        .padding()
                    
                    ForEach(self.astronauts, id: \.role) { crewMember in
                        NavigationLink(destination: AstronautView(astronaut: crewMember.astronaut)) {
                            HStack {
                                Image(crewMember.astronaut.id)
                                    .resizable()
                                    .frame(width: 83, height: 60)
                                    .clipShape(Capsule())
                                    .overlay(Capsule().stroke(Color.primary, lineWidth: 1))
                                
                                VStack(alignment: .leading) {
                                    self.astronautName(crewMember)
                                    
                                    Text(crewMember.role)
                                        .foregroundColor(.secondary)
                                }
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    
                    Spacer(minLength: 25)
                }
            }
        }
        .navigationBarTitle(Text(mission.displayName), displayMode: .inline)
    }
    
    func astronautName(_ crewMember: CrewMember) -> Text {
        Text(crewMember.astronaut.name + (crewMember.role == "Commander" ? "★" : ""))
            .font(.headline)
    }
    
    init(mission: Mission, astronauts: [Astronaut]) {
        self.mission = mission
        
        var matches = [CrewMember]()
        for member in mission.crew {
            if let match = astronauts.first(where: { $0.id == member.name }) {
                matches.append(CrewMember(role: member.role, astronaut: match))
            } else {
                fatalError("Missing \(member)")
            }
        }
        
        self.astronauts = matches
    }
}

struct MissionView_Previews: PreviewProvider {
    static let missions: [Mission] = Bundle.main.decode("missions.json")
    static let astronauts: [Astronaut] = Bundle.main.decode("astronauts.json")
    
    static var previews: some View {
        MissionView(mission: missions[0], astronauts: astronauts)
    }
}
