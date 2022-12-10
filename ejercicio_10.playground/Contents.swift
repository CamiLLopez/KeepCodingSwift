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
    var membersCountryTeam: [WorldCupParticipant]
    var totalPoints: Int = 0
    
    enum ParticipatedCountries {
        case Qatar, Ecuador, Senegal, Netherlands, England, Iran, UnitedStates, Wales, Argentina, SaudiArabia, Mexico, Poland, France, Australia, Denmark, Tunisia,Spain, CostaRica, Germany, Japan, Belgium, Canada, Morocco, Croatia, Brazil, Serbia, Switzerland, Cameroon, Portugal, Ghana, Uruguay, SouthKorea
    }
    
    private(set) var countryTeam: ParticipatedCountries
    
    init(countryTeam: ParticipatedCountries, statusEliminated: Bool, membersCountryTeam: [WorldCupParticipant]){
        self.countryTeam = countryTeam
        self.statusEliminated = statusEliminated
        self.membersCountryTeam = membersCountryTeam
    }
    
    func showMemberDetails(){
        for team in membersCountryTeam {
            print("\(team.fullName), rol: \(team.rollType)")
        }
    }
    
}

public class WorldCup{
    
    private(set) var countryTeams: [WorldCupTeam]
    private(set) var gruopsList: [Groups] = []
    
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
    
    func createGruops() -> [Groups] {
        
        var gruops = generateGroups()
        var totalGruops: [Groups] = []
        var rangeForCharacterGruopName: Range = 0..<gruops.count
        var characterGruopName = ["A", "B", "C", "D", "E", "F", "G", "H"]
        
        for gruop in gruops {
          
            var randomCharacter = characterGruopName[rangeForCharacterGruopName].randomElement()
            var indexCharacter = characterGruopName.firstIndex(of: randomCharacter ?? "" )
            characterGruopName.remove(at: indexCharacter!)
            
            var particularGruop = Groups(groupName: randomCharacter ?? "", listingTeams: gruop)
            
            particularGruop.showGruops()
            totalGruops.append(particularGruop)
            gruopsList.append(particularGruop)
        }
        
        return totalGruops
    }
 
}

public class Groups{
    
    private(set) var groupName: String
    private(set) var listingTeams: [WorldCupTeam]
    var listingGames: [Game]?
    
    init(groupName: String, listingTeams: [WorldCupTeam]) {
        self.groupName = groupName
        self.listingTeams = listingTeams
    }
    
    func showGruops(){
        var result = listingTeams.map({String(describing: $0.countryTeam) })
        print("Grupo \(groupName), participantes: \(result)")
    }
    
    func getPointsByTeam(wordCupTeam: WorldCupTeam) -> String {
        "La seleccion de \(wordCupTeam.countryTeam) tiene \(wordCupTeam.totalPoints) puntos totales"
    }
    
    private func getPointsByGruop(gruop: Groups) ->[WorldCupTeam.ParticipatedCountries:Int] {
       
        var tableOfPoints = [WorldCupTeam.ParticipatedCountries:Int]()
        
        for team in gruop.listingTeams {
            tableOfPoints[team.countryTeam] = team.totalPoints
        }
        return tableOfPoints
    }
    
