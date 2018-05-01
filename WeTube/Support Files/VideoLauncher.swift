//
//  VideoLauncher.swift
//  WeTube
//
//  Created by b3 on 3/18/18.
//  Copyright © 2018 b3. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView {
 
    
    //Vars
    let controlsView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 1)
        
        return view
    }()
    
    var player: AVPlayer?
    
    var isPlaying = false
    
    let videoLengthLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .right
        label.text = "00:00"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 14)
//        label.backgroundColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let videoSlider: UISlider = {
        let slider = UISlider()
        slider.minimumTrackTintColor = .red
        slider.maximumTrackTintColor = .white
        slider.setThumbImage(UIImage(named: "thumb"), for: .normal)
        slider.addTarget(self, action: #selector(handleSlider), for: .valueChanged)
        slider.translatesAutoresizingMaskIntoConstraints = false
        
        return slider
    }()
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        aiv.startAnimating()
        aiv.translatesAutoresizingMaskIntoConstraints = false
        
        return aiv
    }()
    
    lazy var ppButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "pause")
        button.setImage(image, for: .normal)
        button.tintColor = .white
        button.addTarget(self, action: #selector(handlePP), for: .touchUpInside)
        button.isHidden = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupPlayerView()
        
        controlsView.frame = self.frame
        addSubview(controlsView)
        controlsView.addSubview(activityIndicatorView)
        activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        activityIndicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        controlsView.addSubview(ppButton)
        ppButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        ppButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        ppButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        ppButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        controlsView.addSubview(videoLengthLabel)
        videoLengthLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8).isActive = true
        videoLengthLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        videoLengthLabel.widthAnchor.constraint(equalToConstant: 80).isActive = true
        videoLengthLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        
        controlsView.addSubview(videoSlider)
        videoSlider.rightAnchor.constraint(equalTo: videoLengthLabel.leftAnchor).isActive = true
        videoSlider.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        videoSlider.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        videoSlider.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        
        backgroundColor = .black
        
        
    }
    
    
    func setupPlayerView() {
        let urlString = "http://ibelian.com/Services/Videos/Norwegian%20Verbs%20app.mov"
        if let url = URL(string: urlString) {
            player = AVPlayer(url: url)
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            
            player?.play()
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
        }

    }
    
    @objc private func handlePP(sender: UIButton) {
        
        if isPlaying {
            sender.setImage(UIImage(named: "play"), for: .normal)
            player?.pause()
        } else {
            sender.setImage(UIImage(named: "pause"), for: .normal)
            player?.play()
        }
        isPlaying = !isPlaying
    }
    
    @objc private func handleSlider() {
        print(videoSlider.value)
        if let duration = player?.currentItem?.duration {
            let seconds = CMTimeGetSeconds(duration)
            let value = videoSlider.value * Float(seconds)
            let seekTime = CMTime(value: CMTimeValue(value), timescale: 1)
            player?.seek(to: seekTime, completionHandler: { (completed) in
                // ??
            })
            
        }
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "currentItem.loadedTimeRanges" {
            activityIndicatorView.stopAnimating()
            controlsView.backgroundColor = .clear
            ppButton.isHidden = false
            isPlaying = true
            
            if let duration = player?.currentItem?.duration {
                let seconds = CMTimeGetSeconds(duration)
                let sec = Int(seconds) % 60
                let min = String(format: "%02d", Int(seconds) / 60)
                videoLengthLabel.text = "\(min):\(sec)"
            }
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class VideoLauncher: NSObject {
    
    func showVideoPlayer() {
        if let keyWindow = UIApplication.shared.keyWindow {
            let view = UIView() 
            view.backgroundColor = .white
            view.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)
            
            keyWindow.addSubview(view)
            
            //videoPlayerView
            let videoPlayerHeight = keyWindow.frame.width * 9 / 16
            let videoPlayerFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: videoPlayerHeight)
            let videoPlayerView = VideoPlayerView(frame: videoPlayerFrame)
            
            view.addSubview(videoPlayerView)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                view.frame = keyWindow.frame
            }, completion: { (completed) in
                UIApplication.shared.setStatusBarHidden(true, with: .fade)
            })
        }
    }
}
