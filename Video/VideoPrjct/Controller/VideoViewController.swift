//
//  VideoViewController.swift
//  VideoPrjct
//
//  Created by Bimal@AppStation on 26/10/22.
//

import AVKit
import AVFoundation
import UIKit

class VideoViewController: UIViewController, VideoTableViewCelldelegate {
  
    @IBOutlet weak var tableView: UITableView!
    
    var videoArray = [VideoTableViewCellModel]()
    var isSelectCell = Bool()
    var currentTimePass: Float!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        let player1 = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "Earth", ofType: "mp4")!))
//        let player2 = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "surfing", ofType: "mp4")!))
//        let player3 = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "cartoon", ofType: "mp4")!))
//        let player4 = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "ocean", ofType: "mp4")!))
//        let player5 = AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "nature", ofType: "mp4")!))
//        videoArray = [player1,player2, player3, player4, player5 ]
        // Do any additional setup after loading the view.
        videoArray.append(contentsOf: [
            
            VideoTableViewCellModel(url: URL(fileURLWithPath: Bundle.main.path(forResource: "Series", ofType: "mp4")!), celltype: .videoCell),
            VideoTableViewCellModel(url: URL(fileURLWithPath: Bundle.main.path(forResource: "Tree", ofType: "mp4")!), celltype: .videoCell),
            VideoTableViewCellModel(url: URL(fileURLWithPath: Bundle.main.path(forResource: "forest", ofType: "mp4")!), celltype: .videoCell),
            VideoTableViewCellModel(url: URL(fileURLWithPath: Bundle.main.path(forResource: "Earth", ofType: "mp4")!), celltype: .videoCell),
            VideoTableViewCellModel(url: URL(fileURLWithPath: Bundle.main.path(forResource: "surfing", ofType: "mp4")!), celltype: .videoCell),
            VideoTableViewCellModel(url: URL(fileURLWithPath: Bundle.main.path(forResource: "cartoon", ofType: "mp4")!), celltype: .videoCell),
            VideoTableViewCellModel(url: URL(fileURLWithPath: Bundle.main.path(forResource: "ocean", ofType: "mp4")!), celltype: .videoCell),
            VideoTableViewCellModel(url: URL(fileURLWithPath: Bundle.main.path(forResource: "nature", ofType: "mp4")!), celltype: .videoCell),
            VideoTableViewCellModel(url: URL(fileURLWithPath: Bundle.main.path(forResource: "Ruins", ofType: "mp4")!), celltype: .videoCell),
            VideoTableViewCellModel(url: URL(fileURLWithPath: Bundle.main.path(forResource: "Autumnleaves", ofType: "mp4")!), celltype: .videoCell),
            VideoTableViewCellModel(url: URL(fileURLWithPath: Bundle.main.path(forResource: "Birds", ofType: "mp4")!), celltype: .videoCell),
            VideoTableViewCellModel(url: URL(fileURLWithPath: Bundle.main.path(forResource: "Waterhouse", ofType: "mp4")!), celltype: .videoCell),
            VideoTableViewCellModel(url: URL(fileURLWithPath: Bundle.main.path(forResource: "cartoon", ofType: "mp4")!), celltype: .videoCell),
            VideoTableViewCellModel(url: URL(fileURLWithPath: Bundle.main.path(forResource: "ocean", ofType: "mp4")!), celltype: .videoCell),

        ])
    }
