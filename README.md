# 電卓のコンパイラmylang

（注．現在言語を四則演算のための電卓から拡張中のため，一部機能が壊れています（例えばビルドするとデフォルトで120が出力されるところなど）．ローカルで試す場合は[以前のバージョン](https://github.com/rharuyama/mylang-compiler/tree/3406371acb88d0b8e587d01ae9b41f4952e17741)をご使用ください．現在のバージョンでは，単項プラスと単項マイナス，比較演算子が使えます．現在のバージョンがちゃんと動くことは，`make test`で確かめられます．）

コンパイラをHaskellで書きました．`mylang`は，中置記法の項(例えば`7+5 <= 20`)をx86-64へコンパイルします．

以下の説明では，環境としてMacを想定しています．その他のUnix系OSの場合は`docker`コマンドの前に`sudo`が必要な場合があります．

## テスト

テストするには，`docker`をインストールした上で，`Dockerfile`があるディレクトリ`mylang`へ移動し，以下のコマンドを実行してください．

```
git clone https://github.com/rharuyama/mylang-compiler
cd mylang-compiler
docker build -t mylang-image .
docker run -it -d -v $(pwd):/home/ --name mylang mylang-image
docker exec -it mylang bash
```

するとコンテナ`mylang`の中に入るので，続けて次のコマンドを入力してください．

```
make test
```

筆者の環境だと，初めての時は2分半程かかりました．

乗算と除算は，加算と減算より優先的に解釈されます．以下は`source`へ入力する項の例です．式が真の時に1，偽の時0にを出力します．

```
2 <= 1
7 <= 7
-(3+5) + 10<=3 
1 >= 3
6 >= -3*+5 + 20
```

注1．演算子の優先順位が同じ場合，項の括弧は右結合です．例えば，`3+2-1`と書いた場合は`3+(2-1)`と解釈されます．これは少し不自然ですが，直す気力がないためそのままにしてあります．左結合にするには，[この方法](https://kazu-yamamoto.hatenablog.jp/entry/20110127/1296098875)を使うそうです．

注2．`build.sh`と`test.sh`は実行ファイルの実行を含むので，コンテナ内に入ってからでなければうまく実行できないことに注意してください．

## 参考文献
[低レイヤを知りたい人のためのCコンパイラ作成入門](https://www.sigbus.info/compilerbook)
