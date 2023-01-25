//
//  TikTokVideoViewController.swift
//  feedTikTok
//
//  Created by Nicolas Dolinkue on 22/01/2023.
//

import UIKit
import AVFoundation


class TikTokVideoViewController: UIViewController {
    
    private var collectionView: UICollectionView?
    
    private var data = [VideoModel]()
    
    
    var player: AVPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let model = VideoModel(captiomn: "flow", userName: "@Nico", audiotrackName: "ios sound", videoFileName: "video", videoFileFormat: "mov")
        let model2 = VideoModel(captiomn: "flow", userName: "@Carmela", audiotrackName: "video sound", videoFileName: "video2", videoFileFormat: "MP4")
        let model3 = VideoModel(captiomn: "flow", userName: "@Moro", audiotrackName: "video sound", videoFileName: "video3", videoFileFormat: "MP4")
        let model4 = VideoModel(captiomn: "flow", userName: "@Chira", audiotrackName: "video sound", videoFileName: "video4", videoFileFormat: "MP4")
        data.append(model)
        data.append(model2)
        data.append(model3)
        data.append(model4)
        
        print(data)
        

        // Do any additional setup after loading the view.
        view.backgroundColor = .systemBackground
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: view.frame.size.width, height: view.frame.size.height)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView?.isPagingEnabled = true
        collectionView?.dataSource = self
        collectionView?.delegate = self
        collectionView?.register(VideoCollectionViewCell.self, forCellWithReuseIdentifier: VideoCollectionViewCell.identifier)
        view.addSubview(collectionView!)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView?.frame = view.bounds
    }
    
}
extension TikTokVideoViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let model = data[indexPath.row]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCollectionViewCell.identifier, for: indexPath) as! VideoCollectionViewCell
        
        cell.configure(with: model)
        cell.delegate = self
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: view.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if let videoCell = cell as? VideoCollectionViewCell {
            let model = data[indexPath.item]
            if model.videoFileFormat != nil {
                if videoCell.isPlaying {
                    videoCell.player?.pause()
                    videoCell.player?.seek(to: CMTime.zero)
                }
                videoCell.player?.play()
                videoCell.isPlaying = true
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath)  {
        if let videoCell = cell as? VideoCollectionViewCell {
                let model = data[indexPath.item]
                if model.videoFileName != nil {
                    videoCell.player?.pause()
                    videoCell.isPlaying = false
                }
        }
    }
}

extension TikTokVideoViewController: VideoCollectionViewCellDelegate {
    func didTapLikeButton(with model: VideoModel) {
        print("like Profile")
    }
    
    func didTapProfileButton(with model: VideoModel) {
        print("see movie")
    }
    
    func didTapCommentButton(with model: VideoModel) {
        print("comment tap")
    }
    
    func didTapShareButton(with model: VideoModel) {
        print("share tap")
    }
    
}
