//
//  GamesViewController.swift
//  NBAstats
//
//  Created by Ryan Chevarria on 1/20/22.
//

import UIKit

class GamesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var games = [Teams]()
    var team:Teams?
    
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        downloadJSON {
            self.tableView.reloadData()
            
        }
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath) as! GameCell
        
        let game = games[indexPath.row]
        
        if(game.DateTime is NSString){
            let dateTime = String(game.DateTime)
            cell.dateLabel.text = String(dateTime.prefix(10))
        }
        else{
            cell.dateLabel.text = "Date Unknown"
        }
        
        let home_Img = game.HomeTeamID!
            let home_image = String(home_Img)
            cell.homeImage.image = UIImage(named: home_image)
            
        let visitor_Img = game.AwayTeamID!
            let visitor_image = String(visitor_Img)
            cell.visitorImage.image = UIImage(named: visitor_image)
    
        if(game.HomeTeamScore is NSNumber){
            let home_score = game.HomeTeamScore!
            let home_Score = String(home_score)
            cell.homeScore.text = home_Score
        }
        else{
            cell.homeScore.text = "Scheduled"
        }
            
        if(game.AwayTeamScore is NSNumber){
            let visitor_score = game.AwayTeamScore!
            let visitor_Score = String(visitor_score)
            cell.visitorScore.text = visitor_Score
        }
        else{
            cell.visitorScore.text = "Scheduled"
        }
        
            
        return cell
       
    }

    // MARK: - Table view data source


    func downloadJSON(completed: @escaping () -> ()){
        let url = URL(string: "https://api.sportsdata.io/v3/nba/scores/json/Games/2022?key=3c946f20e66f4d8bab445c653a51395b")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil{
                do{
                    self.games = try JSONDecoder().decode([Teams].self, from: data!)
                    self.games = self.games.filter {$0.HomeTeamID == self.team?.TeamID || $0.AwayTeamID == self.team?.TeamID  } //Filters only games played by that team
                    
                    DispatchQueue.main.async {
                        completed()
                    }
                }catch{
                    print("JSON Error")
                }
            }
            else{
                print("ERRORRRR")
            }
            
        }.resume()
    }

}
