# 電卓のコンパイラmylang

電卓のコンパイラをHaskellで書きました．`mylang`は，中置記法の項(例えば`7+5`)をx86-64へコンパイルします．

以下の説明では，環境としてMacを想定しています．その他のUnix系OSの場合は`docker`コマンドの前に`sudo`が必要な場合があります．

## Build

ビルドするには，`docker`をインストールした上で，`Dockerfile`があるディレクトリ`mylang`へ移動し，以下のコマンドを実行してください．ビルドは，環境によっては上手く動作しない可能性があります．

```
git clone https://github.com/rharuyama/mylang-compiler
cd mylang-compiler
docker build -t mylang-image .
docker run -it -d -v $(pwd):/home/ --name mylang mylang-image
docker exec -it mylang bash
```

コンテナ`mylang`の中に入るので，続けて次のコマンドを入力してください．

```
sh build.sh
```

筆者の環境だと，初めてビルドする時は2分半程かかりました．

`build.sh`は次のことを行います：

1. `source`というファイルを作成します（デフォルトでは，その中に`7 * 10 + 5 * 10`と書き込みます．）．

2. コンパイラ本体である`mylang.hs`をコンパイルし，実行します．これは，`target.s`というアセンブリファイルを生成します．その中には，`source`ファイルの中に書かれた項に対応するアセンブリプログラムが書かれているはずです．

3. `target.s`をアセンブルします．

4. 3の結果作成された実行ファイル`target`を実行します．

5. 4の結果を出力します（デフォルトでは，`120`になるはずです）．

自分で入力を変えてを試してみる場合は，`build.sh`の中の

```
echo "7 * 10 + 5 * 10" > source
```

をコメントアウトして（行頭に`#`を付けて），`source`に項を入力してください．

演算は四則演算が使えます．乗算と除算は，加算と減算より優先的に解釈されます．以下は`source`へ入力する項の例です．

```
7+2
10 - 3
10   * 9
100 / 10
2 * 2 + 10 / 5 - 1
```

注．演算子の優先順位が同じ場合，項の括弧は右結合です．例えば，`3+2-1`と書いた場合は`3+(2-1)`と解釈されます．これは少し不自然ですが，直す気力がないためそのままにしてあります．左結合にするには，また別のライブラリを使うそうです．
