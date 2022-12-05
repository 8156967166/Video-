//
//  VideoTableViewCell.swift
//  VideoPrjct
//
//  Created by Bimal@AppStation on 26/10/22.
//


import UIKit
import AVKit
import AVFoundation

protocol VideoTableViewCelldelegate {
//    func passCurrentTime(currentTimeInSecondsPass: Float)
    func buttonActionPlayPause(sender: UIButton)
}

class VideoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var playerView: UIView!
    @IBOutlet weak var progressSlider: UISlider!
    @IBOutlet weak var timeRemainingLabel: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var imagePlayPause: UIImageView!
    
    
    var delegate: VideoTableViewCelldelegate?
    var timer: Timer?
    var timeObserver: Any?
    
//    var playerLayer: AVPlayerLayer?
    var player : AVPlayer?
    
    var cellModel: VideoTableViewCellModel! {
        didSet {
            resetTimer()
            
            playerView.layer.sublayers?.forEach{$0.removeFromSuperlayer() }
            debugPrint("==>> \(playerView.layer.sublayers?.count ?? 0)")
    //        cell.playerLayer = AVPlayerLayer(player: videoArray[indexPath.row])
    //        cell.playerLayer?.frame = cell.playerView.bounds
    //        cell.playerLayer?.videoGravity = .resizeAspectFill
    //        cell.playerView.layer.addSublayer(cell.playerLayer!)
            
            player = AVPlayer(url: cellModel.url)
            let playerLayer = AVPlayerLayer(player: player)
            playerLayer.frame = bounds
            playerLayer.videoGravity = .resizeAspectFill
            layer.addSublayer(playerLayer)
            playerView.layer.addSublayer(playerLayer)
            
            let interval = CMTime(seconds: 0.01, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
            timeObserver = player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { elapsedTime in

//                 let currentTime = self.cellModel.currentTime().value
                let currentTimeInSeconds = Float(CMTimeGetSeconds(self.player!.currentTime()))
               print("currentTime --- \(self.player!.currentTime())")
                self.progressSlider.value = Float(currentTimeInSeconds)
                if let currentItem = self.player?.currentItem {
                    print("current Item ------ \(currentItem)")
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
                    self.timeRemainingLabel.text = "\(minsStr):\(secsStr)"
                    print("timeRemainingLabel =====> \(String(describing: self.timeRemainingLabel.text!))")
//                    self.delegate?.passCurrentTime(currentTimeInSecondsPass: currentTimeInSeconds)
                }
                
            })
            
//            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleControls))
//            playerView.addGestureRecognizer(tapGesture)
            
//            playerView.addSubview(progressSlider)
//            playerView.addSubview(timeRemainingLabel)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func resetTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(hideControls), userInfo: nil, repeats: false)
    }

    @objc func hideControls() {
//        progressSlider.isHidden = true
//        timeRemainingLabel.isHidden = true
    }
    
    @objc func toggleControls() {
        progressSlider.isHidden = !progressSlider.isHidden
        timeRemainingLabel.isHidden = !timeRemainingLabel.isHidden
        resetTimer()
    }
    
    @IBAction func playPauseTapped(sender: UIButton) {
        delegate?.buttonActionPlayPause(sender: playPauseButton)
    }
    
//    @IBAction func playPauseTapped(_ sender: UIButton) {
////        delegate?.buttonActionPlayPause(sender: playPauseButton)
//        guard let player = cellModel else { return }
//        if !player.isPlaying {
//            player.play()
////            playPauseButton.setImage(UIImage(named: "pause"), for: .normal)
//        } else {
////            playPauseButton.setImage(UIImage(named: "play"), for: .normal)
//            player.pause()
//        }
//    }
    
    @IBAction func playbackSliderValueChanged(_ sender:UISlider)
    {
        guard let duration = player?.currentItem?.duration else { return }
        let value = Float64(progressSlider.value) * CMTimeGetSeconds(duration)
        let seekTime = CMTime(value: CMTimeValue(value), timescale: 1)
        player?.seek(to: seekTime )
    }

}

//extension AVPlayer {
//    var isPlaying: Bool {
//        return rate != 0 && error == nil
//    }
//    var isSelectCell: Bool {
//        return false
//    }
//}
