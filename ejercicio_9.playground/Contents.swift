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
    var points: Int = 0
    
    enum ParticipatedCountries {
        case Qatar, Ecuador, Senegal, Netherlands, England, Iran, UnitedStates, Wales, Argentina, SaudiArabia, Mexico, Poland, France, Australia, Denmark, Tunisia,Spain, CostaRica, Germany, Japan, Belgium, Canada, Morocco, Croatia, Brazil, Serbia, Switzerland, Cameroon, Portugal, Ghana, Uruguay, SouthKorea
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
    
    private func generateGroups() -> [[WorldCupTeam]] {
        
        var teamsForGruop = countryTeams
        var gruops: [[WorldCupTeam]] = []
        var partialGruop: [WorldCupTeam] = []
        
        
        if (countryTeams.count % 4 == 0 ){
                
            while teamsForGruop.count != 0 {
                
                var randomInt = Int.random(in: 0..<(teamsForGruop.count))
                partialGruop.append(teamsForGruop[randomInt])
                teamsForGruop.remove(at: randomInt)
                
                if partialGruop.count == 4 {
                    gruops.append(partialGruop)
                    partialGruop.removeAll()
                }
            }
        }
        return gruops
    }
    
    func createGruops(){
        
        var gruops = generateGroups()
        
        for gruop in gruops {
          
            var rangeForCharacterGruopName: Range = 0..<gruops.count
            var characterGruopName = ["A", "B", "C", "D", "E", "F", "G", "H"]
            var randomCharacter = characterGruopName[rangeForCharacterGruopName].randomElement()
            var indexCharacter = characterGruopName.firstIndex(of: randomCharacter ?? "" )
            characterGruopName.remove(at: indexCharacter!)
            
            var particularGruop = Groups(groupName: randomCharacter ?? "", listingTeams: gruop, listingGames: )
            
            particularGruop.showGruops()
            
        }
    }
    
}

public class Groups{
    
    private(set) var groupName: String
    private(set) var listingTeams: [WorldCupTeam]
    private(set) var listingGames: [Game]?
    
    init(groupName: String, listingTeams: [WorldCupTeam], listingGames: [Game]) {
        self.groupName = groupName
        self.listingTeams = listingTeams
        self.listingGame = listingGames
    }
    
    func showGruops(){
        var result = listingTeams.map({$0.countryTeam})
        print("Grupo \(groupName), participantes: \(result)")
    }
    
    func getPoints(wordCupTeam: WorldCupTeam) -> Int {
        
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
    
    func calculateResults() {
        
        if (game.totalGoalVisitTeam == game.totalGoalLocalTeam){
            localTeam.points += 1
            visitTeam.points += 1
        }
        else if (game.totalGoalVisitTeam > game.totalGoalLocalTeam){
            visitTeam.points += 3
            localTeam.points += 0
        }
        else if(game.totalGoalVisitTeam < game.totalGoalLocalTeam)
            visitTeam.points += 0
            localTeam.points += 3
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
let participant_13 = WorldCupParticipant(fullName: "Leo Messi", countryTeam: "Swiss", rollType: .footballPlayer)
let participant_14 = WorldCupParticipant(fullName: "Lionel Scaloni", countryTeam: "Swiss", rollType: .coach)
let participant_15 = WorldCupParticipant(fullName: "Pablo Aimar", countryTeam: "Swiss", rollType: .technicalTeam)
let participant_16 = WorldCupParticipant(fullName: "Dani Alves", countryTeam: "Costa Rica", rollType: .footballPlayer)
let participant_17 = WorldCupParticipant(fullName: "Neymar", countryTeam: "Costa Rica", rollType: .footballPlayer)
let participant_18 = WorldCupParticipant(fullName: "Adenor Leonardo Bacchi", countryTeam: "Costa Rica", rollType: .coach)
let participant_19 = WorldCupParticipant(fullName: "Cristiano Ronaldo", countryTeam: "Poland", rollType: .footballPlayer)
let participant_20 = WorldCupParticipant(fullName: "Diego Costa", countryTeam: "Poland", rollType: .footballPlayer)
let participant_21 = WorldCupParticipant(fullName: "Fernando Manuel Costa Santos", countryTeam: "Poland", rollType: .coach)
let participant_22 = WorldCupParticipant(fullName: "Luis Enrique", countryTeam: "England", rollType: .coach)
let participant_23 = WorldCupParticipant(fullName: "Jordi Alba", countryTeam: "England", rollType: .footballPlayer)
let participant_24 = WorldCupParticipant(fullName: "Robert Sanchez", countryTeam: "England", rollType: .footballPlayer)

let argentinaTeam = WorldCupTeam(countryTeam: .Argentina, statusEliminated: false , membersCountrTeam: [participant_1,participant_2,participant_3])
let brazilTeam = WorldCupTeam(countryTeam: .Brazil, statusEliminated: false, membersCountrTeam: [participant_4,participant_5,participant_6])
let portugalTeam = WorldCupTeam(countryTeam: .Portugal, statusEliminated: false, membersCountrTeam: [participant_7,participant_8,participant_9])
let spainTeam = WorldCupTeam(countryTeam: .Spain, statusEliminated: false, membersCountrTeam: [participant_10,participant_11,participant_12])
let switzerlandTeam = WorldCupTeam(countryTeam: .Switzerland, statusEliminated: false , membersCountrTeam: [participant_14,participant_13,participant_15])
let costaRicaTeam = WorldCupTeam(countryTeam: .CostaRica, statusEliminated: false, membersCountrTeam: [participant_16,participant_17,participant_18])
let polandTeam = WorldCupTeam(countryTeam: .Poland, statusEliminated: false, membersCountrTeam: [participant_19,participant_20,participant_21])
let englandTeam = WorldCupTeam(countryTeam: .England, statusEliminated: false, membersCountrTeam: [participant_22,participant_23,participant_24])
let wordCup = WorldCup(countryTeams: [argentinaTeam,brazilTeam,portugalTeam,spainTeam,switzerlandTeam,polandTeam,englandTeam,costaRicaTeam])


let game = GameManager()
game.playRandomGames(wordCupTeams: wordCup)

wordCup.createGruops()