//            VideoTableViewCellModel(avplayer: AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "Series", ofType: "mp4")!)), celltype: .videoCell),
//            VideoTableViewCellModel(avplayer: AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "Tree", ofType: "mp4")!)), celltype: .videoCell),
//            VideoTableViewCellModel(avplayer: AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "forest", ofType: "mp4")!)), celltype: .videoCell),
//            VideoTableViewCellModel(avplayer: AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "Earth", ofType: "mp4")!)), celltype: .videoCell),
//
//            VideoTableViewCellModel(avplayer: AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "surfing", ofType: "mp4")!)), celltype: .videoCell),
//            VideoTableViewCellModel(avplayer: AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "cartoon", ofType: "mp4")!)), celltype: .videoCell),
//            VideoTableViewCellModel(avplayer: AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "ocean", ofType: "mp4")!)), celltype: .videoCell),
//            VideoTableViewCellModel(avplayer: AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "nature", ofType: "mp4")!)), celltype: .videoCell),
//            VideoTableViewCellModel(avplayer: AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "Water", ofType: "mp4")!)), celltype: .videoCell),
//            VideoTableViewCellModel(avplayer: AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "Ruins", ofType: "mp4")!)), celltype: .videoCell),
//            VideoTableViewCellModel(avplayer: AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "Autumnleaves", ofType: "mp4")!)), celltype: .videoCell),
//            VideoTableViewCellModel(avplayer:  AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "Birds", ofType: "mp4")!)), celltype: .videoCell),
//            VideoTableViewCellModel(avplayer: AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "Waterhouse", ofType: "mp4")!)), celltype: .videoCell),
//            VideoTableViewCellModel(avplayer: AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "cartoon", ofType: "mp4")!)), celltype: .videoCell),
//
//            VideoTableViewCellModel(avplayer: AVPlayer(url: URL(fileURLWithPath: Bundle.main.path(forResource: "ocean", ofType: "mp4")!)), celltype: .videoCell)
//
//    ])
//}
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.handleScroll()
    }
    

    
//    override func viewWillDisappear(_ animated: Bool) {
//        if let visiblePaths = self.tableView.indexPathsForVisibleRows {
//            for i in visiblePaths  {
//                let cell = tableView.cellForRow(at: i) as? VideoTableViewCell
//                cell?.player?.pause()
//
//            }
//        }
//
//    }
    
    func buttonActionPlayPause(sender: UIButton) {
//        for video in videoArray {
//            if video.isSelected == true {
//                video.isSelected = false
//            }
//            else {
//                video.isSelected = true
//            }
//        }
//        handleScroll()
    }
    
}

extension VideoViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellModel = videoArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: cellModel.identifier, for: indexPath) as! VideoTableViewCell
//        view.sendSubviewToBack(cell.playerView)
        cell.cellModel = cellModel
       
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // 1.  pause all cells
        for model in videoArray {
            AVPlayer(url: model.url).pause()
        }
        
        // 2. current selcted video cell
        let cell = tableView.cellForRow(at: indexPath) as? VideoTableViewCell
        cell?.player?.pause()
        
        let currenttime = cell?.player?.currentTime()
        let videoModel = videoArray[indexPath.row]
        
        isSelectCell = true
//
        let selectedItem = indexPath
        print (selectedItem.row)
//
//
//        let cellModel = videoArray[indexPath.row]
//        if videoModel.isSelected == true {
//            videoModel.isSelected = false
//        }
//        else {
//            videoModel.isSelected = true
//        }
//        handleScroll()
         performSegue(withIdentifier: "SelectedVideoViewController", sender: (videoModel,currenttime))
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
       
        if (segue.identifier == "SelectedVideoViewController") {
            let model = sender as! (VideoTableViewCellModel,CMTime)
            if let selectedViewController = segue.destination as? SelectedVideoViewController {
                selectedViewController.player = AVPlayer(url: model.0.url)
                selectedViewController.currentTimeInSelectedVc = model.1
//                selectedViewController.player = model.player
//                selectedViewController.player.play()
            }
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.handleScroll()
    }
    
    func handleScroll() {
        
        if let indexPathsForVisibleRows = tableView.indexPathsForVisibleRows, indexPathsForVisibleRows.count > 0 {
            var focusCell: VideoTableViewCell?
            
            for indexPath in indexPathsForVisibleRows {
                let cellModel = videoArray[indexPath.row]
                if let cell = tableView.cellForRow(at: indexPath) as? VideoTableViewCell {
                    if focusCell == nil {
                        let rect = tableView.rectForRow(at: indexPath)
                        if tableView.bounds.contains(rect) {
                            
                            cell.player?.play()
                        
            
                            focusCell = cell
                        } else {
                            cell.player?.pause()
                            
//                            videoArray[indexPath.row].player.pause()
                        }
                    } else {
                        cell.player?.pause()
//                        videoArray[indexPath.row].player.pause()
                    }
                }
            }
        }
       
    }
}
