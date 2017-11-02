//
//  GameScene.swift
//  touchMistake
//
//  Created by Shinichi Akimoto on 2017/11/3.
//  Copyright (c) 2017年 Shinichi Akimoto. All rights reserved.
//

import SpriteKit
// ランダムを使う準備をします
import GameplayKit

class GameScene: SKScene {
    // ランダムを使う準備をします
    let randomSource = GKARC4RandomSource()
    // 間違い番号の変数を用意します
    var mistakeNo = 0
    
    // メッセージを表示するラベルノードを作ります
    let msgLabel = SKLabelNode(fontNamed: "HiraKakuProN-W3")
    var msg:String = "違う漢字をタッチしよう"
    // 漢字を入れるボール数を15個にします
    let ballMax = 15
    // ボールを入れておく配列を用意します
    var ballList:[SKShapeNode] = []
    // 問題を配列で用意します
    let correct = [
        "人","巳","氷","体","坂",
        "祝","間","困","理","科",
        "待","猫","鳥","楽","簿",
        "緑","塊","幕","態","微"]
    let mistake = [
        "入","己","水","休","板",
        "呪","問","因","埋","料",
        "侍","錨","烏","薬","薄",
        "縁","魂","慕","熊","徴"]
    // 問題の番号の変数を用意します
    var questionNo = 0
    
    override func didMove(to view: SKView) {
        // 物理シミュレーション空間を画面サイズで作ります
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        // 空間の周囲の反発力を少し上げます
        self.physicsBody?.restitution = 1.2
        // 背景を白にします
        self.backgroundColor = UIColor.white
        // メッセージラベルを表示します
        msgLabel.text = msg
        msgLabel.fontSize = 36
        msgLabel.fontColor = UIColor.red
        msgLabel.position = CGPoint(x: 320, y: 1080)
        self.addChild(msgLabel)
        
        newQuestion()
    }
    
    // 出題するメソッド
    func newQuestion() {
        // 問題番号を決めます
        questionNo = GKRandomSource.sharedRandom().nextInt(upperBound: correct.count)
        // 間違い番号を決めます
        mistakeNo = GKRandomSource.sharedRandom().nextInt(upperBound: ballMax)

        // ボールの配列をリセットします
        ballList = []
        // ballMax個のボールを作ります
        for loopID in 0..<ballMax {
            // ボールをシェイプノードで作ります
            let ball = SKShapeNode(circleOfRadius: 45)
            ball.fillColor = UIColor(red: 1.0, green: 0.9, blue: 0.6, alpha: 1.0)
            ball.position = CGPoint(x:loopID * 100 + 70, y: 1000)
            // シーンに表示します
            self.addChild(ball)
            // ボールの配列に追加します
            ballList.append(ball)
        
            // 漢字を表示するラベルノードを作ります
            let kanji = SKLabelNode(fontNamed: "HiraKakuProN-W6")
            // 問題の設定をします
            if loopID != mistakeNo {
                // もし、間違い番号でなけれ正解の漢字を表示
                kanji.text = correct[questionNo]
            } else {
                // もし、間違い番号ならば間違いの漢字を表示
                kanji.text = mistake[questionNo]
            }
            kanji.fontSize = 60
            kanji.fontColor = UIColor.black
            kanji.position = CGPoint(x:0, y: -25)
            // ボールに漢字を追加します
            ball.addChild(kanji)
    
            // 修正後
            // ボールを画面の上の方にランダムに配置します
            let wx = GKRandomSource.sharedRandom().nextInt(upperBound: 440) + 100
            let wy = GKRandomSource.sharedRandom().nextInt(upperBound: 200) + 800
            ball.position = CGPoint(x: wx, y: wy)
    
            // 円の物理シミュレーション物体を作って結びつけます
            ball.physicsBody = SKPhysicsBody(circleOfRadius: 45)
            // ボールの反発力を少し上げます
            ball.physicsBody?.restitution = 1.0
    
            // ランダムに回転させます
            let angle = CGFloat(randomSource.nextUniform() * 6.28)
            ball.zRotation = angle
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 1つのタッチ情報を取り出します
        for touch in touches {
            // タッチした位置にあるノードを全て調べます
            let location = touch.location(in: self)
            let touchNodes = self.nodes(at: location)
            // ノード1つ1つについて調べます
            for tNode in touchNodes {
                // ボールの配列と比較して
                for loopID in 0..<ballMax {
                    // タッチしたノードとボールが同じなら
                    if tNode == ballList[loopID] {
                        answerCheck(No: loopID)
                    break
                    }
                }
            }
        }
    }
    
    // チェックメソッド
    func answerCheck(No:Int) {
        // 番号が間違い番号なら正解、そうでないなら不正解を表示します
        if No == mistakeNo {
            msg = "正解！\(correct[questionNo])と\(mistake[questionNo])でした"
        } else {
            msg = "間違い。\(correct[questionNo])と\(mistake[questionNo])でした"
        }
        msgLabel.text = msg
        // 画面上のボールを削除します。
        for loopID in 0..<ballMax {
            ballList[loopID].removeFromParent()
        }
        // 次の問題を出題します
        newQuestion()
    }

    override func update(_ currentTime: CFTimeInterval) {
    }
}
