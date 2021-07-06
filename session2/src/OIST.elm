module OIST exposing (..)

{-

   Rough copy of https://groups.oist.jp/grad

   Exercise: add
   * The three columns "Prospective Students", "Current Students", "Faculty and Staff" with pictures
   * The search bar "Search this Group"

-}

import Element as El exposing (Color, Element)
import Element.Background as Background
import Element.Font as Font
import Html exposing (Html)



-- COLORS


darkBlue : Color
darkBlue =
    El.fromRgb255 { red = 8, green = 78, blue = 126, alpha = 1 }


white : Color
white =
    El.fromRgb255 { red = 255, green = 255, blue = 255, alpha = 1 }


grey : Color
grey =
    El.fromRgb255 { red = 153, green = 153, blue = 153, alpha = 1 }


oistRed : Color
oistRed =
    El.fromRgb255 { red = 183, green = 37, blue = 37, alpha = 1 }



-- MAIN


main : Html msg
main =
    El.column [ El.width El.fill ]
        [ oistBanner
        , El.row [ El.spacing 30, El.padding 50 ] [ menu, body ]
        ]
        |> El.layout []


oistBanner : Element msg
oistBanner =
    El.image [ El.height (El.px 60) ]
        { src = "https://groups.oist.jp/sites/all/themes/oistgroups2016/images/oist-header-en.png"
        , description = "OIST Logo"
        }
        |> El.el [ Background.color oistRed, El.width El.fill ]


menu : Element msg
menu =
    menuItems
        |> List.map viewMenuItem
        |> El.column [ El.spacing 5, El.width (El.px 200) ]


menuItems : List String
menuItems =
    [ "For Prospective Students"
    , "For Current Students"
    , "For OIST Faculty and Staff"
    , "Academic Calendar"
    , "Student Recruiting"
    , "Science Education Outreach"
    , "Lists and Statistics"
    , "Graduate School Rules, etc."
    , "For Grad School Members"
    ]


viewMenuItem : String -> Element msg
viewMenuItem text =
    [ El.text text
        |> El.el
            [ Font.color white
            , El.padding 8
            ]
    , El.text "▽" |> El.el [ El.paddingXY 5 0 ]
    ]
        |> El.row
            [ El.spaceEvenly
            , Background.color grey
            , El.width El.fill
            , Font.size 12
            ]


body : Element msg
body =
    El.column [ El.spacing 10, El.width El.fill, El.alignTop ]
        [ El.text "Graduate School" |> El.el [ Font.size 20 ]
        , El.image [ El.width El.fill ]
            { src = "https://groups.oist.jp/sites/default/files/imce/u100437/D75_1184.jpg"
            , description = "OIST Building"
            }
        , welcomeMessage
        ]


welcomeMessage : Element msg
welcomeMessage =
    El.textColumn [ El.spacing 10, Font.size 12 ]
        [ El.paragraph [] [ El.text "Welcome to the OIST Graduate School website." ]
        , El.paragraph [] [ El.text "The mission of the Graduate School is to provide first-class postgraduate education to the highest international standard. We recognize every student as a unique individual in need of a personalized program that we provide through courses, independent study and extra-curricular activities." ]
        ]
