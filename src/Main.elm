module Main exposing (..)


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


helloMessage : Bool -> String
helloMessage isAdult =
    if isAdult then
        "ようこそ！"

    else
        "未成年は入れません。"



-- パイプで実装



hello1 : User -> String
hello1 user =
    -- helloMessage <| (<) 18 <| .age <| user
    user |> .age |> (<=) 18 |> helloMessage



-- 関数合成で実装 (パターン１)



hello2 : User -> String
hello2 user =
    -- (helloMessage << (<=) 18 << .age) user
    (.age >> (<=) 18 >> helloMessage) user



-- 関数合成で実装 (パターン２)



hello3 : User -> String
hello3 =
    -- helloMessage << (<) 18 << .age
    .age >> (<=) 18 >> helloMessage



-- Maybeの例
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
