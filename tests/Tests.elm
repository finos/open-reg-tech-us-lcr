module Tests exposing (..)

import Expect
import Test exposing (Test, test)

testExpectTrue : Test
testExpectTrue =
    test "Expect.true test" <|
        \() ->
            True
                |> Expect.true "Expected true"


testExpectNotEqual : Test
testExpectNotEqual =
    test "Expect Not Equal" <|
        \() ->
            Expect.notEqual "foo" "foobar"