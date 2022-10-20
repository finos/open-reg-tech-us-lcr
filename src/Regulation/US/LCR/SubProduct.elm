module Regulation.US.LCR.SubProduct exposing (..)

import Regulation.US.LCR.MajorCentralBank exposing (MajorCentralBank)


type SubProduct
    = MajorCentralBank MajorCentralBank
    | OtherCentralBank
    | FHLBSystem
    | OtherGovernmentSponsoredEntity
    | CurrencyAndCoin
    | RehypothecatableUnencumbered
    | UnsettledRegularWay
    | UnsettledForward
    | Level1HQLA
    | Level2AHQLA
    | Level2BHQLA
