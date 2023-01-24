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
    private let captionNameLabel: UILabel = {
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
    
    private var playButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "play"), for: .normal)
        button.tintColor = .white
        return button
    }()
    private var likeButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "heart"), for: .normal)
        button.tintColor = .white
        return button
    }()
    private var commentButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "message"), for: .normal)
        button.tintColor = .white
        return button
    }()
    private var shareButton: UIButton = {
        let button = UIButton()
        button.setBackgroundImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.tintColor = .white
        return button
    }()
    
    private let videoContainer = UIView()
    
    
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
        contentView.addSubview(videoContainer)
        contentView.addSubview(videoNameLabel)
        contentView.addSubview(captionNameLabel)
        contentView.addSubview(audioNameLabel)
        
        contentView.addSubview(playButton)
        contentView.addSubview(likeButton)
        contentView.addSubview(commentButton)
        contentView.addSubview(shareButton)
        
        // actions
        
        likeButton.addTarget(self, action: #selector(didTapLikeButton), for: .touchDown)
        playButton.addTarget(self, action: #selector(didTapProfileButton), for: .touchDown)
        commentButton.addTarget(self, action: #selector(didTapCommentButton), for: .touchDown)
        shareButton.addTarget(self, action: #selector(didTapShareButton), for: .touchDown)
        
        videoContainer.clipsToBounds = true
        contentView.sendSubviewToBack(videoContainer)
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
        
        videoContainer.frame = contentView.bounds
        
        let size = contentView.frame.size.width/9
        let width = contentView.frame.size.width
        let height = contentView.frame.size.height - 100
        
        // button
        shareButton.frame = CGRect(x: width-size, y: height-(size)-10, width: 40, height: 40)
        commentButton.frame = CGRect(x: width-size, y: height-(size*2)-10, width: 40, height: 40)
        likeButton.frame = CGRect(x: width-size, y: height-(size*3)-10, width: 40, height: 40)
        playButton.frame = CGRect(x: width-size, y: height-(size*4)-10, width: 40, height: 40)
        
        // label
        audioNameLabel.frame = CGRect(x: 5, y: height-20, width: width-10, height: 50)
        captionNameLabel.frame = CGRect(x: 5, y: height-60, width: width-10, height: 50)
        videoNameLabel.frame = CGRect(x: 5, y: height-100, width: width-10, height: 50)
        
    }
    
    // con esto se corrige el error de reutilizar las celdas
    override func prepareForReuse() {
        super.prepareForReuse()
        captionNameLabel.text = nil
        audioNameLabel.text = nil
        videoNameLabel.text = nil
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: VideoModel) {
        self.model = model
        
        configureVideo()
        
        // labels
        captionNameLabel.text = model.captiomn
        audioNameLabel.text = model.audiotrackName
        videoNameLabel.text = model.userName
        
    }
    
    public func configureVideo() {
        
        guard let model = model else {return}
        
        guard let path = Bundle.main.path(forResource: model.videoFileName, ofType: model.videoFileFormat) else { return }
        
        let url = URL(fileURLWithPath: path)
        
        player = AVPlayer(url: url)
        
        let playerView = AVPlayerLayer()
        playerView.player = player
        playerView.frame = contentView.bounds
        playerView.videoGravity = .resizeAspectFill
        videoContainer.layer.addSublayer(playerView)
        
        player?.volume = 0.5
        player?.play()
    }
    
    
}
