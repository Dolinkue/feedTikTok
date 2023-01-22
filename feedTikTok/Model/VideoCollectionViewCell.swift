//
//  VideoCollectionViewCell.swift
//  feedTikTok
//
//  Created by Nicolas Dolinkue on 22/01/2023.
//

import UIKit
import AVFoundation

protocol VideoCollectionViewCellDelegate: AnyObject {
   
    func didTapLikeButton(with model: VideoModel)
    
    func didTapProfileButton(with model: VideoModel)
    
    func didTapCommentButton(with model: VideoModel)
    
    func didTapShareButton(with model: VideoModel)
}

class VideoCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "VideoCollectionViewCell"
    
    private var model: VideoModel?
    
    // Labels
    private let videoNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    private let CaptionNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    private let audioNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .white
        return label
    }()
    
    // Buttons
    
    private var profileButton: UIButton = {
        let button = UIButton()
        
        return button
    }()
    private var likeButton: UIButton = {
        let button = UIButton()
        
        return button
    }()
    private var commentButton: UIButton = {
        let button = UIButton()
        
        return button
    }()
    private var shareButton: UIButton = {
        let button = UIButton()
        
        return button
    }()
    // Delegates
    
    var delegate: VideoCollectionViewCellDelegate?
    
    
    weak var player: AVPlayer?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .black
        contentView.clipsToBounds = true
        addSubview()
    }
    
    private func addSubview(){
        contentView.addSubview(videoNameLabel)
        contentView.addSubview(CaptionNameLabel)
        contentView.addSubview(audioNameLabel)
        
        contentView.addSubview(profileButton)
        contentView.addSubview(likeButton)
        contentView.addSubview(commentButton)
        contentView.addSubview(shareButton)
    }
    
    @objc private func didTapLikeButton () {
        guard let model = model else {return}
        delegate?.didTapLikeButton(with: model)
    }
    
    @objc private func didTapProfileButton () {
        guard let model = model else {return}
        delegate?.didTapProfileButton(with: model)
    }
    
    @objc private func didTapCommentButton () {
        guard let model = model else {return}
        delegate?.didTapCommentButton(with: model)
    }
    
    @objc private func didTapShareButton () {
        guard let model = model else {return}
        delegate?.didTapShareButton(with: model )
        
    }
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: VideoModel) {
        self.model = model
        
        configureVideo()
        
        
    }
    
    private func configureVideo() {
        
        guard let model = model else {return}
        
        guard let path = Bundle.main.path(forResource: model.videoFileName, ofType: model.videoFileFormat) else { return }
        
        let url = URL(fileURLWithPath: path)
        
        player = AVPlayer(url: url)
        
        let playerView = AVPlayerLayer()
        playerView.player = player
        playerView.frame = contentView.bounds
        playerView.videoGravity = .resizeAspectFill
        contentView.layer.addSublayer(playerView)
        player?.volume = 0
        player?.play()
    }
    
    
}
