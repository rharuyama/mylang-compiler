(English below)
mylang（スタック計算機）からx86-64へのコンパイラをHaskellで書きました．
パーザくらいは追加するかもしれません．

### Build
ビルドするには，`stack`と`gcc`をインストールした上で，以下のコマンドを実行してください．ビルドは，環境によっては上手く動作しない可能性があります．
```
sh build.sh
```

`build.sh`は次のことを行います：

1. `source`というファイルを作成します（デフォルトでは，その中に`33 3 / 10 *`と書き込みます．これは中置記法では`(33 / 3) * 10`を意味します）．

2. コンパイラ本体である`mylang.hs`をコンパイルし，実行します．これは，`target.s`というアセンブリファイルを生成します．その中には，`source`ファイルの中に書かれた表現に対応するアセンブリプログラムが書かれているはずです．

3. `target.s`をアセンブルします．

4. 3の結果作成された実行ファイル`target`を実行します．

5. 4の結果を出力します（デフォルトでは，`110`になるはずです）．

スタック計算機を試してみる場合は，`build.sh`の中の
```
echo "33 3 / 10 *" > source
```
をコメントアウトして（行頭に`#`を付けて），`source`に逆ポーランド記法で表現を入力してください．

--

I wrote a compiler of a stack calculator (mylang) into x86-64 in Haskell. I might add a parser in the future.

### Build
To build your code using mylang, run the following command, installing `stack` and `gcc` in advance. Building might not work depending on your environment.
```
sh build.sh
```

`build.sh` does the following:

1. Generates file `source`. In default, it write `33 3 / 10 *` on it, which means `(33 / 3) * 10` in infix notation.

2. Compiles `mylang.hs`, which is compiler itself, and run it's executable. This generates assebly file named `target.s`. There must be a assebly program corresponding to the expression inside of `source`.

3. Assembles `target.s`.

4. Runs `target` generated in step 3.

5. Displays the result of step 4, which must be `110` in default.

If you want to try stack calculator, just comment out
```
echo "33 3 / 10 *" > source
```
in `build.sh`, and write an expression on `source` in RPN.