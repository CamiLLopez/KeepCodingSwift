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

public class Game{
    
    private(set) var localTeam: WorldCupTeam
    private(set) var visitTeam: WorldCupTeam
    private(set) var totalGoalLocalTeam: Int = 0
    private(set) var totalGoalVisitTeam: Int = 0
    
    init(localteam: WorldCupTeam, visitTeam: WorldCupTeam, totalGoalLocalTeam: Int, totalGoalVisitTeam: Int){
        self.localTeam = localteam
        self.visitTeam = visitTeam
        self.totalGoalLocalTeam = totalGoalLocalTeam
        self.totalGoalVisitTeam = totalGoalVisitTeam
    }
    
    func showResults (game: Game){
        print("Partido: \(game.visitTeam.countryTeam) \(game.totalGoalVisitTeam)-\(game.totalGoalLocalTeam) \(game.localTeam.countryTeam)")
    }
    
}

public class GameManager {
    
    
    private func parGames(teamsForGame: [WorldCupTeam]) -> [[WorldCupTeam]]{
    
       var teamsForRaffle = teamsForGame
       var game: [[WorldCupTeam]] = []
       var partialGame: [WorldCupTeam] = []
       
       while teamsForRaffle.count != 0 {
            
           
           var randomInt = Int.random(in: 0..<(teamsForRaffle.count))
           partialGame.append(teamsForRaffle[randomInt])
           teamsForRaffle.remove(at: randomInt)
           
           if partialGame.count == 2 {
               game.append(partialGame)
               partialGame.removeAll()
           }
       }
        
        return game
    }
    
    
    func playRandomGames (wordCupTeams: WorldCup) {
        
        let teams = wordCupTeams.countryTeams
        
        var games = parGames(teamsForGame: teams)
        
        for game in games{
          
            var localGoals = Int.random(in: 0..<10)
            var visitGoals = Int.random(in: 0..<10)
            
            var particularMatch = Game(localteam: game[0], visitTeam: game[1], totalGoalLocalTeam: localGoals, totalGoalVisitTeam: visitGoals)
            
            particularMatch.showResults(game: particularMatch)
            
        }
    }
}

let participant_1 = WorldCupParticipant(fullName: "Leo Messi", countryTeam: "Argentina", rollType: .footballPlayer)
let participant_2 = WorldCupParticipant(fullName: "Lionel Scaloni", countryTeam: "Argentina", rollType: .coach)
let participant_3 = WorldCupParticipant(fullName: "Pablo Aimar", countryTeam: "Argentina", rollType: .technicalTeam)
let participant_4 = WorldCupParticipant(fullName: "Dani Alves", countryTeam: "Brazil", rollType: .footballPlayer)
let participant_5 = WorldCupParticipant(fullName: "Neymar", countryTeam: "Brazil", rollType: .footballPlayer)
let participant_6 = WorldCupParticipant(fullName: "Adenor Leonardo Bacchi", countryTeam: "Brazil", rollType: .coach)
let participant_7 = WorldCupParticipant(fullName: "Cristiano Ronaldo", countryTeam: "Portugal", rollType: .footballPlayer)
let participant_8 = WorldCupParticipant(fullName: "Diego Costa", countryTeam: "Portugal", rollType: .footballPlayer)
let participant_9 = WorldCupParticipant(fullName: "Fernando Manuel Costa Santos", countryTeam: "Portugal", rollType: .coach)
let participant_10 = WorldCupParticipant(fullName: "Luis Enrique", countryTeam: "Spain", rollType: .coach)
let participant_11 = WorldCupParticipant(fullName: "Jordi Alba", countryTeam: "Spain", rollType: .footballPlayer)
let participant_12 = WorldCupParticipant(fullName: "Robert Sanchez", countryTeam: "Spain", rollType: .footballPlayer)

let argentinaTeam = WorldCupTeam(countryTeam: .Argentina, statusEliminated: false , membersCountrTeam: [participant_1,participant_2,participant_3])
let brazilTeam = WorldCupTeam(countryTeam: .Brazil, statusEliminated: false, membersCountrTeam: [participant_4,participant_5,participant_6])
let portugalTeam = WorldCupTeam(countryTeam: .Portugal, statusEliminated: false, membersCountrTeam: [participant_7,participant_8,participant_9])
let spainTeam = WorldCupTeam(countryTeam: .Spain, statusEliminated: false, membersCountrTeam: [participant_10,participant_11,participant_12])
let wordCup = WorldCup(countryTeams: [argentinaTeam,brazilTeam,portugalTeam,spainTeam])

let game = GameManager()
game.playRandomGames(wordCupTeams: wordCup)
