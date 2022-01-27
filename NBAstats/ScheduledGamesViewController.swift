//
//  ScheduledGamesViewController.swift
//  NBAstats
//
//  Created by Ryan Chevarria on 1/21/22.
//

import UIKit

class ScheduledGamesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    var schedule = [Teams]()
    var team:Teams?
    
    var filteredData = [Teams]()
    
    @IBOutlet var tableView: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        
        downloadJSON {
            self.filteredData = self.schedule
            self.tableView.reloadData()
            
        }
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell", for: indexPath) as! GameCell
        
        let scheduled = filteredData[indexPath.row]
        
        if(scheduled.DateTime is NSString){
            let dateTime = String(scheduled.DateTime!)
            cell.dateLabelSche.text = String(dateTime.prefix(10))
        }
        else{
            cell.dateLabelSche.text = "Date Unknown"
        }
        
        let home_Img = scheduled.HomeTeamID!
            let home_image = String(home_Img)
            cell.homeImageSche.image = UIImage(named: home_image)
            
        let visitor_Img = scheduled.AwayTeamID!
            let visitor_image = String(visitor_Img)
            cell.visitorImageSche.image = UIImage(named: visitor_image)
        
        cell.homeTeamLabel.text = scheduled.HomeTeam
        cell.visitorTeamLabel.text = scheduled.AwayTeam
        
            
        return cell
       
    }

    // MARK: - Table view data source


    func downloadJSON(completed: @escaping () -> ()){
        let url = URL(string: "https://api.sportsdata.io/v3/nba/scores/json/Games/2022?key=3c946f20e66f4d8bab445c653a51395b")
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            if error == nil{
                do{
                    self.schedule = try JSONDecoder().decode([Teams].self, from: data!)
                    self.schedule = self.schedule.filter {$0.Status == "Scheduled"} //Filters only games played by that team
                
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
            filteredData = schedule
        }
        else{
            for days in schedule{
                if days.HomeTeam.lowercased().contains(searchText.lowercased()) || days.AwayTeam.lowercased().contains(searchText.lowercased())  {
                    filteredData.append(days)
                }
            }
        }
        self.tableView.reloadData()
    }
    
}
