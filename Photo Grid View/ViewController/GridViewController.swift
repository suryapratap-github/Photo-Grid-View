//
//  GridViewController.swift
//  Photo Grid View
//
//  Created by Surya Pratap Singh on 18/08/21.
//

import UIKit
import SVProgressHUD

class GridViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var planetaryArray:[Planetary] = []
    let popView = UIView()
    var previewVC = PreviewViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        popView.frame = self.view.frame
        popView.backgroundColor = .black.withAlphaComponent(0.6)
        popView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(removeAnimate)))
        
        
        // API calling ...
        Utils().ShowLoader()
        APIManager().getPlanetary { [weak self] response, message in
            Utils().HideLoader()
            guard let strongSelf = self else { return }
            guard let array = response else { return }
            strongSelf.planetaryArray.removeAll()
            for dictionary in array {
                if let dict = dictionary as? [String : Any], dict["media_type"] as! String == "image" {
                    strongSelf.planetaryArray.append(Planetary(dictionary: dict))
                }
            }
            strongSelf.collectionView.reloadData()
        }
        
    }
    
}

//MARK: UICollectionView Delegate, DataSource, DelegateFlowLayout
extension GridViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return planetaryArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "GridCell", for: indexPath) as? GridCell else {
            return UICollectionViewCell()
        }
        
        let planetary = planetaryArray[indexPath.item]
        cell.imgView.loadImage(strUrl: planetary.url)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showAnimate()
        if let previewVC = self.storyboard?.instantiateViewController(withIdentifier: "PreviewViewController") as? PreviewViewController {
            previewVC.planetaryArray = self.planetaryArray
            previewVC.index = indexPath
            self.addChild(previewVC)
            previewVC.view.frame.size = CGSize(width: popView.frame.size.width-30.0, height: popView.frame.size.height/1.5)
            previewVC.view.center = popView.center
            popView.addSubview(previewVC.view)
            previewVC.didMove(toParent: self)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.size.width/3.0)-1.0, height: (collectionView.frame.size.width/3.0)-1.0)
    }
    
    func showAnimate() {
        self.view.addSubview(popView)
        self.popView.alpha = 1.0
    }
    
    @objc func removeAnimate() {
        NotificationCenter.default.post(name: NSNotification.Name("Close_popupView"), object: nil)
        self.popView.alpha = 0.0
        self.popView.removeFromSuperview()
    }
}

//MARK: GridCell
class GridCell: UICollectionViewCell {
    @IBOutlet weak var imgView: UIImageView!
}
