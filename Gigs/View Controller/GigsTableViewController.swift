//
//  GigsTableViewController.swift
//  Gigs
//
//  Created by Taylor Lyles on 9/4/19.
//  Copyright © 2019 Taylor Lyles. All rights reserved.
//

import UIKit

class GigsTableViewController: UITableViewController {
	
	let gigController = GigController()

    override func viewDidLoad() {
        super.viewDidLoad()

		
    }
	
	override func viewDidAppear(_ animated: Bool) {
		super.viewDidAppear(animated)
		
		if gigController.bearer == nil {
			performSegue(withIdentifier: "LoginModalSegue", sender: nil)
		} else {
			GigController.gettingGigs
		}
	}

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
			if segue.identifier == "LoginModalSegue",
				let loginVC = segue.destination as? LoginViewController {
				
		}
    }
}
