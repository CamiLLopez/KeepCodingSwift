import UIKit

public class WorldCupParticipant {
    private(set) var fullName: String
    private(set) var countryTeam: String
    private(set) var age: Int?
    
    enum RollParticipant {
       case footballPlayer
       case coach
       case doctor
       case fisio
       case psico
       case technicalTeam
   }
    var rollType: RollParticipant
    
    init(fullName: String, countryTeam: String, rollType: RollParticipant){
        self.fullName = fullName
        self.countryTeam = countryTeam
        self.rollType = rollType
    }
    
}

let participant_1 = WorldCupParticipant(fullName: "Leo Messi", countryTeam: "Argentina", rollType: .footballPlayer)
let participant_2 = WorldCupParticipant(fullName: "Lionel Scaloni", countryTeam: "Argentina", rollType: .coach)
let participant_3 = WorldCupParticipant(fullName: "Pablo Aimar", countryTeam: "Argentina", rollType: .technicalTeam)

print(participant_1.fullName)
