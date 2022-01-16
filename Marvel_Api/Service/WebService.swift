//
//  WebService.swift
//  Marvel_Api
//
//  Created by Kaan İzgi on 15.01.2022.
//

import Foundation
import Alamofire

class WebService {
    
    func getCharacters(tableView:UITableView,limit:Int) {
        let parameters: Parameters = ["apikey": "\(App.publickey)","hash": "\(App.hash)","ts": "\(App.ts)","limit": limit]
        AF.request(App.serviceurl+"characters", method: .get, parameters: parameters).responseJSON{ response in
            if let data = response.data{
                        
                    do{
                        let data = try JSONDecoder().decode(MCListCharactersResponse.self, from: data)
                        DispatchQueue.main.async {
                        MCList = data.data.results
                        tableView.reloadData()
                    }
                    }   catch{
                        print(error.localizedDescription)
                }
            }
        }
    }
    
    func getComics(collectionView:UICollectionView,characterid:String) {
            let df = DateFormatter()
            df.dateFormat = "yyyy-MM-dd"
            let now = df.string(from: Date())
                let parameters: Parameters = [
                    "apikey": "\(App.publickey)","hash": "\(App.hash)","ts": "\(App.ts)","limit": 10,"dateRange": "2005-01-01,\(now)","orderBy": "-focDate"
                ]

                AF.request(App.serviceurl + "characters/"+"\(characterid)"+"/comics", method: .get, parameters: parameters).responseJSON{ response in
                    if let data = response.data{
                                do{
                                    let datam = try JSONDecoder().decode(ComicsServerModel.self, from: data)
                                    DispatchQueue.main.async {
                                        ComicList = datam.data.results!
                                        collectionView.reloadData()

                                    }
                                }catch{
                                    print(error.localizedDescription)
                                }
                            }
                        }
                }

    func updateCharacters(tableView:UITableView,limit:Int) {
        let parameters: Parameters = ["apikey": "\(App.publickey)","hash": "\(App.hash)","ts": "\(App.ts)","offset":limit,"limit":"30"]
        AF.request(App.serviceurl+"characters", method: .get, parameters: parameters).responseJSON{ response in
            if let data = response.data{
                        
                    do{
                        let data = try JSONDecoder().decode(MCListCharactersResponse.self, from: data)
                        DispatchQueue.main.async {
                           
                            MCList.append(contentsOf: data.data.results)
                            tableView.reloadData()
                            print(MCList.count)
                       
                    }
                    }   catch{
                        print(error.localizedDescription)
                }
            }
            
        }
    }

}
