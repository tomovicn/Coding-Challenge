//
//  HotelsController.swift
//  Symphony
//
//  Created by Nikola Tomovic on 4/27/17.
//  Copyright © 2017 Nikola Tomovic. All rights reserved.
//

import UIKit
import AlamofireImage

enum CellType {
    case hotel
    case review
}

class HotelsController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var datSource = [(AnyObject, CellType)]()
    var hotels = [Hotel]()
    var favoriteHotels = [Hotel]()
    var reviews = [Review]() {
        didSet {
            
            datSource = hotels.map({ (hotel) -> (AnyObject, CellType) in
                return (hotel, CellType.hotel)
            })
            if oldValue.count > 0 {
                    var indexesToDelete = [IndexPath]()
                    for i in 1...oldValue.count {
                        indexesToDelete.append(IndexPath(row: selectedIndex! + i, section: 0))
                    }
                    tableView.deleteRows(at: indexesToDelete, with: .automatic)
            }
            
            setDataSource()
            var indexesToInsert = [IndexPath]()
            for i in 1...reviews.count {
                indexesToInsert.append(IndexPath(row: selectedIndex! + i, section: 0))
            }
            tableView.insertRows(at: indexesToInsert, with: .automatic)
        }
    }
    var isDataSourceFetched = false
    var isFavoriteHotelsFetched = false
    
    var hotelsService: HotelsService!
    var selectedIndex: Int? {
        didSet {
            if let previous = oldValue {
                previousSelectedIndex = previous
            }
        }
    }
    var previousSelectedIndex: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setVisuals()
        showProgressHUD()
        getDataSource()
        getFavorites()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setVisuals() {
        tableView.estimatedRowHeight = 250
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    //Fetching data
    func getDataSource() {
        hotelsService.getHotels(succes: { [weak self] (hotels) in
            self?.hotels = hotels
            self?.isDataSourceFetched = true
            self?.isFetchingFinished()
        }, failure: { [weak self] (error) in
            self?.hideProgressHUD()
            self?.showDialog("", message: error, cancelButtonTitle: "OK")
        })
    }
    
    func getFavorites() {
        hotelsService.getFavorites(succes: { [weak self] (hotels) in
                self?.favoriteHotels = hotels
                self?.isFavoriteHotelsFetched = true
                self?.isFetchingFinished()
            }, failure: { [weak self] (error) in
                self?.hideProgressHUD()
                self?.showDialog("", message: error, cancelButtonTitle: "OK")
        })
    }
    
    func getReviews(id: Int) {
        showProgressHUD()
        hotelsService?.getHotelReviews(id: id, succes: {[weak self] (reviews) in
            self?.hideProgressHUD()
            self?.reviews = reviews
        }, failure: {[weak self] (error) in
            self?.hideProgressHUD()
            self?.showDialog("", message: error, cancelButtonTitle: "OK")
        })
    }
    
    func isFetchingFinished() {
        if isFavoriteHotelsFetched && isDataSourceFetched {
            hideProgressHUD()
            setDataSource()
            tableView.reloadData()
        }
    }
    
    func setDataSource() {
        datSource.removeAll()
        if let selIndex = selectedIndex {
            for i in 0...selIndex {
                datSource.append((hotels[i], CellType.hotel))
            }
            for review in reviews {
                datSource.append((review, CellType.review))
            }
            if selIndex + 1 < hotels.count {
                for i in selIndex+1...hotels.count-1 {
                    datSource.append((hotels[i], CellType.hotel))
                }
            }
            
        } else {
            datSource = hotels.map({ (hotel) -> (AnyObject, CellType) in
                return (hotel, CellType.hotel)
            })
        }
    }

}

extension HotelsController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if datSource[indexPath.row].1 == .hotel {
            let hotel = datSource[indexPath.row].0 as! Hotel
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as HotelCell
            configure(cell: cell, hotel: hotel, indexPath: indexPath)
            cell.delegate = self
            
