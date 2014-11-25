%% *MATLAB/Simulinkによる組込みビジョン入門（６）*
%
% *映像ストリーム処理 - Raspberry Pi編 -*
%
% 新潟大学　工学部　電気電子工学科　
% 村松　正吾
%

%%
% <part5.html Part5> |
% <index.html メニュー>

%% 
% *概要*
%
% 本演習では、Part5で作成したSimulink(R)モデル を Rasberry Pi に実装し、
% エクスターナルモードでのシミュレーションのほか、
% スタンドアロンで実行する方法について学ぶ。

%% Raspberry Pi 設定
% シングルボードコンピュータ Raspberry Pi への実装コードを
% Simulinkモデルを通じて生成することができる。
%
% 以下では、Raspberry Pi 用のサポートパッケージ
%
% * <http://jp.mathworks.com/help/simulink/ug/install-target-for-raspberry-pi-hardware.html Raspberry Pi>
%
% が既にインストールされている前提で話を進める。

%%
% <part6.html トップ> 

%% シミュレーションモデル
% まず、本演習 Part5 で作成した Simulink モデル videogradfilt を 
% Raspberry Pi 用に変更しよう。
%
% モデル videogradfilt を読み込み、 videogradfiltraspi として保存する。
%
%   open_system('videogradfilt')
%   save_system('videogradfilt','videogradfiltraspi')

%%
% Raspberry Pi 用の実装コード生成を行う Simulink モデルは、
% 全てのブロックがコード生成に対応している必要がある。
% さらに、各種入出力ブロックは Raspberry Pi 用のブロックライブラリから
% 選択して使用する必要がある。
%
% Raspbery Pi 用のブロックライブラリは、Similinkライブラリブラウザーから
%
% * Simulink Support Package for Raspberry Pi hardware
% 
% を選択すればよい。
%
% <<raspberrypi_blocks.png>>
%
% あるいは、MATLAB コマンドウィンドウ上から
%
%   raspberrypilib
% 
% と打ち込んでも良い。

%%
% 映像入出力ブロックを Raspberry Pi 用の入出力ブロックに置き換えよう。
%
% * 「From Multimedia File」「RGB to Gray」→ 「V4L2 Video Capture」
% * 「To Multimedia File」 → 「SDL Video Display」
%
% <<videogradfiltraspi_slx_00.png>>
%
% 「V4L2 Video Capture」ブロックの出力Yはグレースケールに対応する。
% 本モデルでは、残りの出力 Cb,Crを利用しないため、以下の終端ブロックを接続した。
%
% * <matlab:doc('simulink/terminator') Simulink/Commonly Used Blocks/Terminator>
%
% また、「SDL Video Display」ブロックでは RGB 入力ができるよう、
% ブロックパラメータ Pixel format を RGB と編集した。

%%
% 早速、実行してみよう。
%
% <<videogradfiltraspi_slx_01.png>>
%
% すると、「SDL Video Display」ブロックの入力部でデータ型の不一致による
% エラーが生じる。
%
% 原因は、「SDL Video Display」ブロックが8ビット符号なし整数型(uint8)を
% 要求するのに対し、「HSV to RGB」ブロックが実数型(double)でデータを出力
% するためである。
%
% この問題を回避するために、ゲイン調整をデータ型変換を行うブロック
%
% * <matlab:doc('simulink/gain') Simulink/Commonly Used Blocks/Gain>
% * <matlab:doc('simulink/datatpeconversion') Simulink/Commonly Used Blocks/Convert>
%
% を「SDL Video Display」ブロックの入力部に挿入し実行しよう。
%
% <<videogradfiltraspi_slx_02.png>>
%
% 無事実行され、ダミーの映像処理が実行される。  
%

%%
% <part6.html トップ> 

%% エクスターナルモード
% Raspberry Pi 用に構築したモデルを実際のボード上で動作させてみよう。
%
% Simulink モデルを Raspberry Pi 上で動作させる方法には、
%
% * エクスターナルモードシミュレーション
% * スタンドアロン実行
%
% の二種類がある。
%
% 水平垂直 置換
%
% Raspberry Pi にWEBカメラを接続
%
% エクスターナルモードで実行

%%
% [ツール] > [ターゲットハードウェアで実行 ] > [ファームウェアの更新... ]
% サポート パッケージ: [Raspberry Pi(Simulink)] > [次へ]
%
% [ツール] > [ターゲットハードウェアで実行 ] > [オプション ]
%

%%
% <part6.html トップ> 

%% 演算精度と速度評価
%
%

%%
% <part6.html トップ> 

%% Raspberry Pi スタンドアロン実装
%
% Raspberry Pi にWEBカメラとHDMIディスプレイを接続
%
% Copyright (c), All rights resereved, 2014, Shogo MURAMATSU
%

%%
% <part6.html トップ> 

%% 演習課題
%
% *演習課題6-1.* SOBEL勾配フィルタ
%
%%
% 
% *演習課題6-2.* フレーム差分
%

%%
% <html>
% <hr>
% </html>
%%
% <part5.html Part5> |
% <index.html メニュー>
% <part6.html トップ> 