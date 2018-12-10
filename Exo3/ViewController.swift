//
//  ViewController.swift
//  Exo3
//
//  Created by VM on 10/12/2018.
//  Copyright © 2018 VM. All rights reserved.
//

import UIKit
import SQLite

class ViewController: UIViewController {

    var database: Connection!
    let cursus_table = Table("cursus")
    let cursus_sigle = Expression<String>("sigle")
    let cursus_parcours = Expression<String>("parcours")
    let cursus_categorie = Expression<String>("categorie")
    let cursus_credit = Expression<Int>("credits")
    
    
    var tableExist = false
    // false la table n'est encore pas créée
    
    
    @IBAction func createTable() {
        
       
        do
        {
            let
            documentDirectory =
                try
                    FileManager.default.url(for: .documentDirectory,
                                            in: .userDomainMask, appropriateFor:
                        nil
                        , create:
                        true
            )
            let
            fileUrl = documentDirectory.appendingPathComponent(
                    "cursus"
                    ).appendingPathExtension(
                "sqlite3"
            )
            let
            base =
                try
                    Connection(fileUrl.path)
            self
                .database = base;
        }
        catch
        {
            print (error)
        }
        
        // create table
        
        
        if !self.tableExist {
            self.tableExist =
            true
            // Instruction pour faire un drop de la table USERS
            let
            dropTable = self.cursus_table.drop()
            // Instruction pour faire un create de la table USERS
            let createTable =
                self.cursus_table.create { table
                        in
                        table.column(
                            self.cursus_sigle, primaryKey:
                            true
                        )
                        table.column(
                            self.cursus_parcours)
                        table.column(
                            self.cursus_categorie)
                    table.column(
                        self.cursus_credit)
            }
            do
            {
                // Exécution du drop et du create
                try
                    self.database.run(dropTable)
                try
                    self.database.run(createTable)
                print (
                    "Table cursus est créée"
                )
            }
            catch
            {
                print (error)
            }
        }
        
        // data
        
        let
        insert1 =
            self
                .cursus_table.insert(
                    self
                        .cursus_sigle <- "IF26",
                    self.cursus_categorie <- "azer",
                    self.cursus_parcours <- "poiuy",
                    self.cursus_credit <- 6
        )
        
        do
        {
            try self.database.run(insert1)
            print ("Insert1 ok")
        }
        catch
        {
            print (error)
        }
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


}

