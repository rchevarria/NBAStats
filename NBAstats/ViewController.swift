//
//  ViewController.swift
//  NBAstats
//
//  Created by Ryan Chevarria on 1/20/22.
//

import UIKit
import AlamofireImage

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var teams = [Teams]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadJSON {
            self.tableView.reloadData()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return teams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamCell") as! TeamCell
        
        
        let team = teams[indexPath.row]
        
        cell.teamNameLabel.text = team.Name
        
        
        let imgID = team.TeamID as! Int
        let img = String(imgID)
        
        cell.teamLogo.image = UIImage(named: img)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //performSegue(withIdentifier: "detailSegue", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? GamesViewController{
            destination.team = teams[(tableView.indexPathForSelectedRow?.row)!]
        }
        
    }
    
    
    func downloadJSON(completed: @escaping () -> ()){
        let url = URL(string: "https://api.sportsdata.io/v3/nba/scores/json/AllTeams?key=3c946f20e66f4d8bab445c653a51395b")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil{
                do{
                    self.teams = try JSONDecoder().decode([Teams].self, from: data!)
                    self.teams = self.teams.filter {$0.TeamID <= 30 }
                    DispatchQueue.main.async {
                        completed()
                    }
                }catch{
                    print("JSON Error")
                }
            }
            
        }.resume()
    }
    
}

