//
//  Teams.swift
//  NBAstats
//
//  Created by Ryan Chevarria on 1/20/22.
//

import Foundation

struct Teams:Codable{
    //Team info
    var Name: String!
    var WikipediaLogoUrl : String!
    var TeamID : Int!
    
    //Games Details
    var DateTime: String!
    var HomeTeamID: Int!
    var AwayTeamID: Int!
    
    var HomeTeamScore: Int?
    var AwayTeamScore: Int!
    
    //Scheduled Games
    var AwayTeam: String!
    var HomeTeam: String!
    var Status: String!
    
    //Players
    var PlayerID: Int!
    var FirstName : String!
    var LastName : String!
    var PhotoUrl: String!
    var Team : String!
    
    //Player details
    var Jersey : Int?
    var Position : String!
    var PositionCategory : String!
    var BirthCity: String!
    var Height : Int!
    var Weight : Int!
    
}
/*
struct TeamDetail:Codable{
    var DateTime: String!
    var HomeTeamID: Int!
    var AwayTeamID: Int!
    
    var HomeTeamScore: Int!
    var AwayTeamScore: Int!
}
*/