    func classifiedTeams(wordCupGruops: [Groups] ) {
        
        var finalTeams = [WorldCupTeam.ParticipatedCountries:Int]()
        
        for gruop in wordCupGruops{
            
            var table = getPointsByGruop(gruop: gruop)
            
            for _ in 0...1{
                let greatestValue = table.max(by:{$0.value < $1.value})
                table.removeValue(forKey: greatestValue!.key)
                finalTeams[greatestValue!.key] = greatestValue!.value
            }
        }
        print("Selecciones clasificadas = ")
        for (key, value) in finalTeams {
            print("\(key), Puntos: \(value)")
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
        game.calculateResults()
    }
    
    private func calculateResults() {
        
        if (totalGoalVisitTeam == totalGoalLocalTeam){
            localTeam.totalPoints += 1
            visitTeam.totalPoints += 1
        }
        else if (totalGoalVisitTeam > totalGoalLocalTeam){
            visitTeam.totalPoints += 3
            localTeam.totalPoints += 0
        }
        else if(totalGoalVisitTeam < totalGoalLocalTeam){
            visitTeam.totalPoints += 0
            localTeam.totalPoints += 3
        }
        
    }
}

public class GameManager {
    
    
    private func parGames(teamsForGameInGruop: [WorldCupTeam]) -> [[WorldCupTeam]]{
    
       
       let gruopGamesIndex: [[Int]] = [[0,1],[0,2],[0,3],[1,2],[1,3],[2,3]]
       var game: [[WorldCupTeam]] = []
       
        
        for index in gruopGamesIndex {
           
            var partialGame: [WorldCupTeam] = []
            var equipoA = index[0]
            var equipoB = index[1]
            
            partialGame.append(teamsForGameInGruop[equipoA])
            partialGame.append(teamsForGameInGruop[equipoB])
            
            game.append(partialGame)
        }
        return game
    }
    
    
    func playGames (wordCupTeams: [Groups]) {
        
        for gruop in wordCupTeams{
            let gamesForGruop = parGames(teamsForGameInGruop: gruop.listingTeams)
            
            for game in gamesForGruop{
             
                var localGoals = Int.random(in: 0..<10)
                var visitGoals = Int.random(in: 0..<10)
                
                var particularMatch = Game(localteam: game[0], visitTeam: game[1], totalGoalLocalTeam: localGoals, totalGoalVisitTeam: visitGoals)
                
                particularMatch.showResults(game: particularMatch)
            }
        }
    }
}

var participant_1 = WorldCupParticipant(fullName: "Leo Messi", countryTeam: "Argentina", rollType: .footballPlayer)
var participant_2 = WorldCupParticipant(fullName: "Lionel Scaloni", countryTeam: "Argentina", rollType: .coach)
var participant_3 = WorldCupParticipant(fullName: "Pablo Aimar", countryTeam: "Argentina", rollType: .technicalTeam)
var participant_4 = WorldCupParticipant(fullName: "Dani Alves", countryTeam: "Brazil", rollType: .footballPlayer)
var participant_5 = WorldCupParticipant(fullName: "Neymar", countryTeam: "Brazil", rollType: .footballPlayer)
var participant_6 = WorldCupParticipant(fullName: "Adenor Leonardo Bacchi", countryTeam: "Brazil", rollType: .coach)
var participant_7 = WorldCupParticipant(fullName: "Cristiano Ronaldo", countryTeam: "Portugal", rollType: .footballPlayer)
var participant_8 = WorldCupParticipant(fullName: "Diego Costa", countryTeam: "Portugal", rollType: .footballPlayer)
var participant_9 = WorldCupParticipant(fullName: "Fernando Manuel Costa Santos", countryTeam: "Portugal", rollType: .coach)
var participant_10 = WorldCupParticipant(fullName: "Luis Enrique", countryTeam: "Spain", rollType: .coach)
var participant_11 = WorldCupParticipant(fullName: "Jordi Alba", countryTeam: "Spain", rollType: .footballPlayer)
var participant_12 = WorldCupParticipant(fullName: "Robert Sanchez", countryTeam: "Spain", rollType: .footballPlayer)
var participant_13 = WorldCupParticipant(fullName: "Leo Messi", countryTeam: "Swiss", rollType: .footballPlayer)
var participant_14 = WorldCupParticipant(fullName: "Lionel Scaloni", countryTeam: "Swiss", rollType: .coach)
var participant_15 = WorldCupParticipant(fullName: "Pablo Aimar", countryTeam: "Swiss", rollType: .technicalTeam)
var participant_16 = WorldCupParticipant(fullName: "Dani Alves", countryTeam: "Costa Rica", rollType: .footballPlayer)
var participant_17 = WorldCupParticipant(fullName: "Neymar", countryTeam: "Costa Rica", rollType: .footballPlayer)
var participant_18 = WorldCupParticipant(fullName: "Adenor Leonardo Bacchi", countryTeam: "Costa Rica", rollType: .coach)
var participant_19 = WorldCupParticipant(fullName: "Cristiano Ronaldo", countryTeam: "Poland", rollType: .footballPlayer)
var participant_20 = WorldCupParticipant(fullName: "Diego Costa", countryTeam: "Poland", rollType: .footballPlayer)
var participant_21 = WorldCupParticipant(fullName: "Fernando Manuel Costa Santos", countryTeam: "Poland", rollType: .coach)
var participant_22 = WorldCupParticipant(fullName: "Luis Enrique", countryTeam: "England", rollType: .coach)
var participant_23 = WorldCupParticipant(fullName: "Jordi Alba", countryTeam: "England", rollType: .footballPlayer)
var participant_24 = WorldCupParticipant(fullName: "Robert Sanchez", countryTeam: "England", rollType: .footballPlayer)

    
    
let argentinaTeam = WorldCupTeam(countryTeam: .Argentina, statusEliminated: false , membersCountryTeam:[participant_1,participant_2,participant_3])
let brazilTeam = WorldCupTeam(countryTeam: .Brazil, statusEliminated: false, membersCountryTeam: [participant_4,participant_5,participant_6])
let portugalTeam = WorldCupTeam(countryTeam: .Portugal, statusEliminated: false, membersCountryTeam: [participant_7,participant_8,participant_9])
let spainTeam = WorldCupTeam(countryTeam: .Spain, statusEliminated: false, membersCountryTeam: [participant_10,participant_11,participant_12])
let switzerlandTeam = WorldCupTeam(countryTeam: .Switzerland, statusEliminated: false , membersCountryTeam: [participant_14,participant_13,participant_15])
let costaRicaTeam = WorldCupTeam(countryTeam: .CostaRica, statusEliminated: false, membersCountryTeam: [participant_16,participant_17,participant_18])
let polandTeam = WorldCupTeam(countryTeam: .Poland, statusEliminated: false, membersCountryTeam: [participant_19,participant_20,participant_21])
let englandTeam = WorldCupTeam(countryTeam: .England, statusEliminated: false, membersCountryTeam: [participant_22,participant_23,participant_24])
    
    
    
let wordCup = WorldCup(countryTeams: [argentinaTeam,brazilTeam,portugalTeam,spainTeam,switzerlandTeam,polandTeam,englandTeam,costaRicaTeam])



var gruopsWordCup = wordCup.createGruops()
var newGames = GameManager()
newGames.playGames(wordCupTeams: gruopsWordCup)
gruopsWordCup[0].getPointsByTeam(wordCupTeam: portugalTeam)
gruopsWordCup[0].classifiedTeams(wordCupGruops: gruopsWordCup)

