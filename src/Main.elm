module Main exposing (..)

{--

|> は使えるけど>>がいまいち使いこなせない
なんとなくで .member >> .id とか使ってるけどこいつは何者？

パイプと関数合成の違い(本を参照)
パイプは一つ処理をして次の処理に渡して〜を繰り返す
入力 -> 処理1 -> 途中結果(処理1の結果) -> 処理2 -> 途中結果(処理2の結果) -> 処理3 -> 出力(処理3の結果)
関数合成は処理を1つにまとめて一気に実行する
入力 -> (処理1 & 処理2 & 処理3) -> 出力

--}


type alias User =
    { name : String
    , age : Int
    }


user1 : User
user1 =
    { name = "Yuna"
    , age = 22
    }


user2 : User
user2 =
    { name = "Taro"
    , age = 15
    }


hello : User -> String
hello user =
    user.age
        |> (<) 18
        |> helloMessage


hello_ : User -> String
hello_ =
    helloMessage << (<) 18 << .age


helloMessage : Bool -> String
helloMessage isAdult =
    if isAdult then
        "ようこそ！"

    else
        "未成年は入れません。"



-- List Stringを受け取ってIntを返す関数 として捉えるとこう


maybeSample : List String -> Int
maybeSample arr =
    List.head arr
        |> Maybe.andThen String.toInt
        |> Maybe.map (\num -> num * 10)
        |> Maybe.withDefault 0



-- パイプ使っても関数合成で書いても一緒なんやな
-- List String -> Int を値として捉えるとこう


maybeSample2 : List String -> Int
maybeSample2 arr =
    (List.head >> Maybe.andThen String.toInt >> Maybe.map (\num -> num * 10) >> Maybe.withDefault 0) arr



-- 引数を省略できるのが嬉しいのか！！


maybeSample3 : List String -> Int
maybeSample3 =
    List.head >> Maybe.andThen String.toInt >> Maybe.map (\num -> num * 10) >> Maybe.withDefault 0



-- 結合の向きの話
{--
本の例のようにパイプの向きを左右混合にはできない
コンパイラもどっちの向きなのかわからないし、我々人間から見てもわからんです
カッコでくくれば大丈夫
もっと言うと向きを揃える書き方をすればいい
--}
