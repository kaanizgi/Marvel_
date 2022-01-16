//
//  TableViewCell.swift
//  Marvel_Api
//
//  Created by Kaan İzgi on 15.01.2022.
//

import UIKit
import RealmSwift

protocol saveButtonPath {
    func ButtonPath(indexPath:IndexPath)
}

class TableViewCell: UITableViewCell {

    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var thumbnail: UIImageView!
    private let realm = try! Realm()
    private var favorites: Results<Favorite>?
    var hucreProtocol:saveButtonPath?
    var indexPath:IndexPath?
    override func awakeFromNib() {
        super.awakeFromNib()
        favorites = realm.objects(Favorite.self)
        
        var hucreProtocol:saveButtonPath?
        var indexPath:IndexPath
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    @IBAction func saveCharacter(_ sender: Any) {
        hucreProtocol?.ButtonPath(indexPath: indexPath!)
        favorites = realm.objects(Favorite.self)
        if (favorites?.contains(where: { $0.name == name.text!   }))! {saveButton.setImage(UIImage(named: "Favorites2"), for: .normal)
        } else {
        saveButton.setImage(UIImage(named: "Favorites"), for: .normal) }
    }
}
