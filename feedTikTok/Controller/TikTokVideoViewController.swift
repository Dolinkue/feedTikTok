//
//  TikTokVideoViewController.swift
//  feedTikTok
//
//  Created by Nicolas Dolinkue on 22/01/2023.
//

import UIKit

class TikTokVideoViewController: UIViewController {
    
    private var collectionView: UICollectionView?
    
    private var data = [VideoModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        for _ in  0..<10 {
            let model = VideoModel(captiomn: "flow", userName: "Nico", audiotrackName: "ios sound", videoFileName: "video", videoFileFormat: "mov")
            data.append(model)
        }

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.size.width, height: view.frame.size.height)
        layout.sectionInset = UIEdgeInsets(top: 1, left: 0, bottom: 1, right: 0)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.isPagingEnabled = true
        collectionView?.dataSource = self
        collectionView?.register(VideoCollectionViewCell.self, forCellWithReuseIdentifier: VideoCollectionViewCell.identifier)
        view.addSubview(collectionView!)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }
    
}
extension TikTokVideoViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let model = data[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCollectionViewCell.identifier, for: indexPath) as! VideoCollectionViewCell
        
        cell.configure(with: model)
        
        return cell
    }
    
    
}
