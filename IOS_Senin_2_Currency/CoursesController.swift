//
//  CoursesControllerTableViewController.swift
//  IOS_Senin_2_Currency
//
//  Created by Jenya on 10.01.2021.
//

import UIKit

class CoursesControllerController: UITableViewController {

    @IBAction func pushRefreshAction(_ sender: Any) {
        Model.shared.loadXMLFile(date: nil);
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "startLoadingXML"), object: nil, queue: nil) { (Notification) in
            
            DispatchQueue.main.async {
                
                let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium);
                
                activityIndicator.color = .red;
                
                activityIndicator.startAnimating()
                
                self.navigationItem.rightBarButtonItem?.customView = activityIndicator;
                
            }
           
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "dataRefreshed"), object: nil, queue: nil) { (Notification) in
            
            DispatchQueue.main.async {
                
                self.tableView.reloadData();
                self.navigationItem.title =  Model.shared.currentDate;
                
                
                let barButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.refresh, target: self, action: #selector(self.pushRefreshAction(_:)))
                self.navigationItem.rightBarButtonItem = barButtonItem;
            }
           
        }
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "ErrorWhenXMLloading"), object: nil, queue: nil) { (Notification) in
            
            DispatchQueue.main.async {
                
                let barButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.refresh, target: self, action: #selector(self.pushRefreshAction(_:)))
                self.navigationItem.rightBarButtonItem = barButtonItem;
                
                
                let errorName = Notification.userInfo?["ErrorName"] as! String;
                print(errorName);
                let alert = UIAlertController(title: "Добавить элемент", message: errorName, preferredStyle: UIAlertController.Style.alert);
                self.present(alert, animated: true, completion: nil);
            }
        }
        
        //let df = DateFormatter();
        //df.dateFormat = "dd.MM.yyyy";
        //navigationItem.title = df.string(from: Model.shared.currentDate);
        navigationItem.title =  Model.shared.currentDate;
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewDidAppear(_ animated: Bool) {
        Model.shared.loadXMLFile(date: nil); // лучше вынести сюда пусть парсит когда появляеся экран и не нарвемся вдруг на пустой массив (из отдельного потока)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Model.shared.currencies.count;
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CoursesCellController
        
        let courseForCell = Model.shared.currencies[indexPath.row];

        cell.initCell(currency: courseForCell);
        
        //cell.textLabel?.text = courseForCell.Name;
        //cell.detailTextLabel?.text = courseForCell.Value;
        
       
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
