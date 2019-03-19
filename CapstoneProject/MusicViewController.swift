//
//  MusicViewController.swift
//  CapstoneProject
//
//  Created by User on 2/21/19.
//  Copyright © 2019 User. All rights reserved.
//

import UIKit

class MusicViewController: UIViewController {

    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func launchSpotifyPlaylistOne(_ sender: UIButton)
    {
        let settingsUrl = NSURL(string: "https://open.spotify.com/playlist/75ARDXD31P1pM0jtVmc8eZ")! as URL
        UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
    }
    
    @IBAction func launchSpotifyPlaylistTwo(_ sender: UIButton)
    {
        let settingsUrl = NSURL(string: "https://open.spotify.com/playlist/4dJ8Ys2bOgWQIRvs7QSkeE")! as URL
        UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
    }
    
    @IBAction func launchYouTubePlaylistOne(_ sender: UIButton)
    {
        let settingsUrl = NSURL(string: "https://www.youtube.com/playlist?list=PLBhIAkl3-Iovo1Bbw-k_NXGus-RnG2FtN")! as URL
        UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
    }
    
    @IBAction func launchYouTubePlaylistTwo(_ sender: UIButton)
    {
        let settingsUrl = NSURL(string: "https://www.youtube.com/playlist?list=PLBhIAkl3-Iovud5DyiASzw83S6d0fwOT2")! as URL
        UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
