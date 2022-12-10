import UIKit

public class WorldCupParticipant {
    private(set) var fullName: String
    private(set) var age: Int?
    private(set) var countryTeam: String
    
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

public class WorldCupTeam {
    var statusEliminated: Bool
    var membersCountrTeam: [WorldCupParticipant]
    
    enum ParticipatedCountries {
        case Qatar, Ecuador, Senegal, Netherlands, England, Iran, UnitedStates, Wales, Argentina, SaudiArabia, Mexico, Poland, France, Australia, Denmark, Tunisia,Spain, CostaRicam, Germany, Japan, Belgium, Canada, Morocco, Croatia, Brazil, Serbia, Switzerland, Cameroon, Portugal, Ghana, Uruguay, SouthKorea
    }
    
    private(set) var countryTeam: ParticipatedCountries
    
    init(countryTeam: ParticipatedCountries, statusEliminated: Bool, membersCountrTeam: [WorldCupParticipant]){
        self.countryTeam = countryTeam
        self.statusEliminated = statusEliminated
        self.membersCountrTeam = membersCountrTeam
    }
    
    func showMemberDetails(){
        for team in membersCountrTeam {
            print("\(team.fullName), rol: \(team.rollType)")
        }
    }
    
}

public class WorldCup{
    private(set) var countryTeams: [WorldCupTeam]
    
    init(countryTeams: [WorldCupTeam]){
        self.countryTeams = countryTeams
    }
    
    func showTeamDetails(){
        for team in countryTeams{
            print("\nTeam of: \(team.countryTeam)")
            team.showMemberDetails()
        }
    }
}

let participant_1 = WorldCupParticipant(fullName: "Leo Messi", countryTeam: "Argentina", rollType: .footballPlayer)
let participant_2 = WorldCupParticipant(fullName: "Lionel Scaloni", countryTeam: "Argentina", rollType: .coach)
let participant_3 = WorldCupParticipant(fullName: "Pablo Aimar", countryTeam: "Argentina", rollType: .technicalTeam)
let participant_4 = WorldCupParticipant(fullName: "Dani Alves", countryTeam: "Brazil", rollType: .footballPlayer)
let participant_5 = WorldCupParticipant(fullName: "Neymar", countryTeam: "Brazil", rollType: .footballPlayer)
let participant_6 = WorldCupParticipant(fullName: "Adenor Leonardo Bacchi", countryTeam: "Argentina", rollType: .coach)

let argentinaTeam = WorldCupTeam(countryTeam: .Argentina, statusEliminated: false , membersCountrTeam: [participant_1,participant_2,participant_3])
let brazilTeam = WorldCupTeam(countryTeam: .Brazil, statusEliminated: false, membersCountrTeam: [participant_4,participant_5,participant_6])

let wordCup = WorldCup(countryTeams: [argentinaTeam,brazilTeam])

wordCup.showTeamDetails()
