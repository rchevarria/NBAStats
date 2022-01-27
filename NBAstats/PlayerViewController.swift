//
//  PlayerViewController.swift
//  NBAstats
//
//  Created by Ryan Chevarria on 1/21/22.
//

import UIKit
import AlamofireImage

class PlayerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    @IBOutlet var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var players = [Teams]()

    var team:Teams?
    
    var filteredData = [Teams]() 
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchBar.delegate = self
        
        downloadJSON {
            self.filteredData = self.players
            self.tableView.reloadData()
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath) as! PlayerCell
        
        let player = filteredData[indexPath.row]
        
        cell.firstNameLabel.text = player.FirstName
        cell.lastNameLabel.text = player.LastName
        
        let posterPath = player.PhotoUrl as! String
        let posterUrl = URL(string: posterPath)!
        cell.playerImage.af.setImage(withURL: posterUrl)
        
        
        var jersey = "\(String(describing: player.Jersey!))"
        jersey = jersey.replacingOccurrences(of: "Optional(", with: "", options: NSString.CompareOptions.literal, range: nil)
        jersey = jersey.replacingOccurrences(of: ")", with: "", options: NSString.CompareOptions.literal, range: nil)
      
        let shortDescrip = "\(String(player.Team))  |  #\(String(jersey))  |  \(String(player.PositionCategory))"
        
        cell.teamNameLabel.text = shortDescrip
        
        let imgID = player.TeamID as! Int
        let img = String(imgID)
        
        cell.playerTeamImage.image = UIImage(named: img)
            
        return cell
       
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //performSegue(withIdentifier: "detailSegue", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? PlayerDetailsViewController{
            destination.team = filteredData[(tableView.indexPathForSelectedRow?.row)!]
        }
        
    }
    

    func downloadJSON(completed: @escaping () -> ()){
        let url = URL(string: "https://api.sportsdata.io/v3/nba/scores/json/Players?key=3c946f20e66f4d8bab445c653a51395b")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil{
                do{
                    self.players = try JSONDecoder().decode([Teams].self, from: data!)
                    
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

    // MARK: Search Bar Config
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        filteredData = []
        
        if searchText == ""{
            filteredData = players
        }
        else{
            for people in players{
                if people.FirstName.lowercased().contains(searchText.lowercased()) || people.LastName.lowercased().contains(searchText.lowercased()) {
                    filteredData.append(people)
                }
            }
        }
        self.tableView.reloadData()
    }
}
