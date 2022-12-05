//
//  SelectedVideoViewController.swift
//  VideoPrjct
//
//  Created by Bimal@AppStation on 31/10/22.
//

import AVKit
import AVFoundation
import UIKit

class SelectedVideoViewController: UIViewController {
    
    
    @IBOutlet weak var selectedPlayerView: UIView!
    @IBOutlet weak var progressSlider: UISlider!
    @IBOutlet weak var labelTimeRemaining: UILabel!
    @IBOutlet weak var imageViewInPlayPause: UIImageView!
    @IBOutlet weak var labelTotalTime: UILabel!
    
    var getModel: VideoTableViewCellModel!
    var player: AVPlayer!
    var timeObserver: Any?
    var timer: Timer?
    var currentTimeInSelectedVc: CMTime!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageViewInPlayPause.image = UIImage(named: "pause")
        print("currentTimeInSelectedVc =========> \(String(describing: currentTimeInSelectedVc!))")
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        let player = AVPlayer(url: getModel.player)
     
        setupVideoPlayer()
        resetTimer()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleControls))
        view.addGestureRecognizer(tapGesture)
    }

    
    func resetTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(hideControls), userInfo: nil, repeats: false)
    }
    
    @objc func hideControls() {
        imageViewInPlayPause.isHidden = true
        progressSlider.isHidden = true
        labelTimeRemaining.isHidden = true
        labelTotalTime.isHidden = true
    }
    
    func setupVideoPlayer() {
        
        player.seek(to: currentTimeInSelectedVc)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = selectedPlayerView.bounds
        playerLayer.videoGravity = .resizeAspect
        selectedPlayerView.layer.addSublayer(playerLayer)
        self.player.play()
        
        let interval = CMTime(seconds: 0.01, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        timeObserver = player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { elapsedTime in
            self.updateVideoPlayerState()
        })
    }
    
    @objc func toggleControls() {
        imageViewInPlayPause.isHidden = !imageViewInPlayPause.isHidden
        progressSlider.isHidden = !progressSlider.isHidden
        labelTimeRemaining.isHidden = !labelTimeRemaining.isHidden
        labelTotalTime.isHidden = !labelTotalTime.isHidden
        resetTimer()
    }
    
    func updateVideoPlayerState() {
        guard let currentTime = player?.currentTime() else { return }
        let currentTimeInSeconds = Float(CMTimeGetSeconds(currentTime))
       
        self.progressSlider.value = Float(currentTimeInSeconds)
        if let currentItem = player.currentItem {
            let duration = currentItem.duration
            if (CMTIME_IS_INVALID(duration)) {
                return;
            }
            let currentTime = currentItem.currentTime()
            self.progressSlider.value = Float(CMTimeGetSeconds(currentTime) / CMTimeGetSeconds(duration))
            
            // Update time remaining label
            let totalTimeInSeconds = CMTimeGetSeconds(duration)
            let remainingTimeInSeconds = Float(totalTimeInSeconds) - Float(currentTimeInSeconds)

            let mins = remainingTimeInSeconds / 60
            let secs = remainingTimeInSeconds.truncatingRemainder(dividingBy: 60)
            let timeformatter = NumberFormatter()
            timeformatter.minimumIntegerDigits = 2
            timeformatter.minimumFractionDigits = 0
            timeformatter.roundingMode = .down
            guard let minsStr = timeformatter.string(from: NSNumber(value: mins)), let secsStr = timeformatter.string(from: NSNumber(value: secs)) else {
                return
            }
            self.labelTimeRemaining.text = "\(minsStr):\(secsStr)"
            
            let totalTimeInSec = Float(totalTimeInSeconds)
            let min = totalTimeInSec / 60
            let sec = totalTimeInSec.truncatingRemainder(dividingBy: 60)
            guard let minsStrs = timeformatter.string(from: NSNumber(value: min)), let secsStrs = timeformatter.string(from: NSNumber(value: sec)) else {
                return
            }
            
            self.labelTotalTime.text = "\(minsStrs):\(secsStrs)"
            print("TimeRemainingLabel in SelectedVideoVc -----> \(String(describing: labelTimeRemaining.text!))")
        }
    }
    
    @IBAction func playPauseTapped(_ sender: UIButton) {
        guard let player = player else { return }
        if !player.isPlaying {
            player.play()
            imageViewInPlayPause.image = UIImage(named: "pause")
        } else {
            imageViewInPlayPause.image = UIImage(named: "play")
            player.pause()
        }
    }
    
    @IBAction func playbackSliderValueChanged(_ sender:UISlider)
    {
        guard let duration = player?.currentItem?.duration else { return }
        let value = Float64(progressSlider.value) * CMTimeGetSeconds(duration)
        let seekTime = CMTime(value: CMTimeValue(value), timescale: 1)
        player?.seek(to: seekTime)

    }
    
    
    @IBAction func buttonActionCloseArrow(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        player.pause()
    }
}

extension AVPlayer {
    var isPlaying: Bool {
        return rate != 0 && error == nil
    }
}

