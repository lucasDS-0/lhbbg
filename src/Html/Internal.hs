-- Html/Internal.hs

module Html.Internal where

-- * Types

newtype Html      = Html String
newtype Structure = Structure String
type Title        = String

-- * EDSL

html_ :: Title -> Structure -> Html
html_ title content = 
    Html (el "html" 
        (el "head" (el "title" (escape title)) 
            <> el "body" (getStructureString content)
        )
    )

p_ :: String -> Structure
p_ = Structure . el "p" . escape

h1_ :: String -> Structure
h1_ = Structure . el "h1" . escape

ul_ :: [Structure] -> Structure
ul_ = Structure . el "ul" . concat . map (el "li" . getStructureString)

ol_ :: [Structure] -> Structure
ol_ = Structure . el "ol" . concat . map (el "li" . getStructureString)

code_ :: String -> Structure
code_ = Structure . el "pre" . escape

append_ :: Structure -> Structure -> Structure
append_ (Structure s1) (Structure s2) = Structure (s1 <> s2)

-- * Render

render :: Html -> String
render (Html s) = s

-- * Utilities

el :: String -> String -> String
el tag content = "<" <> tag <> ">" <> content <> "</" <> tag <> ">"

getStructureString :: Structure -> String
getStructureString (Structure s) = s

escape :: String -> String
escape =
    let
        escapeChar c = case c of
            '<'  -> "&lt;"
            '>'  -> "&gt;"
            '&'  -> "&amp;"
            '"'  -> "&quot;"
            '\'' -> "&#39;"
            _    -> [c]
    in concat . map escapeChar
