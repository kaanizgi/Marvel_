//
//  ViewController.swift
//  Marvel_Api
//
//  Created by Kaan İzgi on 15.01.2022.
//

import UIKit
import SDWebImage
import Alamofire
import RealmSwift

var MCList = [MCListCharacter]()

class ViewController: UIViewController {
    @IBOutlet weak var tableViewim: UITableView!
    private let realm = try! Realm()
    private var favorites: Results<Favorite>?
    
    var limitim = 5

    override func viewDidLoad() {
        super.viewDidLoad()
        favorites = realm.objects(Favorite.self)
        WebService().getCharacters(tableView: tableViewim, limit: 30)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        tableViewim.reloadData()
    }
    
}
extension ViewController:UITableViewDelegate,UITableViewDataSource {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(200)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MCList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewim.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        let row = MCList[indexPath.row]
        cell.thumbnail.sd_setImage(with: URL(string: row.getThumbnail()))
        cell.name.text = row.name
        
        favorites = realm.objects(Favorite.self)
        if (favorites?.contains(where: { $0.id == String(row.id)  }))! {cell.saveButton.setImage(UIImage(named: "Favorites2"), for: .normal)
        } else {
        cell.saveButton.setImage(UIImage(named: "Favorites"), for: .normal) }
        cell.hucreProtocol = self
        cell.indexPath = indexPath
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = MCList[indexPath.row]
        let detailVC = storyboard?.instantiateViewController(withIdentifier: "detailVC") as! DetailViewController
        navigationController?.pushViewController(detailVC, animated: true)
        detailVC.characterID = String(row.id)
        detailVC.detailName = row.name
        detailVC.detailDescrp = row.resultDescription
        detailVC.detailThumbnail = row.getThumbnail()
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == MCList.count - 1 {
            limitim = limitim + 30
            WebService().updateCharacters(tableView: tableViewim, limit: limitim)
        }
    }
}

extension ViewController:saveButtonPath {
    func ButtonPath(indexPath: IndexPath) {
        let row = MCList[indexPath.row]
        let favorite = Favorite()
        favorite.id = String(row.id)
        favorite.name = row.name
        favorite.thumbnail = row.getThumbnail()
        favorite.detail = row.resultDescription
        
        if (favorites?.contains(where: { $0.id == favorite.id }))! {
                            do {
                                try realm.write {
                                let character = realm.objects(Favorite.self).filter("id = %@", favorite.id)
                                realm.delete(character)
                                print("Remove Succes")
                                }
                            } catch {
                                print("(error)")
                            }
                        } else {

                            do {
                                try realm.write {
                                realm.add(favorite)
                                print("Add Succes")
                                }
                            } catch {
                                print((error))
                            }
                        }
    }
    }
    