            return cell
        } else {
            let review = datSource[indexPath.row].0 as! Review
            let cell = tableView.dequeueReusableCell(indexPath: indexPath) as ReviewCell
            configureCell(cell: cell, review: review)
            return cell
        }
        
    }
    
    func configure(cell: HotelCell, hotel: Hotel, indexPath: IndexPath) {
        URLSession.shared.dataTask(with: URL(string: hotel.imageUrl!)!) { (data, response, error) in
            if data != nil {
                if let image = UIImage(data: data!) {
                    DispatchQueue.main.async {
                        if let hotelCell = self.tableView.cellForRow(at: indexPath) as? HotelCell {
                            hotelCell.imgView?.image = image
                        }
                    }
                }
            }
        }.resume()
        
        
        let name = hotel.name ?? ""
        let city = hotel.city ?? ""
        let country = hotel.country ?? ""
        var priceStr = "Price: "
        if let price = hotel.price {
            priceStr += String(price)
        }
        cell.lblInformations.text = name + "\n" + city +  "\n" + country + "\n" + priceStr
        cell.lblDescription.text = hotel.description
        cell.lblLikesDislikes.text = "Likes: " + String(hotel.likes!) + "       " + "Dislikes: " + String(hotel.dislikes!)
        
        if favoriteHotels.contains(hotel) {
            cell.btnFavorite.setImage(#imageLiteral(resourceName: "star_full"), for: .normal)
        } else {
            cell.btnFavorite.setImage(#imageLiteral(resourceName: "star_empty"), for: .normal)
        }
    }
    
    func configureCell(cell: ReviewCell, review: Review) {
        cell.lblAuthor.text = review.author?.firstName
        cell.lblMessage.text = review.message
        let likes = review.likes ?? 0
        let dislikes = review.dislikes ?? 0
        cell.lblLikesDislikes.text = "Likes: " + String(likes) + "    Dislikes: " + String(dislikes)
    }
    
}

extension HotelsController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if datSource[indexPath.row].1 == .hotel {
            selectedIndex = hotels.index(of: datSource[indexPath.row].0 as! Hotel)
            //selectedIndex = indexPath.row - ((selectedIndex ?? 0) < indexPath.row ? reviews.count : 0)
            let id = (datSource[indexPath.row].0 as! Hotel).id
            getReviews(id: id!)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        let delete = UITableViewRowAction(style: .normal, title: "Delete") { action, index in
            if self.datSource[indexPath.row].1 == .hotel {
                    self.datSource.remove(at: indexPath.row)
                    self.tableView.deleteRows(at: [indexPath], with: .automatic)
                }
        }
        delete.backgroundColor = .lightGray
        
        let share = UITableViewRowAction(style: .normal, title: "Share") { action, index in
            
        }
        share.backgroundColor = .blue
        
        return [delete, share]
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}

extension HotelsController: HotelCellDelegate {
    func favoritePressed(cell: HotelCell) {
        let index = (tableView.indexPath(for: cell)?.row)!
        let hotel = datSource[index].0 as! Hotel
        
        if favoriteHotels.contains(hotel) {
            hotelsService?.removeFromFavorites(id: hotel.id!, succes: {[unowned self] (message) in
                self.favoriteHotels.remove(at: self.favoriteHotels.index(of: hotel)!)
                cell.btnFavorite.setImage(#imageLiteral(resourceName: "star_empty"), for: .normal)
            }, failure: {[unowned self] (error) in
                self.showDialog("", message: error, cancelButtonTitle: "OK")
            })
            
        } else {
            
            hotelsService?.addToFavorites(id: hotel.id!, succes: {[unowned self] (message) in
                self.favoriteHotels.append(hotel)
                cell.btnFavorite.setImage(#imageLiteral(resourceName: "star_full"), for: .normal)
            }, failure: {[unowned self] (error) in
                self.showDialog("", message: error, cancelButtonTitle: "OK")
            })
            
        }
    }
}
