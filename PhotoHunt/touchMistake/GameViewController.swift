//
//  GameViewController.swift
//  touchMistake
//
//  Created by Shinichi Akimoto on 2017/11/3.
//  Copyright (c) 2017年 Shinichi Akimoto. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 640 x 1136サイズのゲームシーンを作ります
        let scene = GameScene(size:CGSize(width: 640, height:1136))
        // Main.storyboardのViewをSKViewとしてアクセスします
        let skView = self.view as! SKView
        // 画面のモードを、画面サイズにフィットするように拡大縮小するモードにします
        scene.scaleMode = .aspectFit
        // SKViewにそのシーンを表示します
        skView.presentScene(scene)
    }

    override var shouldAutorotate:Bool {
        return true
    }

    override var supportedInterfaceOrientations:UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden:Bool {
        return true
    }
}
