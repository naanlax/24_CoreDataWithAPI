//
//  ViewController.swift
//  24_CoreDataWithAPI
//
//  Created by Nandhika T M on 12/12/24.
//

import UIKit
import CoreData

class DisplayItemVC: UITableViewController
{
    let manageObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    var itemsList : [ItemList] = []
    
    let button = UIButton()
    
    var networkCall = NetworkCall()
    
    let customCell = CustomCell()
    
    let staticCell = StaticGetCall()
    
    func fetchitem()
    {
        self.itemsList = try! manageObjectContext.fetch(ItemList.fetchRequest())
        
        DispatchQueue.main.async
        {
            self.tableView.reloadData()
        }
    }
    
    func displayItem(itemToBeDisplayed: ItemList)
    {
        fetchitem()
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        self.title = "Table View"
        view.backgroundColor = .systemBackground
        
        button.setTitle("Back", for: .normal)
        button.tintColor = .systemBlue
        button.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        view.addSubview(button)
        
        setUpUI()
    }
    
    func setUpUI()
    {
        tableView.register(CustomCell.self, forCellReuseIdentifier: "cellId")
        tableView.estimatedRowHeight = 100
        tableView.backgroundColor = .systemBackground
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return itemsList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as? CustomCell else {
            fatalError("Unable to dequeue CustomTableViewCell")
        }
        
        let item = itemsList[indexPath.row]
        
        cell.configure(item: item)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
            
        let selectedItem = itemsList[indexPath.row]
            
        /*let detailVC = ItemDisplay(
            itemname: selectedItem.name,
            itemsku: selectedItem.sku,
            itemrate: selectedItem.rate,
            itemdesc: selectedItem.desc
        )
            
        detailVC.delegate = self
        detailVC.modalPresentationStyle = .fullScreen
        present(
            detailVC,
            animated: true,
            completion: nil
        )*/
    }
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration?
    {
        let action = UIContextualAction(
            style: .destructive, title: "Delete")
        {
                (action, view, completionhandler) in
                
                let itemToRemove = self.itemsList[indexPath.row]
                
                self.networkCall.deleteData(itemIDPassed: itemToRemove.item_id ?? "")
                {
                    responseCode in
                    if responseCode >= 200 && responseCode < 300
                    {
                        self.manageObjectContext.delete(itemToRemove)
                        try! self.manageObjectContext.save()
                        self.fetchitem()
                    }
                    else
                    {
                        print("Error!!!! 400 Bad request")
                    }
                }
        }
        let swipeAction = UISwipeActionsConfiguration(actions: [action])
        return swipeAction
    }
    
    func showToast(message : String, font: UIFont)
    {
        DispatchQueue.main.async{
            let toastLabel = UILabel()
            toastLabel.backgroundColor = UIColor.systemBlue
            toastLabel.textColor = UIColor.white
            toastLabel.font = font
            toastLabel.textAlignment = .center
            toastLabel.text = message
            toastLabel.alpha = 1.0
            toastLabel.layer.cornerRadius = 30
            toastLabel.clipsToBounds = true
            toastLabel.translatesAutoresizingMaskIntoConstraints = false
            
            self.view.addSubview(toastLabel)
            
            NSLayoutConstraint.activate([
                toastLabel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
                toastLabel.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -100),
                toastLabel.widthAnchor.constraint(equalToConstant: 300),
                toastLabel.heightAnchor.constraint(equalToConstant: 75)
            ])
            
            UIView.animate(
                withDuration: 3.0,
                delay: 0,
                options: .curveEaseInOut,
                animations: {
                    toastLabel.alpha = 0.0
                },
                completion: { _ in
                    toastLabel.removeFromSuperview()
                }
            )
        }
    }
    
    @objc func buttonPressed()
    {
        
    }
}

