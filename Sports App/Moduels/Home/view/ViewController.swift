//
//  ViewController.swift
//  Sports App
//
//  Created by Haneen Medhat on 16/05/2024.
//

import UIKit

class ViewController: UIViewController , UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout,
                      UICollectionViewDataSource {

    var sportArr = [sports]()
    
    var namesArray = ["footbale","basketboll","volly"]
    var imageArray = ["1","2","3","4"]
    
    @IBOutlet weak var collection: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.delegate = self
        collection.dataSource = self
       

        
        collection.register(UINib(nibName: "AllSportsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "AllSportsCollectionViewCell")
//        //Football, Basketball, Cricket, Hockey, Baseball, American Football

        sportArr.append(sports(name:"Football", image: UIImage(named:"3")!))
        sportArr.append(sports(name:"Basketball", image: UIImage(named:"2")!))
        sportArr.append(sports(name:"Cricket", image: UIImage(named:"3")!))
        sportArr.append(sports(name:"Hockey", image: UIImage(named:"2")!))
        sportArr.append(sports(name:"Baseball", image: UIImage(named:"3")!))
        sportArr.append(sports(name:"American Football", image: UIImage(named:"2")!))
        
    }
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sportArr.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AllSportsCollectionViewCell", for:indexPath) as! AllSportsCollectionViewCell
        let sport = sportArr[indexPath.row]
        cell.setUpCell(name: sport.name, photo: sport.image)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width * 0.49 , height: self.view.frame.width * 0.49)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 3
    }
    
}

struct sports{
    let name : String
    let image : UIImage
    //should make it as string i guess
}
