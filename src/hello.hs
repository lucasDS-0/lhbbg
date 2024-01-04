-- hello.hs

import Html
import Markup


main :: IO ()
main = putStrLn (render myhtml) 

myhtml :: Html
myhtml = html_ "Hello title" (h1_ "Heading" <> p_ "Paragraph #1" <> p_ "Paragraph #2")
