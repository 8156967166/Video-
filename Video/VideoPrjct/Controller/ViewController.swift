//
//  ViewController.swift
//  VideoPrjct
//
//  Created by Bimal@AppStation on 26/10/22.
//
import AVKit
import AVFoundation
import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let player = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "Earth", ofType: "mp4")!))
        let vc = AVPlayerViewController()
        vc.player = player
        present(vc, animated: true, completion: nil)
//        let layer = AVPlayerLayer(player: player)
//        layer.frame = view.bounds
//        layer.videoGravity = .resize
//        view.layer.addSublayer(layer)
////        player.volume = 0
//        player.play()
    }
}































//let path = Bundle.main.path(forResource: "Earth", ofType: "mp4")
//print(path)
//Embedding videos in a tableview cell
//For God’s sake, can you autoplay video in list? – iOS
